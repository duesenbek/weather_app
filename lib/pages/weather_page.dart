import 'package:flutter/material.dart';
import 'package:weather_app/service/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      final _weatherService = WeatherService(API_KEY);
      Weather? weather;
      _fetchWeather() async {
        String cityName = await _weatherService.getCurrentCity();
        try{
          weather = await _weatherService.fetchWeather(cityName);
          setState(){
            _weather = weather;
          }
        } catch (e) {
          print('Error fetching weather: $e');
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
          appBar: AppBar(
            title: Text('Weather App'),
          ),
          body: Center(
            child: weather == null
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weather!.cityName,
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${weather!.temperature} °C',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        weather!.description,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
          ),
        );
      }
   

    );
  }
}
