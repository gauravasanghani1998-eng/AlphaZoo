class VehicleItem {
  final String emoji;
  final String nameKey;
  final String subtitleKey;

  const VehicleItem({
    required this.emoji,
    required this.nameKey,
    required this.subtitleKey,
  });
}

class VehiclesData {
  VehiclesData._();

  static const List<VehicleItem> items = [
    VehicleItem(
      emoji: '🚗',
      nameKey: 'vehicles.names.car',
      subtitleKey: 'vehicles.subtitles.car',
    ),
    VehicleItem(
      emoji: '🚌',
      nameKey: 'vehicles.names.bus',
      subtitleKey: 'vehicles.subtitles.bus',
    ),
    VehicleItem(
      emoji: '🚕',
      nameKey: 'vehicles.names.taxi',
      subtitleKey: 'vehicles.subtitles.taxi',
    ),
    VehicleItem(
      emoji: '🚓',
      nameKey: 'vehicles.names.policeCar',
      subtitleKey: 'vehicles.subtitles.policeCar',
    ),
    VehicleItem(
      emoji: '🛵',
      nameKey: 'vehicles.names.scooter',
      subtitleKey: 'vehicles.subtitles.scooter',
    ),
    VehicleItem(
      emoji: '🚲',
      nameKey: 'vehicles.names.bicycle',
      subtitleKey: 'vehicles.subtitles.bicycle',
    ),
    VehicleItem(
      emoji: '🏍️',
      nameKey: 'vehicles.names.motorcycle',
      subtitleKey: 'vehicles.subtitles.motorcycle',
    ),
    VehicleItem(
      emoji: '🚚',
      nameKey: 'vehicles.names.truck',
      subtitleKey: 'vehicles.subtitles.truck',
    ),
    VehicleItem(
      emoji: '🚒',
      nameKey: 'vehicles.names.fireTruck',
      subtitleKey: 'vehicles.subtitles.fireTruck',
    ),
    VehicleItem(
      emoji: '🚑',
      nameKey: 'vehicles.names.ambulance',
      subtitleKey: 'vehicles.subtitles.ambulance',
    ),
    VehicleItem(
      emoji: '🚂',
      nameKey: 'vehicles.names.train',
      subtitleKey: 'vehicles.subtitles.train',
    ),
    VehicleItem(
      emoji: '🚆',
      nameKey: 'vehicles.names.metro',
      subtitleKey: 'vehicles.subtitles.metro',
    ),
    VehicleItem(
      emoji: '🚜',
      nameKey: 'vehicles.names.tractor',
      subtitleKey: 'vehicles.subtitles.tractor',
    ),
    VehicleItem(
      emoji: '✈️',
      nameKey: 'vehicles.names.airplane',
      subtitleKey: 'vehicles.subtitles.airplane',
    ),
    VehicleItem(
      emoji: '🚁',
      nameKey: 'vehicles.names.helicopter',
      subtitleKey: 'vehicles.subtitles.helicopter',
    ),
    VehicleItem(
      emoji: '🛶',
      nameKey: 'vehicles.names.boat',
      subtitleKey: 'vehicles.subtitles.boat',
    ),
    VehicleItem(
      emoji: '🚢',
      nameKey: 'vehicles.names.ship',
      subtitleKey: 'vehicles.subtitles.ship',
    ),
  ];
}
