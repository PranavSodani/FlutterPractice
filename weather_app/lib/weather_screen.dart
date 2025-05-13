// updated_weather_screen.dart

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_information.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0, windSpeed = 0;
  int humid = 0, pressure = 0;
  String weatherDescription = '';

  @override
  void initState() {
    super.initState();
    try {
      getCurrentWeather();
    } catch (e) {
      throw (e.toString());
    }
  }

  Future getCurrentWeather() async {
    try {
      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherAPIKey',
        ),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') throw 'An unexpected error occurred';
      setState(() {
        temp = data['list'][0]['main']['temp'] - 273.15;
        humid = data['list'][0]['main']['humidity'];
        windSpeed = data['list'][0]['wind']['speed'];
        pressure = data['list'][0]['main']['pressure'];
        weatherDescription =
            data['list'][0]['weather'][0]['description'];
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => getCurrentWeather(), icon: Icon(Icons.refresh))
        ],
      ),
      body: temp == 0
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // main card
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter:
                              ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '${temp.toStringAsFixed(1)} °C',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Icon(Icons.cloud, size: 64),
                                const SizedBox(height: 16),
                                Text(
                                  weatherDescription.isNotEmpty
                                      ? weatherDescription[0].toUpperCase() +
                                          weatherDescription.substring(1)
                                      : '',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Weather Forecast',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: const [
                        HourlyForecastItem(
                          icon: Icons.cloud,
                          label1: '03:01',
                          label2: '320.12',
                        ),
                        HourlyForecastItem(
                          icon: Icons.cloud,
                          label1: '09:01',
                          label2: '420.45',
                        ),
                        HourlyForecastItem(
                          icon: Icons.cloud,
                          label1: '12:01',
                          label2: '120.23',
                        ),
                        HourlyForecastItem(
                          icon: Icons.cloud,
                          label1: '15:01',
                          label2: '540.43',
                        ),
                        HourlyForecastItem(
                          icon: Icons.cloud,
                          label1: '18:01',
                          label2: '650.16',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AdditionalInformation(
                          icon: Icons.water_drop,
                          label1: 'Humidity',
                          label2: '$humid %',
                        ),
                        const SizedBox(width: 10),
                        AdditionalInformation(
                          icon: Icons.speed,
                          label1: 'Wind Speed',
                          label2: '$windSpeed m/s',
                        ),
                        const SizedBox(width: 10),
                        AdditionalInformation(
                          icon: Icons.air,
                          label1: 'Pressure',
                          label2: '$pressure hPa',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
