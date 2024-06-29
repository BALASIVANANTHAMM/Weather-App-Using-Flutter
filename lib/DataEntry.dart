import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class DataEntry extends StatefulWidget {
  const DataEntry({super.key});

  @override
  State<DataEntry> createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry> {
  final ctlCity =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade200,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width/1.1,
          height: MediaQuery.of(context).size.height/3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter The City Name Here'),
              SizedBox(height: 30,),
              SizedBox(
                height: 50,
                  width: MediaQuery.of(context).size.height/3,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'City Name',
                      prefixIcon: const Icon(Icons.location_city),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9)
                      )
                    ),
                    controller: ctlCity,
                  )),
              SizedBox(height: 25,),
              ElevatedButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Weather(cityName: ctlCity.text)));
              }, child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
