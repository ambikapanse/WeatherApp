import 'dart:convert';
import 'package:http/http.dart';

class Operations
{
  String api = "fa1c193e116469433d774fd2c4568450";

  String location;
  Operations({required this.location}){
    location = location;
  }

  late String temp;
  late String windSpeed;
  late String description;
  late String main;
  late String humidity;
  late String icon;


  Future<void> getData() async{
    try{
    Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$api"));
    Map data = jsonDecode(response.body) as Map;

    Map tempData = data['main'];
    double getTemp = tempData['temp'] - 273.15;
    String getHumidity = tempData['humidity'].toString();

    Map wind = data['wind'];
    double getWindSpeed = wind['speed'].toDouble()/0.27777777777778;

    List weatherData = data['weather'];
    Map weatherMain = weatherData[0];
    String getMainDesc = weatherMain['main'];
    String getDesc = weatherMain["description"];
    String getIcon = weatherMain['icon'].toString();

    temp = getTemp.toString();
    humidity = getHumidity;
    windSpeed = getWindSpeed.toString();
    main = getMainDesc;
    description = getDesc;
    icon = getIcon;

    }catch(e){
      //Values when Invalid City is Searched
      temp = "NA";
      humidity = "NA";
      windSpeed = "NA";
      main = "NA";
      description = "NA";
      icon = "03n";
      // throw Exception("FAILED TO FETCH DATA: $e");
    }

  }

}
