import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class WeatherService {
  static const BASE_URL =
      'https://api.openweathermap.org/data/2.5/weather';
  final API_KEY = '';
  Future<WeatherModel> fetchWeather(String cityName) async {
    final url = Uri.parse('$BASE_URL?q=$cityName&appid=$API_KEY&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return WeatherModel.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
    
  Future<String> getCurrentCity() async {
   LocationPermission permission = await Geolocator.checkPermission();
   if (permission == LocationPermission.denied) {
     permission = await Geolocator.requestPermission();
     if (permission == LocationPermission.denied) {
       throw Exception('Location permissions are denied');
     }
   }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  
    List<Placemark> placemarks = await Geolocator.placemarkFromCoordinates(
        position.latitude, position.longitude);
  String? cityName = placemarks[0].locality ?? 'Unknown';
    return cityName ?? 'Unknown';
  }
  }
  }
  