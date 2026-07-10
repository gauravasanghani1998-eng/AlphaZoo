class GreetingItem {
  final String emoji;
  final String nameKey;
  final String subtitleKey;

  const GreetingItem({
    required this.emoji,
    required this.nameKey,
    required this.subtitleKey,
  });
}

class GreetingsData {
  GreetingsData._();

  static const List<GreetingItem> items = [
    GreetingItem(
        emoji: '👋',
        nameKey: 'greetings.names.hello',
        subtitleKey: 'greetings.subtitles.hello'),
    GreetingItem(
        emoji: '🌅',
        nameKey: 'greetings.names.goodMorning',
        subtitleKey: 'greetings.subtitles.goodMorning'),
    GreetingItem(
        emoji: '🌞',
        nameKey: 'greetings.names.goodAfternoon',
        subtitleKey: 'greetings.subtitles.goodAfternoon'),
    GreetingItem(
        emoji: '🌆',
        nameKey: 'greetings.names.goodEvening',
        subtitleKey: 'greetings.subtitles.goodEvening'),
    GreetingItem(
        emoji: '🌙',
        nameKey: 'greetings.names.goodNight',
        subtitleKey: 'greetings.subtitles.goodNight'),
    GreetingItem(
        emoji: '😴',
        nameKey: 'greetings.names.sweetDreams',
        subtitleKey: 'greetings.subtitles.sweetDreams'),
    GreetingItem(
        emoji: '🙏',
        nameKey: 'greetings.names.thankYou',
        subtitleKey: 'greetings.subtitles.thankYou'),
    GreetingItem(
        emoji: '😊',
        nameKey: 'greetings.names.please',
        subtitleKey: 'greetings.subtitles.please'),
    GreetingItem(
        emoji: '😔',
        nameKey: 'greetings.names.sorry',
        subtitleKey: 'greetings.subtitles.sorry'),
    GreetingItem(
        emoji: '🙋',
        nameKey: 'greetings.names.excuseMe',
        subtitleKey: 'greetings.subtitles.excuseMe'),
    GreetingItem(
        emoji: '🤗',
        nameKey: 'greetings.names.youreWelcome',
        subtitleKey: 'greetings.subtitles.youreWelcome'),
    GreetingItem(
        emoji: '🤝',
        nameKey: 'greetings.names.niceToMeetYou',
        subtitleKey: 'greetings.subtitles.niceToMeetYou'),
    GreetingItem(
        emoji: '👋',
        nameKey: 'greetings.names.seeYouSoon',
        subtitleKey: 'greetings.subtitles.seeYouSoon'),
    GreetingItem(
        emoji: '❤️',
        nameKey: 'greetings.names.takeCare',
        subtitleKey: 'greetings.subtitles.takeCare'),
    GreetingItem(
        emoji: '🎉',
        nameKey: 'greetings.names.welcome',
        subtitleKey: 'greetings.subtitles.welcome'),
    GreetingItem(
        emoji: '🙂',
        nameKey: 'greetings.names.howAreYou',
        subtitleKey: 'greetings.subtitles.howAreYou'),
    GreetingItem(
        emoji: '😄',
        nameKey: 'greetings.names.imFine',
        subtitleKey: 'greetings.subtitles.imFine'),
    GreetingItem(
        emoji: '👏',
        nameKey: 'greetings.names.goodJob',
        subtitleKey: 'greetings.subtitles.goodJob'),
    GreetingItem(
        emoji: '🌟',
        nameKey: 'greetings.names.wellDone',
        subtitleKey: 'greetings.subtitles.wellDone'),
    GreetingItem(
        emoji: '🎂',
        nameKey: 'greetings.names.happyBirthday',
        subtitleKey: 'greetings.subtitles.happyBirthday'),
    GreetingItem(
        emoji: '🎄',
        nameKey: 'greetings.names.happyHolidays',
        subtitleKey: 'greetings.subtitles.happyHolidays'),
    GreetingItem(
        emoji: '🏆',
        nameKey: 'greetings.names.congratulations',
        subtitleKey: 'greetings.subtitles.congratulations'),
    GreetingItem(
        emoji: '🤒',
        nameKey: 'greetings.names.getWellSoon',
        subtitleKey: 'greetings.subtitles.getWellSoon'),
    GreetingItem(
        emoji: '🍀',
        nameKey: 'greetings.names.goodLuck',
        subtitleKey: 'greetings.subtitles.goodLuck'),
    GreetingItem(
        emoji: '🙋',
        nameKey: 'greetings.names.mayIHelpYou',
        subtitleKey: 'greetings.subtitles.mayIHelpYou'),
    GreetingItem(
        emoji: '🙇',
        nameKey: 'greetings.names.thankYouVeryMuch',
        subtitleKey: 'greetings.subtitles.thankYouVeryMuch'),
    GreetingItem(
        emoji: '🙋‍♂️',
        nameKey: 'greetings.names.excuseMePlease',
        subtitleKey: 'greetings.subtitles.excuseMePlease'),
    GreetingItem(
        emoji: '😢',
        nameKey: 'greetings.names.imSorry',
        subtitleKey: 'greetings.subtitles.imSorry'),
    GreetingItem(
        emoji: '👌',
        nameKey: 'greetings.names.noProblem',
        subtitleKey: 'greetings.subtitles.noProblem'),
    GreetingItem(
        emoji: '🤔',
        nameKey: 'greetings.names.pardonMe',
        subtitleKey: 'greetings.subtitles.pardonMe'),
    GreetingItem(
        emoji: '🤗',
        nameKey: 'greetings.names.longTimeNoSee',
        subtitleKey: 'greetings.subtitles.longTimeNoSee'),
    GreetingItem(
        emoji: '😊',
        nameKey: 'greetings.names.goodToSeeYou',
        subtitleKey: 'greetings.subtitles.goodToSeeYou'),
    GreetingItem(
        emoji: '🌞',
        nameKey: 'greetings.names.haveANiceDay',
        subtitleKey: 'greetings.subtitles.haveANiceDay'),
    GreetingItem(
        emoji: '🎉',
        nameKey: 'greetings.names.haveAGreatTime',
        subtitleKey: 'greetings.subtitles.haveAGreatTime'),
    GreetingItem(
        emoji: '🚌',
        nameKey: 'greetings.names.safeJourney',
        subtitleKey: 'greetings.subtitles.safeJourney'),
    GreetingItem(
        emoji: '🏠',
        nameKey: 'greetings.names.welcomeHome',
        subtitleKey: 'greetings.subtitles.welcomeHome'),
    GreetingItem(
        emoji: '🥺',
        nameKey: 'greetings.names.iMissYou',
        subtitleKey: 'greetings.subtitles.iMissYou'),
    GreetingItem(
        emoji: '❤️',
        nameKey: 'greetings.names.iLoveYou',
        subtitleKey: 'greetings.subtitles.iLoveYou'),
    GreetingItem(
        emoji: '🤗',
        nameKey: 'greetings.names.goodToHaveYou',
        subtitleKey: 'greetings.subtitles.goodToHaveYou'),
    GreetingItem(
        emoji: '👂',
        nameKey: 'greetings.names.pleaseListen',
        subtitleKey: 'greetings.subtitles.pleaseListen'),
    GreetingItem(
        emoji: '⏳',
        nameKey: 'greetings.names.pleaseWait',
        subtitleKey: 'greetings.subtitles.pleaseWait'),
    GreetingItem(
        emoji: '🚪',
        nameKey: 'greetings.names.comeInPlease',
        subtitleKey: 'greetings.subtitles.comeInPlease'),
    GreetingItem(
        emoji: '🪑',
        nameKey: 'greetings.names.sitDownPlease',
        subtitleKey: 'greetings.subtitles.sitDownPlease'),
    GreetingItem(
        emoji: '🧍',
        nameKey: 'greetings.names.standUpPlease',
        subtitleKey: 'greetings.subtitles.standUpPlease'),
    GreetingItem(
        emoji: '🙇‍♀️',
        nameKey: 'greetings.names.thankYouTeacher',
        subtitleKey: 'greetings.subtitles.thankYouTeacher'),
    GreetingItem(
        emoji: '👩‍🏫',
        nameKey: 'greetings.names.goodMorningTeacher',
        subtitleKey: 'greetings.subtitles.goodMorningTeacher'),
    GreetingItem(
        emoji: '👋',
        nameKey: 'greetings.names.goodBye',
        subtitleKey: 'greetings.subtitles.goodBye'),
    GreetingItem(
        emoji: '🕊️',
        nameKey: 'greetings.names.peaceBeWithYou',
        subtitleKey: 'greetings.subtitles.peaceBeWithYou'),
  ];
}
