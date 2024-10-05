import 'dart:async';
import 'dart:convert';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:weather_pack/weather_pack.dart';

import 'news_Article.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   List<String> urls = [
     'https://youtu.be/hHG1wva1B0w',
     'https://github.com/daveragos/omnispace',
     'https://satoshi.nakamotoinstitute.org/code/',
     'https://pinetools.com/'
   ];

   List<dynamic> data = [];
   WeatherCurrent? currently;
   String temp_C = '';

   Image getWeatherIcon(String weatherIcon) {
     return Image.asset(
       width: 50,
       height: 50,
       ImagePathWeather.getPathWeatherIcon(weatherIcon),
       filterQuality: FilterQuality.high, // optional
       package: ImagePathWeather.packageName,
     );
   }

   void worksTempUnits({
     double temp = 270.78, // ex. received from [WeatherCurrent.temp]
     int precision = 3,
     Temp unitsMeasure = Temp.celsius,
   }) {
     temp_C = unitsMeasure.valueToString(temp, precision);
     print(unitsMeasure.valueToString(temp, precision)); // `-2.370` type `String`
   }

   Future<void> getOnecallWeatherWays(String api) async {
     final wService = WeatherService(api);

     // get the current weather in Amsterdam
     currently = await wService.currentWeatherByLocation(
         latitude: 52.374, longitude: 4.88969);
worksTempUnits(temp: currently?.temp ?? 270);
// getWeatherIcon(currently.weatherIcon!);
     print(currently);
   }


    Future<List<String>> loadNewsArticles() async {

      const api = '3721410d028c8efa237d9196d80a6061'; // TODO: change to your openweathermap APIkey
      getOnecallWeatherWays(api);


      final response = await http.get(Uri.parse(
          'https://hacker-news.firebaseio.com/v0/newstories.json'));
       data = json.decode(response.body);
       print(data.runtimeType);
      debugPrint(data.toString());
      getNewsArticles(data);
       data.sublist(0,25);
      for (int link in data) {
        final response = await http.get(Uri.parse(
            'https://hacker-news.firebaseio.com/v0/item/$link.json'));
        final info = json.decode(response.body);
        String url = info['url'];
        urls.add(url);
        print(urls);
      }
      return urls;
    }

    Future<void> getNewsArticles(List<dynamic> data) async {

    }
    
    @override
    void initState() {
      super.initState();
      loadNewsArticles();
      // getNewsArticles(data);
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.teal,
        buttonBackgroundColor: Colors.transparent,
        animationDuration:  Duration(milliseconds: 300),

        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.menu),
                      SizedBox(
                        width: 20,
                      ),
                      Text('NEWS',style: TextStyle(fontSize: 20),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('BTC',style: TextStyle(fontSize: 20),),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          getWeatherIcon(currently?.weatherIcon ?? '/assets/img.png'),
                          Text('$temp_C C',style: TextStyle(fontSize: 15),),
                        ],
                      )
                    ],
                  ),
                ],
              ),
                
                Flexible(
        child: ListView.builder(itemCount: urls.length, itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            AnyLinkPreview(link: urls[index],
            displayDirection: UIDirection.uiDirectionHorizontal,
              errorImage: 'assets/img.png',
              cache: Duration(hours: 1),
              errorWidget: SizedBox(
                // child: Text('Oops!'),
              ),
            ),
          );
        })
                ),
            ],
          ),
        ),
      ),
    );
  }
}
