import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/rhyme_audio_lyrics.dart';
import '../../data/rhymes_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../../utils/rhyme_audio_player.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_rhyme_ui.dart';
import '../widgets/kid_section_header.dart';

enum _RhymePlayState { idle, playing, paused }
class RhymesScreen extends StatefulWidget {
  const RhymesScreen({super.key});

  @override
  State<RhymesScreen> createState() => _RhymesScreenState();
}

class _RhymesScreenState extends State<RhymesScreen> {
  String? _warmedLocale;

  List<RhymeItem> _itemsForLocale(BuildContext context) {
    return RhymesData.itemsForLocale(context.locale.languageCode);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = context.locale.languageCode;
    if (_warmedLocale == locale) return;
    _warmedLocale = locale;
    RhymeAudioPlayer.warmCache(
      _itemsForLocale(context).map((e) => e.id),
      localeKey: locale,
    ).then((_) {
      if (mounted) setState(() {});
    });
  }

  String _listDescription(BuildContext context) {
    if (RhymesData.showEnglishLocaleNote(context.locale.languageCode)) {
      return 'rhymes.descriptionLocale'.tr();
    }
    return 'rhymes.description'.tr();
  }

  @override
  Widget build(BuildContext context) {
    final items = _itemsForLocale(context);
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;
    final headerKey = RhymesData.headerKeyForLocale(context.locale.languageCode);

    return KidModuleScaffold(
      title: 'rhymes.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: '🎵',
              title: headerKey.tr(),
              subtitle: _listDescription(context),
            ),
            if (items.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🎶', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 6),
                        Text(
                          'rhymes.pickOne'.tr(
                            namedArgs: {'count': '${items.length}'},
                          ),
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            ...List.generate(items.length, (index) {
              final item = items[index];
              final color = AppColors.getLetterColor(index);
              final hasSong =
                  !item.ttsOnly && RhymeAudioPlayer.isAvailable(item.id);
              final preview =
                  RhymeAudioLyrics.linesFor(item.id)?.first ?? item.subtitle;
              return KidRhymeListCard(
                  emoji: item.emoji,
                  title: item.title,
                  preview: preview,
                  color: color,
                  hasSong: hasSong,
                  onTap: () {
                    AppHapticFeedback.medium();
                    Navigator.of(context).push(
                      PageRouteBuilder<void>(
                        pageBuilder: (context, animation, secondary) =>
                            RhymeDetailScreen(item: item, color: color),
                        transitionsBuilder:
                            (context, animation, secondary, child) {
                          final slide = Tween<Offset>(
                            begin: const Offset(0, 0.06),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          ));
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: slide,
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
            }),
          ],
        ),
      ),
    );
  }
}

class RhymeDetailScreen extends StatefulWidget {
  final RhymeItem item;
  final Color color;

  const RhymeDetailScreen({
    super.key,
    required this.item,
    required this.color,
  });

  @override
  State<RhymeDetailScreen> createState() => _RhymeDetailScreenState();
}

class _RhymeDetailScreenState extends State<RhymeDetailScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<PlayerState>? _stateSub;

  _RhymePlayState _playState = _RhymePlayState.idle;
  bool _isTtsMode = false;
  bool _ttsStopRequested = false;

  Duration? _songDuration;
  Duration _songPosition = Duration.zero;

  List<String> get _lines =>
      RhymeAudioLyrics.linesFor(widget.item.id) ?? [widget.item.title];

  String get _title => widget.item.title;

  bool get _isActive =>
      _playState == _RhymePlayState.playing ||
      _playState == _RhymePlayState.paused;

  List<List<int>> get _stanzaLineIndices {
    if (_lines.isEmpty) return const [];

    final result = <List<int>>[];
    var line = 0;
    for (final size in widget.item.stanzaSizes) {
      final stanza = <int>[];
      for (var i = 0; i < size && line < _lines.length; i++) {
        stanza.add(line);
        line++;
      }
      if (stanza.isNotEmpty) result.add(stanza);
    }

    if (line < _lines.length) {
      result.add([for (var i = line; i < _lines.length; i++) i]);
    }

    if (result.isEmpty) {
      result.add([for (var i = 0; i < _lines.length; i++) i]);
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _bounceAnimation = Tween<double>(begin: 0.92, end: 1.08).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );

    _positionSub = RhymeAudioPlayer.positionStream.listen(_onSongPosition);
    _stateSub = RhymeAudioPlayer.stateStream.listen(_onSongState);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || _playState != _RhymePlayState.idle) return;
      // Let the open animation finish, then start singing.
      await Future<void>.delayed(const Duration(milliseconds: 400));
      if (!mounted || _playState != _RhymePlayState.idle) return;
      await _startPlayback();
    });
  }

  @override
  void dispose() {
    _ttsStopRequested = true;
    _positionSub?.cancel();
    _stateSub?.cancel();
    RhymeAudioPlayer.stop();
    AppSpeech.stop();
    _bounceController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSongPosition(Duration position) {
    if (!_isActive || _isTtsMode || !mounted) return;
    setState(() => _songPosition = position);
  }

  void _onSongState(PlayerState state) {
    if (state == PlayerState.completed && mounted) {
      _finishPlayback();
    }
  }

  Future<void> _togglePlayback() async {
    if (_playState == _RhymePlayState.playing) {
      if (_isTtsMode) {
        _stopPlayback();
      } else {
        await RhymeAudioPlayer.pause();
        if (mounted) setState(() => _playState = _RhymePlayState.paused);
        AppHapticFeedback.light();
      }
      return;
    }

    if (_playState == _RhymePlayState.paused) {
      await RhymeAudioPlayer.resume();
      if (mounted) setState(() => _playState = _RhymePlayState.playing);
      AppHapticFeedback.medium();
      return;
    }

    AppHapticFeedback.medium();
    await _startPlayback();
  }

  Future<void> _startPlayback() async {
    final useTts = widget.item.ttsOnly ||
        !RhymeAudioPlayer.isAvailable(widget.item.id);

    if (useTts) {
      await _startTts();
      return;
    }

    if (!await RhymeAudioPlayer.ensurePluginReady()) {
      await _startTts();
      return;
    }

    setState(() {
      _playState = _RhymePlayState.playing;
      _isTtsMode = false;
      _songPosition = Duration.zero;
      _songDuration = null;
    });

    final started = await RhymeAudioPlayer.play(widget.item.id);
    if (!mounted) return;

    if (!started) {
      await _startTts();
      return;
    }

    final dur = await RhymeAudioPlayer.duration;
    if (mounted) {
      setState(() => _songDuration = dur);
    }
  }

  Future<void> _startTts() async {
    setState(() {
      _playState = _RhymePlayState.playing;
      _isTtsMode = true;
      _ttsStopRequested = false;
      _songPosition = Duration.zero;
      _songDuration = null;
    });

    await AppSpeech.speakRhyme(
      context,
      lines: _lines,
      stanzaSizes: widget.item.stanzaSizes,
      shouldStop: () => _ttsStopRequested || !mounted,
    );

    if (mounted) _finishPlayback();
  }

  void _stopPlayback() {
    _ttsStopRequested = true;
    RhymeAudioPlayer.stop();
    AppSpeech.stop();
    setState(() {
      _playState = _RhymePlayState.idle;
      _isTtsMode = false;
      _songPosition = Duration.zero;
    });
    AppHapticFeedback.light();
  }

  void _finishPlayback() {
    setState(() {
      _playState = _RhymePlayState.idle;
      _isTtsMode = false;
      _songPosition = Duration.zero;
    });
  }

  IconData get _mainButtonIcon {
    if (_playState == _RhymePlayState.playing) {
      return _isTtsMode ? Icons.stop_rounded : Icons.pause_rounded;
    }
    return Icons.play_arrow_rounded;
  }

  String get _playLabel {
    switch (_playState) {
      case _RhymePlayState.idle:
        return widget.item.ttsOnly || !RhymeAudioPlayer.isAvailable(widget.item.id)
            ? 'rhymes.listenSpoken'.tr()
            : 'rhymes.playSong'.tr();
      case _RhymePlayState.playing:
        return _isTtsMode ? 'rhymes.stopPoem'.tr() : 'rhymes.pauseSong'.tr();
      case _RhymePlayState.paused:
        return 'rhymes.resumeSong'.tr();
    }
  }

  String get _statusLabel {
    if (!_isActive) return '';
    return _isTtsMode ? 'rhymes.nowReading'.tr() : 'rhymes.nowSinging'.tr();
  }

  bool get _showEnglishNote {
    return _isActive &&
        !_isTtsMode &&
        RhymesData.showEnglishLocaleNote(context.locale.languageCode);
  }

  double? get _songProgress {
    if (!_isActive || _isTtsMode) return null;
    final dur = _songDuration;
    if (dur == null || dur.inMilliseconds <= 0) return null;
    return _songPosition.inMilliseconds / dur.inMilliseconds;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final poemFontSize = (responsive.width * 0.048).clamp(17.0, 22.0);
    final c = widget.color;
    final bouncing =
        _isActive && _playState == _RhymePlayState.playing;

    return Scaffold(
      body: KidRhymeBackdrop(
        gradientColors: rhymeDetailGradient(c),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(c),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.horizontalPadding,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      KidRhymeHeroStage(
                        emoji: widget.item.emoji,
                        color: c,
                        bounce: _bounceAnimation,
                        bouncing: bouncing,
                        singAlongLabel: 'rhymes.singAlong'.tr(),
                      ),
                      const SizedBox(height: 22),
                      KidRhymeLyricsBook(
                        color: c,
                        stanzaLineIndices: _stanzaLineIndices,
                        lines: _lines,
                        footerHint: 'rhymes.readTogether'.tr(),
                        fontSize: poemFontSize,
                      ),
                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),
              KidRhymePlayDock(
                color: c,
                mainIcon: _mainButtonIcon,
                playLabel: _playLabel,
                statusLabel: _statusLabel,
                showStatus: _isActive && _statusLabel.isNotEmpty,
                showEnglishNote: _showEnglishNote,
                englishNote: 'rhymes.songLyricsNote'.tr(),
                progress: _songProgress,
                onToggle: _togglePlayback,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(Color c) {
    final horizontalPad = context.responsive.horizontalPadding;

    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalPad, 8, horizontalPad, 4),
      child: Row(
        children: [
          Material(
            color: Colors.white.withValues(alpha: 0.22),
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                _stopPlayback();
                Navigator.of(context).pop();
              },
              customBorder: const CircleBorder(),
              child: const SizedBox(
                width: 36,
                height: 36,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 17,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                _title,
                style: AppTextStyles.heading3.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 36),
        ],
      ),
    );
  }
}
