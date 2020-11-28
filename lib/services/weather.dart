import 'package:simple_weather_app/services/networking.dart';
import 'package:simple_weather_app/services/location.dart';
const apiKey = 'db37218d5a4e8a37a91458bb37596c81';
const  weatherURL='http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  double long;
  double lat;



  Future<dynamic> getCityWeather(String cityname)async{

    var cityNameURL='$weatherURL?q=$cityname&appid=$apiKey&units=metric';
    NetworkService networkService=NetworkService(cityNameURL);
    var weatherDataCity=await networkService.getDataWeather();
    return weatherDataCity;


  }

  Future<dynamic> getLocationWeather() async{

    Location location = Location();
    await location.getCurrentLocation();
    long = location.longitude;
    lat = location.latitude;
    String urlWeather='$weatherURL?lat=$lat&lon=$long&appid=$apiKey&units=metric';
    NetworkService networkService=NetworkService(urlWeather);
    var weatherData=await networkService.getDataWeather();
    return weatherData;


  }


  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
