class WeatherSeasonItem {
  final String emoji;
  final String nameKey;
  final String category;

  const WeatherSeasonItem({
    required this.emoji,
    required this.nameKey,
    required this.category,
  });
}

class WeatherSeasonsData {
  WeatherSeasonsData._();

  static const List<WeatherSeasonItem> items = [
    WeatherSeasonItem(
        emoji: '☀️', nameKey: 'weather.names.sunny', category: 'weather'),
    WeatherSeasonItem(
        emoji: '🌧️', nameKey: 'weather.names.rainy', category: 'weather'),
    WeatherSeasonItem(
        emoji: '☁️', nameKey: 'weather.names.cloudy', category: 'weather'),
    WeatherSeasonItem(
        emoji: '💨', nameKey: 'weather.names.windy', category: 'weather'),
    WeatherSeasonItem(
        emoji: '⛈️', nameKey: 'weather.names.storm', category: 'weather'),
    WeatherSeasonItem(
        emoji: '❄️', nameKey: 'weather.names.snow', category: 'weather'),
    WeatherSeasonItem(
        emoji: '🌫️', nameKey: 'weather.names.fog', category: 'weather'),
    WeatherSeasonItem(
        emoji: '🥵', nameKey: 'weather.names.hotDay', category: 'weather'),
    WeatherSeasonItem(
        emoji: '🥶', nameKey: 'weather.names.coldDay', category: 'weather'),
    WeatherSeasonItem(
        emoji: '🌈', nameKey: 'weather.names.rainbow', category: 'weather'),
    WeatherSeasonItem(
        emoji: '🌩️', nameKey: 'weather.names.thunder', category: 'weather'),
    WeatherSeasonItem(
        emoji: '🌦️', nameKey: 'weather.names.drizzle', category: 'weather'),
    WeatherSeasonItem(
        emoji: '🌤️', nameKey: 'weather.names.clearSky', category: 'weather'),
    WeatherSeasonItem(
        emoji: '💧', nameKey: 'weather.names.humid', category: 'weather'),
    WeatherSeasonItem(
        emoji: '🧊', nameKey: 'weather.names.hail', category: 'weather'),
    WeatherSeasonItem(
        emoji: '🍃', nameKey: 'weather.names.breeze', category: 'weather'),
    WeatherSeasonItem(
        emoji: '🌸', nameKey: 'weather.names.spring', category: 'season'),
    WeatherSeasonItem(
        emoji: '🏖️', nameKey: 'weather.names.summer', category: 'season'),
    WeatherSeasonItem(
        emoji: '🍂', nameKey: 'weather.names.autumn', category: 'season'),
    WeatherSeasonItem(
        emoji: '⛄', nameKey: 'weather.names.winter', category: 'season'),
    WeatherSeasonItem(
        emoji: '☔', nameKey: 'weather.names.monsoon', category: 'season'),
  ];
}
