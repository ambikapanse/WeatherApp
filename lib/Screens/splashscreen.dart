import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Operations/operations.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late String temp;
  late String hum;
  late String windSpeed;
  late String desc;
  late String main;
  late String icon;
  String city="London";

  void loadData(String city) async
  {
      Operations instance = Operations(location: city);
      await instance.getData();

      temp = instance.temp;
      hum = instance.humidity;
      windSpeed = instance.windSpeed;
      desc = instance.description;
      main = instance.main;
      icon = instance.icon;

      Future.delayed(const Duration(seconds: 2),(){
        Navigator.pushReplacementNamed(context, '/home',arguments: {
          "temp_value" : temp,
          "hum_value" : hum,
          "wind_speed_value" : windSpeed,
          "des_value" : desc,
          "main_value" : main,
          "icon_value" : icon,
          "city_value" : city,
        } );
      });

  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //Default City = Delhi
    Map<dynamic, dynamic>? search = ModalRoute.of(context)?.settings.arguments as Map?;
    if(search==null || search.isEmpty){
      city = "Delhi";
    }else{
      city = search["searchText"];
    }
    loadData(city);

    return Scaffold(
      backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 200.0, horizontal: 80),
              child: Column(
              children:<Widget>[
                Image.asset("images/weatherLogo.jpg"),
                const Text("Weather",style: TextStyle(color: Colors.white, fontSize: 40, fontFamily: 'Serif'),),
                const Text("By Ambika",style: TextStyle(color: Colors.white38, fontSize: 15)),
                const SizedBox(
                  height: 40,
                ),

                //LOADING ANIMATION
                const SpinKitSpinningLines(
                color: Colors.white,
                size: 80.0,
              ),
              ]
            )
          )
        )
        )
      );
  }
}

