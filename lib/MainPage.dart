import 'package:flutter/material.dart';
import 'package:weather/CurrentLocation.dart';

import 'DataEntry.dart';
import 'WeatherModel.dart';

class MainPage extends StatefulWidget {
  final WeatherModel? cityWeather;
  const MainPage({super.key, required this.cityWeather});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late WeatherModel cityWeather;

  @override
  void initState() {
    super.initState();
    cityWeather = widget.cityWeather!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(cityWeather.name),
            Text(cityWeather.country),
            Text('${cityWeather.temp}°C'),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage('https://openweathermap.org/img/wn/${cityWeather.icon}@2x.png'),)
              ),
            ),
            Text('Humidity ${cityWeather.humidity}%'),
            Text(cityWeather.description.toUpperCase(),style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
            ),),
            Text('Min Temperature : ${cityWeather.tempMin}°C'),
            Text('Max Temperature : ${cityWeather.tempMax}°C'),
            SizedBox(height: 14,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DataEntry()));
            }, child: Text('Search City Weather')),
            SizedBox(height: 14,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CurrentLocation()));
            }, child: Text('Location Weather'))
          ],
        ),
      ),
    );
  }
}
