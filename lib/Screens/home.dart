import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Random city names for Search Bar
    var cities = [
      "Mumbai",
      "Delhi",
      "Chennai",
      "Kolkata",
      "London",
      "Paris",
      "Tokyo",
      "Seoul"
    ];
    final random = Random();
    var city = cities[random.nextInt(cities.length)];

    //Getting and setting data for a city
    Map info = ModalRoute.of(context)?.settings.arguments as Map;
    String temp;
    if (info['temp_value'] == 0) {
      temp = (info['temp_value']).toString();
    } else {
      String tempString = info['temp_value'].toString();
      temp = tempString.length >= 4 ? tempString.substring(0, 4) : tempString;
    }
    String icon = info['icon_value'].toString();
    String location = info['city_value'];
    String hum = info['hum_value'];
    String wind;
    if (info['wind_speed_value'] == 0) {
      wind = (info['wind_speed_value']).toString();
    } else {
      String windString = info['wind_speed_value'].toString();
      wind = windString.length >= 4 ? windString.substring(0, 4) : windString;
    }
    String desc = info['des_value'];

    //background colors
    Color bg1 = const Color(0xFF14235B);
    Color bg2 = const Color(0xFF620436);


    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: bg2,
          toolbarHeight: 0,
        ),
        body: SafeArea(
            child: ListView(children: [
          //background container
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: const [0.2, 0.7],
                    colors: [bg2, bg1])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white60.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(80)),
                  child:
                      //SEARCH BAR
                      Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/splash", arguments: {
                            "searchText": editingController.text,
                          });
                        },
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 7, 0),
                            child: const Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                            )),
                      ),
                      Expanded(
                        child: TextField(
                            controller: editingController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.white60),
                                hintText: "Search $city",
                                border: InputBorder.none),
                            style: const TextStyle(
                              color: Colors.white, // Set the desired text color
                            ),
                            onSubmitted: (String value) {
                              Navigator.pushNamed(context, "/splash",
                                  arguments: {
                                    "searchText": editingController.text,
                                  });
                            }),
                      )
                    ],
                  ),
                ),

                //FIRST ROW - ICON + DESCRIPTION
                Row(children: [
                  Expanded(
                      child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(14)),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(10),
                    child: Row(children: [
                      Image.network(
                          "https://openweathermap.org/img/wn/$icon@2x.png"),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            desc.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "in $location",
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      )
                    ]),
                  ))
                ]),

                //SECOND ROW - TEMPERATURE
                Row(children: [
                  Expanded(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                WeatherIcons.thermometer,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    temp,
                                    style: const TextStyle(
                                        fontSize: 130, color: Colors.white),
                                  ),
                                  const Text(
                                    "°C",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              )
                            ],
                          )))
                ]),

                //THIRD ROW - Humidity, Pressure, Wind Speed
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(14)),
                            margin: const EdgeInsets.fromLTRB(20, 0, 5, 0),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      WeatherIcons.day_windy,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  wind,
                                  style: const TextStyle(
                                      fontSize: 40, color: Colors.white),
                                ),
                                const Text(
                                  "km/hr",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            )),
                      ),
                      Expanded(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.20,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(14)),
                            margin: const EdgeInsets.fromLTRB(5, 0, 20, 0),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      WeatherIcons.humidity,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  hum,
                                  style: const TextStyle(
                                      fontSize: 40, color: Colors.white),
                                ),
                                const Text(
                                  "%",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            )),
                      )
                    ]),

                //BOTTOM TEXT
                const Text(
                  "Data provided by OpenWeatherMap.org",
                  style: TextStyle(color: Colors.white30),
                )
              ],
            ),
          ),
        ])));
  }
}
