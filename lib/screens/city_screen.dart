import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:http/http.dart' as http;

const apiKey = '48ac36ef1119f9c6b5fbdb77adc52586';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  TextEditingController textController = TextEditingController();
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration:
                      const InputDecoration(hintText: "Search city or country"),
                  controller: textController,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              TextButton(
                onPressed: () async {
                  NetworkHelper networkHelper = NetworkHelper(
                      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric");
                  var cityData = await networkHelper.getData();
                  setState(() {
                    // var condition = cityData['weather'][0]['id'];

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LocationScreen(
                        locationWeather: cityData,
                      );
                    }));
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: const Text(
                    'Get Weather',
                    style: kButtonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
