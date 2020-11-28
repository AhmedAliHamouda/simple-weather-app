import 'package:simple_weather_app/screens/city_screen.dart';
import 'package:simple_weather_app/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:simple_weather_app/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.dataWeather);
  final dataWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  String temperature;
  int temp;
  String conditionWeather;
  String cityName;

  @override
  void initState() {
    super.initState();
    updateDataUI(widget.dataWeather);
  }

  void updateDataUI(dynamic data) {
    setState(() {
      if (data == null) {
        temp = 0;
        conditionWeather = 'Error';
        temperature = 'Unable to Get Data Weather';
        cityName = ' ';
        return;
      }
      var temp1 = data['main']['temp'];
      temp = temp1.toInt();
      temperature = weatherModel.getMessage(temp);
      int condition = data['weather'][0]['id'];
      conditionWeather = weatherModel.getWeatherIcon(condition);
      cityName = data['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: 680,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            var dataWeatherLocation =
                                await weatherModel.getLocationWeather();
                            updateDataUI(dataWeatherLocation);
                          },
                          child: Icon(
                            Icons.near_me,
                            size: 50.0,
                          ),
                        ),
                        FlatButton(
                          onPressed: () async {
                            var cityNameData = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CityScreen();
                            }));

                            if (cityNameData != null) {
                              var dataCityWeather = await weatherModel
                                  .getCityWeather(cityNameData);
                              updateDataUI(dataCityWeather);
                            }
                          },
                          child: Icon(
                            Icons.location_city,
                            size: 50.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$temp°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          '$conditionWeather ️',
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text(
                      "$temperature in  $cityName!",
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
