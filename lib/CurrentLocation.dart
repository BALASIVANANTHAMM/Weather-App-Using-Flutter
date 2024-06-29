import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'DataEntry.dart';
import 'WeatherModel.dart';
import 'enterLat.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  Position? _currentLoc;
  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
  Future<WeatherModel> fetch() async {
    var result = await http
        .get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${_currentLoc!.latitude}&lon=${_currentLoc!.longitude}&lang=en&&units=metric&appid=b3241b166a34277e9ff8b825b21d91c3"));
     return WeatherModel.fromMap(jsonDecode(result.body));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [IconButton(onPressed: () async{
          Position position = await _getCurrentPosition();
          setState(() {
            _currentLoc = position;
          });
          print(_currentLoc!.latitude);
        }, icon: Icon(Icons.location_on))],
      ),
      body: _currentLoc==null
        ?Center(child: Text('Press to Get Location Weather'))
        :FutureBuilder(
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
                    Text('Latitude : ${_currentLoc!.latitude.toStringAsFixed(2)}',style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                    ),),
                    Text('Longitude : ${_currentLoc!.longitude.toStringAsFixed(2)}',style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                    ),),
                    SizedBox(height: 14,),
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder:(context)=>DataEntry() ));
                    }, child: const Text('Check Particular City')),
                    SizedBox(height: 8,),
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LatEnter()));
                    }, child: const Text('Check Lat & Log Value'))
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
    );
  }
}
