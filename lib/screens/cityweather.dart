
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherScreen({Key? key, required this.weatherData}) : super(key: key);

  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300 :
        return Image.asset(
            'assets/1.png'
        );
      case >= 300 && < 400 :
        return Image.asset(
            'assets/2.png'
        );
      case >= 500 && < 600 :
        return Image.asset(
            'assets/3.png'
        );
      case >= 600 && < 700 :
        return Image.asset(
            'assets/4.png'
        );
      case >= 700 && < 800 :
        return Image.asset(
            'assets/5.png'
        );
      case == 800 :
        return Image.asset(
            'assets/6.png'
        );
      case > 800 && <= 804 :
        return Image.asset(
            'assets/7.png'
        );
      default:
        return Image.asset(
            'assets/7.png'
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(30, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-30, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF673AB7)),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 250,
                  width: 600,
                  decoration: const BoxDecoration(color: Color(0xFFFFAB40)),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text(
                    '📍${weatherData.areaName}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Good Morning',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  getWeatherIcon(weatherData.weatherConditionCode!),
                  Center(
                    child: Text(
                      '${weatherData.temperature!.celsius!.round()}°C',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 55,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Center(
                    child: Text(
                      weatherData.weatherMain!.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      DateFormat('EEEE dd •').add_jm().format(weatherData.date!),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/11.png',
                            scale: 8,
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              const Text(
                                'Sunrise',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                DateFormat().add_jm().format(weatherData.sunrise!),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/12.png',
                            scale: 8,
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              const Text(
                                'Sunset',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                DateFormat().add_jm().format(weatherData.sunset!),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Image.asset(
                          'assets/13.png',
                          scale: 8,
                        ),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Temp Max',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "${weatherData.tempMax!.celsius!.round()}°C",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ]),
                      Row(children: [
                        Image.asset(
                          'assets/14.png',
                          scale: 8,
                        ),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Temp Min',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "${weatherData.tempMin!.celsius!.round()}°C",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700

                              ),
                            ),
                          ],
                        )
                      ])
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherData {
  final String areaName;
  final int? weatherConditionCode;
  final String? weatherMain;
  final Temperature? temperature;
  final DateTime? date;
  final DateTime? sunrise;
  final DateTime? sunset;
  final Temperature? tempMax;
  final Temperature? tempMin;

  WeatherData({
    required this.areaName,
    this.weatherConditionCode,
    this.weatherMain,
    this.temperature,
    this.date,
    this.sunrise,
    this.sunset,
    this.tempMax,
    this.tempMin,
  });
}

class Temperature {
  final double? celsius;

  Temperature({this.celsius});
}
