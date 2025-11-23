import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService("3b6acab149469b1dbc5754ac337093a6");
  Weather? _weather;

  _fetchWeather() async{
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e){
      print(e);
    }
  }

  // weather animation
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null) return 'assets/sunny.json'; // default to sunny

    switch(mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return "assets/cloudy.json";
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // city name
            Text(_weather?.cityName ?? "loading city.."),

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // temperature
            Text("${_weather?.temperature.round()}°C"),

            // weather condition
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
