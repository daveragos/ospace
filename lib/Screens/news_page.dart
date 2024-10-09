import 'dart:async';
import 'dart:convert';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:coingecko_api/coingecko_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:weather_pack/weather_pack.dart';


class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  //demo urls
  List<String> urls = [
    'https://youtu.be/hHG1wva1B0w',
  ];
  bool icon = false;
  List<dynamic> data = [];
  WeatherCurrent? currently;
  String tempC = '';
  Logger logger = Logger();
  Image weatherImage = Image.asset(
    width: 50,
    height: 50,
    ImagePathWeather.getPathWeatherIcon('13d'),
    filterQuality: FilterQuality.high, // optional
    package: ImagePathWeather.packageName,
  );

  //weather icon getter based on the temp
  void getWeatherIcon(String weatherIcon) {
      weatherImage = Image.asset(
        width: 50,
        height: 50,
        ImagePathWeather.getPathWeatherIcon(weatherIcon),
        filterQuality: FilterQuality.high, // optional
        package: ImagePathWeather.packageName,
      );
  }

  // temp unit converter to celcius
  void worksTempUnits({
    double temp = 270.78, // ex. received from [WeatherCurrent.temp]
    int precision = 2,
    Temp unitsMeasure = Temp.celsius,
  }) {
    tempC = unitsMeasure.valueToString(temp, precision);
    logger.d(unitsMeasure.valueToString(temp, precision)); // `-2.370` type `String`
  }

  //weather info api caller
  Future<void> getOnecallWeatherWays(String api) async {
    final wService = WeatherService(api);

    // get the current weather in Amsterdam
    currently = await wService.currentWeatherByLocation(
        latitude: 52.374, longitude: 4.88969);
    worksTempUnits(temp: currently?.temp ?? 270);
getWeatherIcon(currently!.weatherIcon ?? '13d');
    logger.d(currently);
  }

  //news info api caller
  Future<List<String>> loadNewsArticles() async {

    const api = '3721410d028c8efa237d9196d80a6061';
    getOnecallWeatherWays(api);


    final response = await http.get(Uri.parse(
        'https://hacker-news.firebaseio.com/v0/newstories.json'));
    data = json.decode(response.body);
    // print(data.runtimeType);
    // debugPrint(data.toString());


    for (int link in data) {
      final response = await http.get(Uri.parse(
          'https://hacker-news.firebaseio.com/v0/item/$link.json'));
      final info = json.decode(response.body);
      String url = info['url'];
      // print('####### $url #######');
      urls.add(url);
      // print(urls);
      // print('NUMBER ${urls.length}');
    }
    coinGeckoCaller();
    return urls;
  }

  //coingecko api caller
  Future<void> coinGeckoCaller () async {
    final api = CoinGeckoApi();
    logger.d('Calling method getCoinOHLC() ...');
    final result = await api.coins.getCoinOHLC(
      id: 'bitcoin',
      vsCurrency: 'usd',
      days: 7,
    );
    final listCoin = await api.coins.listCoinTickers(id: 'bitcoin');
    logger.d(listCoin);

    final getCoin = await api.coins.getCoinData(id: 'bitcoin');
    logger.d(getCoin);
    final coins = await api.coins.listCoins();
    logger.d(coins);
    final market = await api.coins.getCoinMarketChart(id: 'bitcoin', vsCurrency: 'usdt');
    logger.d(market);
    if (!result.isError) {

      logger.d('getCoinOHLC() results:');
      logger.d(result);
      for (var item in result.data) {
        logger.d(
            '${item.timestamp}: open = ${item.open}, high = ${item.high}, low = ${item.low}, close = ${item.close}');
      }

      logger.d('Test method completed successfully.');
    } else {
      logger.d('getCoinOHLC() method returned error:');
      logger.d('${result.errorCode}: ${result.errorMessage}');
      logger.d('Test method failed.');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          weatherImage,
                          Text('$tempC C',style: TextStyle(fontSize: 15),),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              Flexible(
                  child: FutureBuilder(
                    future: loadNewsArticles(),
                    builder: (context, snapshot) {
                      return ListView.builder(itemCount: urls.length, itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          GestureDetector(
                            onTap: (){
                               InAppWebView(
                                initialUrlRequest: URLRequest(url: WebUri(urls[index])),
                             );
                            },
                            child: AnyLinkPreview(link: urls[index],
                              displayDirection: UIDirection.uiDirectionHorizontal,
                              errorImage: 'assets/img.png',
                              cache: Duration(hours: 1),
                              errorWidget: SizedBox(
                                // child: Text('Oops!'),
                              ),
                            ),
                          ),
                        );
                      });
                    },

                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
