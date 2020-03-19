import 'package:flutter/material.dart';
import 'package:flutter_wheather_suggestions/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'c464518db2279f6314c70cd56a5a0e8c';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;
    getData();
  }

  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    //print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;

      var lon = jsonDecode(data)['coord']['lon'];
      var lat = jsonDecode(data)['coord']['lat'];
      var cityName = jsonDecode(data)['name'];
      print(cityName);
      print(lon);
      print(lat);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getData();

            //getLocation();
            //Get the current location
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
