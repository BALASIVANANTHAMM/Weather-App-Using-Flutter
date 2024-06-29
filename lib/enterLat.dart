import 'package:flutter/material.dart';

import 'latAndLong.dart';

class LatEnter extends StatefulWidget {
  const LatEnter({super.key});

  @override
  State<LatEnter> createState() => _LatEnterState();
}

class _LatEnterState extends State<LatEnter> {
  final ctlLat=TextEditingController();
  final ctlLog=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade200,
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    TextFormField(
            decoration: InputDecoration(
              hintText: 'Latitude',
              border: OutlineInputBorder()
            ),
            controller: ctlLat,
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
            decoration: InputDecoration(
              hintText: 'Longitude',
                border: OutlineInputBorder()
            ),
            controller: ctlLog,
                    ),
                    ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LatAndLog(lat: ctlLat.text, lon:ctlLog.text,)));
                    }, child: Text('Check'))
                  ],),
          )),
    );
  }
}
