/// Good habits & hygiene content — categories and habit ids.
/// Display text comes from translations (`goodHabits.*`).
class GoodHabitCategory {
  final String id;
  final String emoji;
  final String titleKey;
  final String subtitleKey;
  final List<GoodHabitItem> habits;

  const GoodHabitCategory({
    required this.id,
    required this.emoji,
    required this.titleKey,
    required this.subtitleKey,
    required this.habits,
  });
}

class GoodHabitItem {
  final String id;
  final String categoryId;
  final String nameKey;

  const GoodHabitItem({
    required this.id,
    required this.categoryId,
    required this.nameKey,
  });
}

class GoodHabitsData {
  GoodHabitsData._();

  static const List<GoodHabitItem> _personalHygiene = [
    GoodHabitItem(
      id: 'brushTeeth',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.brushTeeth',
    ),
    GoodHabitItem(
      id: 'brushTeethTwice',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.brushTeethTwice',
    ),
    GoodHabitItem(
      id: 'washHands',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.washHands',
    ),
    GoodHabitItem(
      id: 'washHandsBeforeEating',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.washHandsBeforeEating',
    ),
    GoodHabitItem(
      id: 'washHandsAfterToilet',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.washHandsAfterToilet',
    ),
    GoodHabitItem(
      id: 'washHandsAfterPlaying',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.washHandsAfterPlaying',
    ),
    GoodHabitItem(
      id: 'washFace',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.washFace',
    ),
    GoodHabitItem(
      id: 'takeBath',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.takeBath',
    ),
    GoodHabitItem(
      id: 'shampooHair',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.shampooHair',
    ),
    GoodHabitItem(
      id: 'combHair',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.combHair',
    ),
    GoodHabitItem(
      id: 'trimNails',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.trimNails',
    ),
    GoodHabitItem(
      id: 'keepNailsClean',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.keepNailsClean',
    ),
    GoodHabitItem(
      id: 'wearCleanClothes',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.wearCleanClothes',
    ),
    GoodHabitItem(
      id: 'changeClothesDaily',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.changeClothesDaily',
    ),
    GoodHabitItem(
      id: 'wearCleanSocks',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.wearCleanSocks',
    ),
    GoodHabitItem(
      id: 'wearCleanShoes',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.wearCleanShoes',
    ),
    GoodHabitItem(
      id: 'keepHairClean',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.keepHairClean',
    ),
    GoodHabitItem(
      id: 'useSoapProperly',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.useSoapProperly',
    ),
    GoodHabitItem(
      id: 'useHandSanitizer',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.useHandSanitizer',
    ),
    GoodHabitItem(
      id: 'useHandkerchief',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.useHandkerchief',
    ),
    GoodHabitItem(
      id: 'coverMouthCoughing',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.coverMouthCoughing',
    ),
    GoodHabitItem(
      id: 'coverNoseSneezing',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.coverNoseSneezing',
    ),
    GoodHabitItem(
      id: 'throwTissueDustbin',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.throwTissueDustbin',
    ),
    GoodHabitItem(
      id: 'useToiletProperly',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.useToiletProperly',
    ),
    GoodHabitItem(
      id: 'flushToilet',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.flushToilet',
    ),
    GoodHabitItem(
      id: 'keepBathroomClean',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.keepBathroomClean',
    ),
    GoodHabitItem(
      id: 'washFeetBeforeSleep',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.washFeetBeforeSleep',
    ),
    GoodHabitItem(
      id: 'drinkCleanWater',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.drinkCleanWater',
    ),
    GoodHabitItem(
      id: 'keepBodyClean',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.keepBodyClean',
    ),
    GoodHabitItem(
      id: 'doNotSpit',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.doNotSpit',
    ),
    GoodHabitItem(
      id: 'keepEarsClean',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.keepEarsClean',
    ),
    GoodHabitItem(
      id: 'keepNoseClean',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.keepNoseClean',
    ),
    GoodHabitItem(
      id: 'useTowelAfterBath',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.useTowelAfterBath',
    ),
    GoodHabitItem(
      id: 'weatherClothes',
      categoryId: 'personalHygiene',
      nameKey: 'goodHabits.names.personalHygiene.weatherClothes',
    ),
  ];

  static const List<GoodHabitItem> _goodHabits = [
    GoodHabitItem(
      id: 'wakeUpEarly',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.wakeUpEarly',
    ),
    GoodHabitItem(
      id: 'sleepOnTime',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.sleepOnTime',
    ),
    GoodHabitItem(
      id: 'makeYourBed',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.makeYourBed',
    ),
    GoodHabitItem(
      id: 'brushBeforeSleeping',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.brushBeforeSleeping',
    ),
    GoodHabitItem(
      id: 'prayEveryDay',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.prayEveryDay',
    ),
    GoodHabitItem(
      id: 'exerciseDaily',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.exerciseDaily',
    ),
    GoodHabitItem(
      id: 'doYoga',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.doYoga',
    ),
    GoodHabitItem(
      id: 'readBooks',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.readBooks',
    ),
    GoodHabitItem(
      id: 'studyEveryDay',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.studyEveryDay',
    ),
    GoodHabitItem(
      id: 'finishHomework',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.finishHomework',
    ),
    GoodHabitItem(
      id: 'packSchoolBag',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.packSchoolBag',
    ),
    GoodHabitItem(
      id: 'organizeSchoolBag',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.organizeSchoolBag',
    ),
    GoodHabitItem(
      id: 'keepThingsOrganized',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.keepThingsOrganized',
    ),
    GoodHabitItem(
      id: 'putToysBack',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.putToysBack',
    ),
    GoodHabitItem(
      id: 'cleanStudyTable',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.cleanStudyTable',
    ),
    GoodHabitItem(
      id: 'completeWorkOnTime',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.completeWorkOnTime',
    ),
    GoodHabitItem(
      id: 'beResponsible',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.beResponsible',
    ),
    GoodHabitItem(
      id: 'beHonest',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.beHonest',
    ),
    GoodHabitItem(
      id: 'beKind',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.beKind',
    ),
    GoodHabitItem(
      id: 'beHelpful',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.beHelpful',
    ),
    GoodHabitItem(
      id: 'bePatient',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.bePatient',
    ),
    GoodHabitItem(
      id: 'smileEveryDay',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.smileEveryDay',
    ),
    GoodHabitItem(
      id: 'thinkPositively',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.thinkPositively',
    ),
    GoodHabitItem(
      id: 'respectNature',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.respectNature',
    ),
    GoodHabitItem(
      id: 'respectAnimals',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.respectAnimals',
    ),
    GoodHabitItem(
      id: 'followRules',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.followRules',
    ),
    GoodHabitItem(
      id: 'followDailyRoutine',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.followDailyRoutine',
    ),
    GoodHabitItem(
      id: 'bePunctual',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.bePunctual',
    ),
    GoodHabitItem(
      id: 'stayActive',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.stayActive',
    ),
    GoodHabitItem(
      id: 'avoidLaziness',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.avoidLaziness',
    ),
    GoodHabitItem(
      id: 'listenCarefully',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.listenCarefully',
    ),
    GoodHabitItem(
      id: 'askQuestionsPolitely',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.askQuestionsPolitely',
    ),
    GoodHabitItem(
      id: 'learnNewThings',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.learnNewThings',
    ),
    GoodHabitItem(
      id: 'practiceEveryDay',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.practiceEveryDay',
    ),
    GoodHabitItem(
      id: 'beThankful',
      categoryId: 'goodHabits',
      nameKey: 'goodHabits.names.goodHabits.beThankful',
    ),
  ];

  static const List<GoodHabitItem> _healthyEating = [
    GoodHabitItem(
      id: 'eatHealthyFood',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.eatHealthyFood',
    ),
    GoodHabitItem(
      id: 'eatFreshFruits',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.eatFreshFruits',
    ),
    GoodHabitItem(
      id: 'eatGreenVegetables',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.eatGreenVegetables',
    ),
    GoodHabitItem(
      id: 'drinkMilk',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.drinkMilk',
    ),
    GoodHabitItem(
      id: 'drinkPlentyWater',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.drinkPlentyWater',
    ),
    GoodHabitItem(
      id: 'eatBreakfastDaily',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.eatBreakfastDaily',
    ),
    GoodHabitItem(
      id: 'eatOnTime',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.eatOnTime',
    ),
    GoodHabitItem(
      id: 'washFruits',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.washFruits',
    ),
    GoodHabitItem(
      id: 'washVegetables',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.washVegetables',
    ),
    GoodHabitItem(
      id: 'washHandsBeforeMeals',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.washHandsBeforeMeals',
    ),
    GoodHabitItem(
      id: 'chewFoodProperly',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.chewFoodProperly',
    ),
    GoodHabitItem(
      id: 'eatSlowly',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.eatSlowly',
    ),
    GoodHabitItem(
      id: 'finishYourFood',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.finishYourFood',
    ),
    GoodHabitItem(
      id: 'dontWasteFood',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.dontWasteFood',
    ),
    GoodHabitItem(
      id: 'eatHomemadeFood',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.eatHomemadeFood',
    ),
    GoodHabitItem(
      id: 'avoidJunkFood',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.avoidJunkFood',
    ),
    GoodHabitItem(
      id: 'avoidTooManyChocolates',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.avoidTooManyChocolates',
    ),
    GoodHabitItem(
      id: 'avoidSoftDrinks',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.avoidSoftDrinks',
    ),
    GoodHabitItem(
      id: 'eatDryFruits',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.eatDryFruits',
    ),
    GoodHabitItem(
      id: 'eatProteinRich',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.eatProteinRich',
    ),
    GoodHabitItem(
      id: 'eatBalancedMeals',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.eatBalancedMeals',
    ),
    GoodHabitItem(
      id: 'drinkFreshJuice',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.drinkFreshJuice',
    ),
    GoodHabitItem(
      id: 'avoidTooMuchSugar',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.avoidTooMuchSugar',
    ),
    GoodHabitItem(
      id: 'avoidEatingWhileTv',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.avoidEatingWhileTv',
    ),
    GoodHabitItem(
      id: 'useSpoonProperly',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.useSpoonProperly',
    ),
    GoodHabitItem(
      id: 'sitProperlyEating',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.sitProperlyEating',
    ),
    GoodHabitItem(
      id: 'shareFood',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.shareFood',
    ),
    GoodHabitItem(
      id: 'thankYouAtTable',
      categoryId: 'healthyEating',
      nameKey: 'goodHabits.names.healthyEating.thankYouAtTable',
    ),
  ];

  static const List<GoodHabitItem> _cleanliness = [
    GoodHabitItem(
      id: 'throwGarbageDustbin',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.throwGarbageDustbin',
    ),
    GoodHabitItem(
      id: 'separateWetDry',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.separateWetDry',
    ),
    GoodHabitItem(
      id: 'keepRoomClean',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.keepRoomClean',
    ),
    GoodHabitItem(
      id: 'cleanToys',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.cleanToys',
    ),
    GoodHabitItem(
      id: 'cleanStudyTableHabit',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.cleanStudyTableHabit',
    ),
    GoodHabitItem(
      id: 'organizeBooks',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.organizeBooks',
    ),
    GoodHabitItem(
      id: 'organizeClothes',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.organizeClothes',
    ),
    GoodHabitItem(
      id: 'foldClothesNeatly',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.foldClothesNeatly',
    ),
    GoodHabitItem(
      id: 'arrangeShoes',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.arrangeShoes',
    ),
    GoodHabitItem(
      id: 'keepClassroomClean',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.keepClassroomClean',
    ),
    GoodHabitItem(
      id: 'keepHomeClean',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.keepHomeClean',
    ),
    GoodHabitItem(
      id: 'keepGardenClean',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.keepGardenClean',
    ),
    GoodHabitItem(
      id: 'cleanUpAfterPlaying',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.cleanUpAfterPlaying',
    ),
    GoodHabitItem(
      id: 'wipeSpilledWater',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.wipeSpilledWater',
    ),
    GoodHabitItem(
      id: 'recycleWaste',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.recycleWaste',
    ),
    GoodHabitItem(
      id: 'reuseItems',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.reuseItems',
    ),
    GoodHabitItem(
      id: 'saveWater',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.saveWater',
    ),
    GoodHabitItem(
      id: 'turnOffTap',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.turnOffTap',
    ),
    GoodHabitItem(
      id: 'saveElectricity',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.saveElectricity',
    ),
    GoodHabitItem(
      id: 'switchOffLights',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.switchOffLights',
    ),
    GoodHabitItem(
      id: 'switchOffFans',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.switchOffFans',
    ),
    GoodHabitItem(
      id: 'keepSurroundingsClean',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.keepSurroundingsClean',
    ),
    GoodHabitItem(
      id: 'doNotLitter',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.doNotLitter',
    ),
    GoodHabitItem(
      id: 'plantTrees',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.plantTrees',
    ),
    GoodHabitItem(
      id: 'waterPlants',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.waterPlants',
    ),
    GoodHabitItem(
      id: 'feedBirds',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.feedBirds',
    ),
    GoodHabitItem(
      id: 'careForPlants',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.careForPlants',
    ),
    GoodHabitItem(
      id: 'keepPublicPlacesClean',
      categoryId: 'cleanliness',
      nameKey: 'goodHabits.names.cleanliness.keepPublicPlacesClean',
    ),
  ];

  static const List<GoodHabitItem> _safety = [
    GoodHabitItem(
      id: 'wearHelmet',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.wearHelmet',
    ),
    GoodHabitItem(
      id: 'wearSeatBelt',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.wearSeatBelt',
    ),
    GoodHabitItem(
      id: 'zebraCrossing',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.zebraCrossing',
    ),
    GoodHabitItem(
      id: 'lookLeftRight',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.lookLeftRight',
    ),
    GoodHabitItem(
      id: 'holdAdultHand',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.holdAdultHand',
    ),
    GoodHabitItem(
      id: 'followTrafficSignals',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.followTrafficSignals',
    ),
    GoodHabitItem(
      id: 'stayOnFootpath',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.stayOnFootpath',
    ),
    GoodHabitItem(
      id: 'doNotRunOnRoad',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.doNotRunOnRoad',
    ),
    GoodHabitItem(
      id: 'doNotPlayOnRoad',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.doNotPlayOnRoad',
    ),
    GoodHabitItem(
      id: 'doNotTalkToStrangers',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.doNotTalkToStrangers',
    ),
    GoodHabitItem(
      id: 'neverGoWithStrangers',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.neverGoWithStrangers',
    ),
    GoodHabitItem(
      id: 'knowParentsPhone',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.knowParentsPhone',
    ),
    GoodHabitItem(
      id: 'knowHomeAddress',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.knowHomeAddress',
    ),
    GoodHabitItem(
      id: 'stayWithParentsCrowds',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.stayWithParentsCrowds',
    ),
    GoodHabitItem(
      id: 'askPermissionGoing',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.askPermissionGoing',
    ),
    GoodHabitItem(
      id: 'carefulSharpObjects',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.carefulSharpObjects',
    ),
    GoodHabitItem(
      id: 'doNotTouchHot',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.doNotTouchHot',
    ),
    GoodHabitItem(
      id: 'doNotPlayWithFire',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.doNotPlayWithFire',
    ),
    GoodHabitItem(
      id: 'stayAwaySockets',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.stayAwaySockets',
    ),
    GoodHabitItem(
      id: 'doNotTouchWires',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.doNotTouchWires',
    ),
    GoodHabitItem(
      id: 'carefulNearWater',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.carefulNearWater',
    ),
    GoodHabitItem(
      id: 'wearLifeJacket',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.wearLifeJacket',
    ),
    GoodHabitItem(
      id: 'keepMedicinesAway',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.keepMedicinesAway',
    ),
    GoodHabitItem(
      id: 'doNotEatUnknown',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.doNotEatUnknown',
    ),
    GoodHabitItem(
      id: 'tellAdultIfSick',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.tellAdultIfSick',
    ),
    GoodHabitItem(
      id: 'callHelpEmergency',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.callHelpEmergency',
    ),
    GoodHabitItem(
      id: 'knowEmergencyNumbers',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.knowEmergencyNumbers',
    ),
    GoodHabitItem(
      id: 'followSchoolSafety',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.followSchoolSafety',
    ),
    GoodHabitItem(
      id: 'wearMaskWhenNeeded',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.wearMaskWhenNeeded',
    ),
    GoodHabitItem(
      id: 'washHandsAfterOutside',
      categoryId: 'safety',
      nameKey: 'goodHabits.names.safety.washHandsAfterOutside',
    ),
  ];

  static const List<GoodHabitItem> _goodManners = [
    GoodHabitItem(
      id: 'sayHello',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.sayHello',
    ),
    GoodHabitItem(
      id: 'sayGoodMorning',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.sayGoodMorning',
    ),
    GoodHabitItem(
      id: 'sayGoodAfternoon',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.sayGoodAfternoon',
    ),
    GoodHabitItem(
      id: 'sayGoodEvening',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.sayGoodEvening',
    ),
    GoodHabitItem(
      id: 'sayGoodNight',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.sayGoodNight',
    ),
    GoodHabitItem(
      id: 'sayGoodbye',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.sayGoodbye',
    ),
    GoodHabitItem(
      id: 'sayPlease',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.sayPlease',
    ),
    GoodHabitItem(
      id: 'sayThankYou',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.sayThankYou',
    ),
    GoodHabitItem(
      id: 'saySorry',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.saySorry',
    ),
    GoodHabitItem(
      id: 'excuseMe',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.excuseMe',
    ),
    GoodHabitItem(
      id: 'welcome',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.welcome',
    ),
    GoodHabitItem(
      id: 'knockBeforeEntering',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.knockBeforeEntering',
    ),
    GoodHabitItem(
      id: 'askBeforeTaking',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.askBeforeTaking',
    ),
    GoodHabitItem(
      id: 'raiseHandSpeaking',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.raiseHandSpeaking',
    ),
    GoodHabitItem(
      id: 'waitYourTurn',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.waitYourTurn',
    ),
    GoodHabitItem(
      id: 'listenWhenOthersSpeak',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.listenWhenOthersSpeak',
    ),
    GoodHabitItem(
      id: 'doNotInterrupt',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.doNotInterrupt',
    ),
    GoodHabitItem(
      id: 'speakSoftly',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.speakSoftly',
    ),
    GoodHabitItem(
      id: 'speakPolitely',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.speakPolitely',
    ),
    GoodHabitItem(
      id: 'respectParents',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.respectParents',
    ),
    GoodHabitItem(
      id: 'respectGrandparents',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.respectGrandparents',
    ),
    GoodHabitItem(
      id: 'respectTeachers',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.respectTeachers',
    ),
    GoodHabitItem(
      id: 'respectElders',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.respectElders',
    ),
    GoodHabitItem(
      id: 'respectFriends',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.respectFriends',
    ),
    GoodHabitItem(
      id: 'respectEveryone',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.respectEveryone',
    ),
    GoodHabitItem(
      id: 'shareToys',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.shareToys',
    ),
    GoodHabitItem(
      id: 'shareYourFood',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.shareYourFood',
    ),
    GoodHabitItem(
      id: 'helpFriends',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.helpFriends',
    ),
    GoodHabitItem(
      id: 'helpParents',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.helpParents',
    ),
    GoodHabitItem(
      id: 'helpElderly',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.helpElderly',
    ),
    GoodHabitItem(
      id: 'beFriendly',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.beFriendly',
    ),
    GoodHabitItem(
      id: 'beCaring',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.beCaring',
    ),
    GoodHabitItem(
      id: 'gentleWithAnimals',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.gentleWithAnimals',
    ),
    GoodHabitItem(
      id: 'congratulateOthers',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.congratulateOthers',
    ),
    GoodHabitItem(
      id: 'appreciateOthers',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.appreciateOthers',
    ),
    GoodHabitItem(
      id: 'acceptMistakes',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.acceptMistakes',
    ),
    GoodHabitItem(
      id: 'forgiveOthers',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.forgiveOthers',
    ),
    GoodHabitItem(
      id: 'keepPromises',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.keepPromises',
    ),
    GoodHabitItem(
      id: 'useMagicWords',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.useMagicWords',
    ),
    GoodHabitItem(
      id: 'smileWhileTalking',
      categoryId: 'goodManners',
      nameKey: 'goodHabits.names.goodManners.smileWhileTalking',
    ),
  ];

  static const List<GoodHabitItem> _environment = [
    GoodHabitItem(
      id: 'plantTreesEnv',
      categoryId: 'environment',
      nameKey: 'goodHabits.names.environment.plantTreesEnv',
    ),
    GoodHabitItem(
      id: 'waterPlantsEnv',
      categoryId: 'environment',
      nameKey: 'goodHabits.names.environment.waterPlantsEnv',
    ),
    GoodHabitItem(
      id: 'savePaper',
      categoryId: 'environment',
      nameKey: 'goodHabits.names.environment.savePaper',
    ),
    GoodHabitItem(
      id: 'useBothSidesPaper',
      categoryId: 'environment',
      nameKey: 'goodHabits.names.environment.useBothSidesPaper',
    ),
    GoodHabitItem(
      id: 'recyclePlastic',
      categoryId: 'environment',
      nameKey: 'goodHabits.names.environment.recyclePlastic',
    ),
    GoodHabitItem(
      id: 'keepNatureClean',
      categoryId: 'environment',
      nameKey: 'goodHabits.names.environment.keepNatureClean',
    ),
    GoodHabitItem(
      id: 'protectAnimals',
      categoryId: 'environment',
      nameKey: 'goodHabits.names.environment.protectAnimals',
    ),
    GoodHabitItem(
      id: 'avoidWastingWater',
      categoryId: 'environment',
      nameKey: 'goodHabits.names.environment.avoidWastingWater',
    ),
    GoodHabitItem(
      id: 'avoidWastingElectricity',
      categoryId: 'environment',
      nameKey: 'goodHabits.names.environment.avoidWastingElectricity',
    ),
  ];

  static const List<GoodHabitItem> _school = [
    GoodHabitItem(
      id: 'reachSchoolOnTime',
      categoryId: 'school',
      nameKey: 'goodHabits.names.school.reachSchoolOnTime',
    ),
    GoodHabitItem(
      id: 'wearCleanUniform',
      categoryId: 'school',
      nameKey: 'goodHabits.names.school.wearCleanUniform',
    ),
    GoodHabitItem(
      id: 'bringSchoolSupplies',
      categoryId: 'school',
      nameKey: 'goodHabits.names.school.bringSchoolSupplies',
    ),
    GoodHabitItem(
      id: 'completeClasswork',
      categoryId: 'school',
      nameKey: 'goodHabits.names.school.completeClasswork',
    ),
    GoodHabitItem(
      id: 'listenToTeacher',
      categoryId: 'school',
      nameKey: 'goodHabits.names.school.listenToTeacher',
    ),
    GoodHabitItem(
      id: 'followClassroomRules',
      categoryId: 'school',
      nameKey: 'goodHabits.names.school.followClassroomRules',
    ),
    GoodHabitItem(
      id: 'keepDeskClean',
      categoryId: 'school',
      nameKey: 'goodHabits.names.school.keepDeskClean',
    ),
    GoodHabitItem(
      id: 'respectSchoolProperty',
      categoryId: 'school',
      nameKey: 'goodHabits.names.school.respectSchoolProperty',
    ),
    GoodHabitItem(
      id: 'returnBorrowedBooks',
      categoryId: 'school',
      nameKey: 'goodHabits.names.school.returnBorrowedBooks',
    ),
    GoodHabitItem(
      id: 'helpClassmates',
      categoryId: 'school',
      nameKey: 'goodHabits.names.school.helpClassmates',
    ),
  ];

  static const List<GoodHabitCategory> categories = [
    GoodHabitCategory(
      id: 'personalHygiene',
      emoji: '🧼',
      titleKey: 'goodHabits.categories.personalHygiene.title',
      subtitleKey: 'goodHabits.categories.personalHygiene.subtitle',
      habits: _personalHygiene,
    ),
    GoodHabitCategory(
      id: 'goodHabits',
      emoji: '😊',
      titleKey: 'goodHabits.categories.goodHabits.title',
      subtitleKey: 'goodHabits.categories.goodHabits.subtitle',
      habits: _goodHabits,
    ),
    GoodHabitCategory(
      id: 'healthyEating',
      emoji: '🍎',
      titleKey: 'goodHabits.categories.healthyEating.title',
      subtitleKey: 'goodHabits.categories.healthyEating.subtitle',
      habits: _healthyEating,
    ),
    GoodHabitCategory(
      id: 'cleanliness',
      emoji: '🏡',
      titleKey: 'goodHabits.categories.cleanliness.title',
      subtitleKey: 'goodHabits.categories.cleanliness.subtitle',
      habits: _cleanliness,
    ),
    GoodHabitCategory(
      id: 'safety',
      emoji: '🚸',
      titleKey: 'goodHabits.categories.safety.title',
      subtitleKey: 'goodHabits.categories.safety.subtitle',
      habits: _safety,
    ),
    GoodHabitCategory(
      id: 'goodManners',
      emoji: '🤝',
      titleKey: 'goodHabits.categories.goodManners.title',
      subtitleKey: 'goodHabits.categories.goodManners.subtitle',
      habits: _goodManners,
    ),
    GoodHabitCategory(
      id: 'environment',
      emoji: '🌍',
      titleKey: 'goodHabits.categories.environment.title',
      subtitleKey: 'goodHabits.categories.environment.subtitle',
      habits: _environment,
    ),
    GoodHabitCategory(
      id: 'school',
      emoji: '📚',
      titleKey: 'goodHabits.categories.school.title',
      subtitleKey: 'goodHabits.categories.school.subtitle',
      habits: _school,
    ),
  ];
}
