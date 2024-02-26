import 'dart:convert';

import 'package:assignmentclimateapp/data/myData.dart';
import 'package:assignmentclimateapp/screens/cityweather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class InputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController cityNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter City Name'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: cityNameController,
                decoration: InputDecoration(
                  labelText: 'City Name',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {

                  WeatherData weatherData = await getWeatherData(
                      cityNameController.text);


                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WeatherScreen(weatherData: weatherData),
                    ),
                  );
                },
                child: Text('Get Weather'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<WeatherData> getWeatherData(String cityName) async {
    final apiKey = API_KEY;
    final apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return WeatherData(
        areaName: data['name'],
        weatherConditionCode: data['weather'][0]['id'],
        weatherMain: data['weather'][0]['main'],
        temperature: Temperature(celsius: data['main']['temp'] - 273.15),

        date: DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000),

        sunrise: DateTime.fromMillisecondsSinceEpoch(
            data['sys']['sunrise'] * 1000),
        sunset: DateTime.fromMillisecondsSinceEpoch(
            data['sys']['sunset'] * 1000),
        tempMax: Temperature(celsius: data['main']['temp_max'] - 273.15),
        tempMin: Temperature(celsius: data['main']['temp_min'] - 273.15),
      );
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}