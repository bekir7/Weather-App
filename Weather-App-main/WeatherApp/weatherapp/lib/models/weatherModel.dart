class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final num windSpeed;
  final String humidity;
  final String country;
  final String icon;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition,
      required this.windSpeed,
      required this.humidity,
      required this.country,
      required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      windSpeed: json['wind']['speed'],
      humidity: json['main']['humidity'].toString(),
      country: json['sys']['country'],
      icon: json['weather'][0]['icon'],
    );
  }
}
