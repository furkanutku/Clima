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
      return '๐ฉ'; //thunder
    } else if (condition < 400) {
      return '๐ง'; //drizzle
    } else if (condition < 600) {
      return 'โ๏ธ'; //rain
    } else if (condition < 700) {
      return ' โ๏ธ'; //snow
    } else if (condition < 800) {
      return '๐ซ'; //clody
    } else if (condition == 800) {
      return '๐ '; //clear
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    print("$temp");
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp >= 20) {
      return 'Time for  ๐ฉณ and ๐';
    } else if (temp <= 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
