import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Weather weather = Weather();
  String? cityName;
  String? weatherIcon;
  String? weatherText;
  int temperature = 0;
  int? condition;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(weatherData) {
    if (weatherData == null) {
      cityName = "";
      temperature = 0;
      weatherIcon = "null";
      weatherText = "Unable to get weather data";
      return;
    }
    setState(() {
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData["name"];
      double temp = weatherData["main"]["temp"];
      temperature = temp.toInt();
      weatherText = weather.getMessage(temperature);
      weatherIcon = weather.getWeatherIcon(condition!);

      // print(temperature);
      // print(weatherText);
      // print(weatherIcon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getWeatherLocation();
                      updateUI(weatherData);
                      // print(temperature);
                      // print(condition);

                      setState(() {});
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 70.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 70.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature ° ',
                      style: kTempTextStyle,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherText in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
