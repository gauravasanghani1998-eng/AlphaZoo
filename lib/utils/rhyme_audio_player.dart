import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Plays bundled nursery-rhyme recordings from assets audio folders.
class RhymeAudioPlayer {
  RhymeAudioPlayer._();

  static AudioPlayer? _player;
  static bool _pluginReady = false;
  static final Set<String> _availableIds = {};
  static final Map<String, String> _sourceById = {};
  static String? _warmedLocaleKey;

  static bool isAvailable(String rhymeId) => _availableIds.contains(rhymeId);

  static bool get isPluginReady => _pluginReady;

  /// Must run after [WidgetsFlutterBinding.ensureInitialized]. Fixes
  /// MissingPluginException when the app was hot-reloaded after adding the plugin.
  static Future<bool> ensurePluginReady() async {
    if (_pluginReady) return true;
    try {
      _player ??= AudioPlayer();
      await _player!.setReleaseMode(ReleaseMode.stop);
      await _player!.setVolume(1.0);
      _pluginReady = true;
      return true;
    } on MissingPluginException {
      return false;
    } catch (e) {
      debugPrint('RhymeAudioPlayer init failed: $e');
      return false;
    }
  }

  /// Detects which rhyme ids have a bundled .mp3 or .ogg file.
  /// Skips re-scan when [localeKey] is unchanged.
  static Future<void> warmCache(
    Iterable<String> rhymeIds, {
    String? localeKey,
  }) async {
    if (localeKey != null && localeKey == _warmedLocaleKey) return;

    _availableIds.clear();
    _sourceById.clear();

    final folders = _foldersForLocale(localeKey);
    for (final id in rhymeIds) {
      for (final ext in ['mp3', 'ogg']) {
        for (final folder in folders) {
          final bundlePath = 'assets/audio/$folder/$id.$ext';
          try {
            await rootBundle.load(bundlePath);
            _availableIds.add(id);
            _sourceById[id] = 'audio/$folder/$id.$ext';
            break;
          } catch (_) {
            // Try next folder / extension.
          }
        }
        if (_availableIds.contains(id)) break;
      }
    }

    if (localeKey != null) _warmedLocaleKey = localeKey;
  }

  static List<String> _foldersForLocale(String? localeKey) {
    switch (localeKey) {
      case 'gu':
        return const ['gujarati', 'rhymes'];
      case 'hi':
        return const ['hindi', 'rhymes'];
      default:
        return const ['rhymes', 'hindi', 'gujarati'];
    }
  }

  static Stream<Duration> get positionStream {
    return _player?.onPositionChanged ?? const Stream.empty();
  }

  static Stream<PlayerState> get stateStream {
    return _player?.onPlayerStateChanged ?? const Stream.empty();
  }

  static Future<Duration?> get duration async {
    if (_player == null) return null;
    return _player!.getDuration();
  }

  static Future<PlayerState?> get state async {
    if (_player == null) return null;
    return _player!.state;
  }

  /// Returns false if plugin not ready or no file for [rhymeId].
  static Future<bool> play(String rhymeId) async {
    if (!_availableIds.contains(rhymeId)) return false;
    if (!await ensurePluginReady()) return false;

    final source = _sourceById[rhymeId];
    if (source == null) return false;

    await _player!.stop();
    await _player!.play(AssetSource(source));
    return true;
  }

  static Future<void> pause() async {
    await _player?.pause();
  }

  static Future<void> resume() async {
    await _player?.resume();
  }

  static Future<void> stop() async {
    if (_player != null) {
      await _player!.stop();
    }
  }
}
