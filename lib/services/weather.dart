import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';

const apiKey = '48ac36ef1119f9c6b5fbdb77adc52586';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class Weather {
  Future<dynamic> getWeatherLocation() async {
    Location location = Location();

    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        "$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    print(condition);
    if (condition < 300) {
      return '🌩'; //thunder
    } else if (condition < 400) {
      return '🌧'; //drizzle
    } else if (condition < 600) {
      return '☔️'; //rain
    } else if (condition < 700) {
      return ' ❄️'; //snow
    } else if (condition < 800) {
      return '🌫'; //clody
    } else if (condition == 800) {
      return '🟠'; //clear
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    print("$temp");
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp >= 20) {
      return 'Time for  🩳 and 👕';
    } else if (temp <= 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
