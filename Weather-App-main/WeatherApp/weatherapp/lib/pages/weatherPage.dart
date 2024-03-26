import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weatherModel.dart';
import 'package:weatherapp/services/weatherService.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherService = WeatherService(apiKey: 'openweathermap api key');
  Weather? _weather;

  fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();

    try {
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'mist':
      case 'clouds':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/mist.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'snow':
        return 'assets/snow.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //color: Color.fromARGB(255, 90, 174, 230),
                //color: Colors.grey.shade600
              ),
              padding: EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weather?.cityName ?? "Şehir yükleniyor..",
                    style: GoogleFonts.lato(fontSize: 40),
                  ),
                  Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
                  Text(
                    '${_weather?.temperature.round()}°C',
                    style: GoogleFonts.lato(fontSize: 20),
                  ),
                  Text(
                    _weather?.mainCondition ?? "",
                    style: GoogleFonts.lato(fontSize: 22),
                  ),
                  Row(children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 50, horizontal: 60),
                      child: Container(
                        padding: EdgeInsets.only(top: 15),
                        width: 100,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromARGB(255, 90, 197, 230),
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.water_drop,
                                      color:
                                          const Color.fromARGB(255, 0, 38, 253),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text("Nem",
                                style: GoogleFonts.lato(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                )),
                            Text(
                              "${_weather?.humidity}%",
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      width: 100,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 90, 197, 230),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.wind_power,
                                    color: Color.fromARGB(255, 54, 54, 54),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text("Rüzgar Hızı",
                              style: GoogleFonts.lato(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )),
                          Text(
                            "${_weather?.windSpeed.floor()} m/s",
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
            )),
      ),
    );
  }
}
