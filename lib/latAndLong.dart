import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'DataEntry.dart';
import 'WeatherModel.dart';

class LatAndLog extends StatefulWidget {
  final String lat;
  final String lon;
  const LatAndLog({super.key,required this.lat,required this.lon});

  @override
  State<LatAndLog> createState() => _LatAndLogState();
}

class _LatAndLogState extends State<LatAndLog> {
  // Position? _currentLoc;
  Future<WeatherModel> fetch() async {
    var result = await http
        .get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${widget.lat}&lon=${widget.lon}&lang=en&&units=metric&appid=b3241b166a34277e9ff8b825b21d91c3"));
    return WeatherModel.fromMap(jsonDecode(result.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent.shade200,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   actions: [IconButton(onPressed: () async{
        //     Position position = await _getCurrentPosition();
        //     setState(() {
        //       _currentLoc = position;
        //     });
        //     print(_currentLoc!.latitude);
        //   }, icon: Icon(Icons.location_on))],
        // ),
        body:FutureBuilder(
            future: fetch(),
            builder: (BuildContext context, snapshot){
              if(snapshot.hasData){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data!.name,style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),),
                      Text(snapshot.data!.country,style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                      ),),
                      Text('${snapshot.data!.temp}°C',style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage('https://openweathermap.org/img/wn/${snapshot.data!.icon}@2x.png'),)
                        ),
                      ),
                      Text('Humidity : ${snapshot.data!.humidity}%',style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                      ),),
                      Text(snapshot.data!.description.toUpperCase(),style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.yellow
                      ),),
                      Text('Min Temperature : ${snapshot.data!.tempMin}°C',style: TextStyle(
                          color: Colors.white,
                          fontSize: 12
                      ),),
                      Text('Max Temperature : ${snapshot.data!.tempMax}°C',style: TextStyle(
                          color: Colors.white,
                          fontSize: 12
                      ),),
                      // Text('Latitude : ${_currentLoc!.latitude.toStringAsFixed(2)}',style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 12
                      // ),),
                      // Text('Longitude : ${_currentLoc!.longitude.toStringAsFixed(2)}',style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 12
                      // ),),
                      SizedBox(height: 14,),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder:(context)=>DataEntry() ));
                      }, child: const Text('Check Particular City')),
                    ],
                  ),
                );
              }
              else if(snapshot.hasError){
                return Text('Error In Your Server');
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            })
    );;
  }
}
