import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'MainPage.dart';
import 'WeatherModel.dart';

class Weather extends StatefulWidget {
  final String cityName;
  const Weather({super.key,required this.cityName});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  @override
  void initState() {
    super.initState();
    fetch();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Weather ',
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            CircularProgressIndicator(
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
  Future<void> fetch() async {
    var result = await http
        .get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=${widget.cityName}&lang=en&&units=metric&appid=b3241b166a34277e9ff8b825b21d91c3"));
    WeatherModel weatherModel = WeatherModel.fromMap(jsonDecode(result.body));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)=>MainPage(cityWeather: weatherModel,)));
  }
}
