import 'dart:ui';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/service/AdmobServises.dart';
import 'package:weather/service/Weather.dart';
import 'package:intl/intl.dart';

const Color _textColor = Colors.white;

class HomeScreen extends StatefulWidget {
  HomeScreen({
    this.locationWeather,
  });
  final locationWeather;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ams = AdMobService();

  String tapedName;
  TimeOfDay time;
  DateTime first;
  WeatherModel weatherModel = WeatherModel();
  String cytiName;
  String weatherMain;
  int temperature;
  int feelsLike;
  int weatherMin;
  int weatherMax;
  int weatherID;
  int weatherIDdayOne;
  int weatherIDdayTwo;
  int weatherIDdayThree;
  int weatherIDdayFour;
  IconData weatherIcon;
  IconData weatherIconDayOne;
  IconData weatherIconDayTwo;
  IconData weatherIconDayThree;
  IconData weatherIconDayFour;
  int dayOneMax;
  int dayOneMin;
  int dayTwoMax;
  int dayTwoMin;
  int dayThreeMax;
  int dayThreeMin;
  int dayFourMax;
  int dayFourMin;

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('MMMd');
  final String formattedMonthNow = formatter.format(now);

  static final DateTime dateTwo = now.add(Duration(days: 1));
  static final DateFormat formatterTwo = DateFormat('MMMd');
  final String formattedMonthTwo = formatter.format(dateTwo);
  static final DateFormat formatterDayTwo = DateFormat('EEE');
  final String formattedTwo = formatterDayTwo.format(dateTwo);

  static final DateTime dateThree = dateTwo.add(Duration(days: 1));
  static final DateFormat formatterThree = DateFormat('MMMd');
  final String formattedMonthThree = formatter.format(dateThree);
  static final DateFormat formatterDayThree = DateFormat('EEE');
  final String formattedThree = formatterDayTwo.format(dateThree);

  static final DateTime dateFour = dateThree.add(Duration(days: 1));
  static final DateFormat formatterFour = DateFormat('MMMd');
  final String formattedMonthFour = formatter.format(dateFour);
  static final DateFormat formatterDayFour = DateFormat('EEE');
  final String formattedFour = formatterDayTwo.format(dateFour);

  static final DateTime dateFive = dateFour.add(Duration(days: 1));
  static final DateFormat formatterFive = DateFormat('MMMd');
  final String formattedMonthFive = formatter.format(dateFive);
  static final DateFormat formatterDayFive = DateFormat('EEE');
  final String formattedFive = formatterDayTwo.format(dateFive);

  @override
  void initState() {
    super.initState();
    upDateUI(widget.locationWeather);
  }

  void upDateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        cytiName = "";
        weatherIcon = null;
        temperature = 0;
        weatherMax = 0;
        weatherMin = 0;
        return;
      }

      cytiName = weatherData['city']['name'];
      weatherMain = weatherData['list'][0]['weather'][0]['main'];
      double temp = weatherData['list'][0]['main']['temp'];
      temperature = temp.toInt();
      double fLike = weatherData['list'][0]['main']['feels_like'];
      feelsLike = fLike.toInt();
      double wMin = weatherData['list'][0]['main']['temp_min'];
      weatherMin = wMin.toInt();
      double wMax = weatherData['list'][0]['main']['temp_max'];
      weatherMax = wMax.toInt();
      weatherID = weatherData['list'][0]['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(weatherID);
      double dOnemax = weatherData['list'][3]['main']['temp_max'];
      dayOneMax = dOnemax.toInt();
      double dOnemin = weatherData['list'][3]['main']['temp_min'];
      dayOneMin = dOnemin.toInt();
      weatherIDdayOne = weatherData['list'][3]['weather'][0]['id'];
      weatherIconDayOne = weatherModel.getWeatherIcon(weatherIDdayOne);
      double dTwomax = weatherData['list'][11]['main']['temp_max'];
      dayTwoMax = dTwomax.toInt();
      double dTwomin = weatherData['list'][11]['main']['temp_min'];
      dayTwoMin = dTwomin.toInt();
      weatherIDdayTwo = weatherData['list'][11]['weather'][0]['id'];
      weatherIconDayTwo = weatherModel.getWeatherIcon(weatherIDdayTwo);
      double dThreemax = weatherData['list'][19]['main']['temp_max'];
      dayThreeMax = dThreemax.toInt();
      double dThreemin = weatherData['list'][19]['main']['temp_min'];
      dayThreeMin = dThreemin.toInt();
      weatherIDdayThree = weatherData['list'][19]['weather'][0]['id'];
      weatherIconDayThree = weatherModel.getWeatherIcon(weatherIDdayThree);
      double dFourmax = weatherData['list'][27]['main']['temp_max'];
      dayFourMax = dFourmax.toInt();
      double dFourmin = weatherData['list'][27]['main']['temp_min'];
      dayFourMin = dFourmin.toInt();
      weatherIDdayFour = weatherData['list'][27]['weather'][0]['id'];
      weatherIconDayFour = weatherModel.getWeatherIcon(weatherIDdayFour);
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      time = TimeOfDay.now();
    });
    InterstitialAd myInterstitial = ams.getNewTripInterstitial();
    myInterstitial.load();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/BackGround.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3.0,
                  sigmaY: 3.0,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: SafeArea(
              child: temperature == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 24,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: _textColor,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${time.hour}:${time.minute} PM",
                                  style: GoogleFonts.montserrat(
                                    color: _textColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.edit_location,
                                  color: _textColor,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "$cytiName",
                                  style: GoogleFonts.montserrat(
                                    color: _textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.white54),
                            ),
                            margin: EdgeInsets.all(18),
                            child: TextField(
                              onChanged: (value) {
                                tapedName = value;
                              },
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'search another location...',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () async {
                                    myInterstitial.show(
                                      anchorType: AnchorType.bottom,
                                      anchorOffset: 0.0,
                                    );
                                    if (tapedName != null) {
                                      var weatherData = await weatherModel
                                          .getCityWeather(tapedName);
                                      upDateUI(weatherData);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: _textColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "$weatherMain",
                                        style: GoogleFonts.montserrat(
                                          color: _textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "$temperature",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 84,
                                                      color: _textColor),
                                                ),
                                                Text(
                                                  "°C",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                      color: _textColor),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Feels like $feelsLike",
                                              style: GoogleFonts.montserrat(
                                                color: _textColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        VerticalDivider(
                                          color: _textColor,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              weatherIcon,
                                              size: 64,
                                              color: _textColor,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12),
                                              child: Text(
                                                "$weatherMin° - $weatherMax°",
                                                style: GoogleFonts.montserrat(
                                                  color: _textColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: _textColor,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "Sunrise 6 AM",
                                            style: GoogleFonts.montserrat(
                                              color: _textColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "Moonrise 9 PM",
                                            style: GoogleFonts.montserrat(
                                              color: _textColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: _textColor,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 5,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            padding:
                                EdgeInsets.only(top: 8, bottom: 8, left: 16),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                reUseble("$formattedMonthNow",
                                    "$weatherMin° - $weatherMax°", "TODAY"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: reUseble(
                                      "$formattedTwo",
                                      "$dayOneMin° - $dayOneMax°",
                                      "$formattedMonthTwo"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: reUseble(
                                      "$formattedThree",
                                      "$dayTwoMin° - $dayTwoMax°",
                                      "$formattedMonthThree"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: reUseble(
                                      "$formattedFour",
                                      "$dayThreeMin° - $dayThreeMax°",
                                      "$formattedMonthFour"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: reUseble(
                                      "$formattedFive",
                                      "$dayFourMin° - $dayFourMax°",
                                      "$formattedMonthFive"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget reUseble(
    String days,
    String temp,
    String dayMounth,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              days,
              style: GoogleFonts.montserrat(color: _textColor, fontSize: 14),
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Icon(
          weatherIconDayOne,
          color: _textColor,
          size: 38,
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            temp,
            style: GoogleFonts.montserrat(
              color: _textColor,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          dayMounth,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            color: _textColor,
          ),
        )
      ],
    );
  }
}
