
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:ospace/service/api_helper.dart';
import 'package:weather_pack/weather_pack.dart';


class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}
class _NewsPageState extends State<NewsPage> {
  String tempC = '';
  Image weatherImage = Image.asset(
    width: 50,
    height: 50,
    ImagePathWeather.getPathWeatherIcon('13d'),
    package: ImagePathWeather.packageName,
  );

  // Fetch the weather information and update the state
  Future<void> fetchWeather() async {
    final apiHelper = ApiHelper();
    await apiHelper.getOnecallWeatherWays(api: '3721410d028c8efa237d9196d80a6061'); // Add your weather API key

    setState(() {
      tempC = apiHelper.worksTempUnits(temp: apiHelper.currently?.temp ?? 270);
      weatherImage = apiHelper.getWeatherIcon(apiHelper.currently?.weatherIcon ?? '13d');
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWeather(); // Call fetchWeather when the widget is initialized
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
                      SizedBox(width: 20),
                      Text('NEWS', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  Row(
                    children: [
                      Text('BTC', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          weatherImage,
                          Text('$tempC °C', style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Flexible(
  child: FutureBuilder<List<String>>(
    future: ApiHelper().loadNewsArticles(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error loading news: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No news articles found.'));
      }
      List<String> links = snapshot.data!;
      return ListView.builder(
        itemCount: links.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Handle tap event here (e.g., open the link)
              },
              child: AnyLinkPreview(
                link: links[index],
                displayDirection: UIDirection.uiDirectionHorizontal,
                errorImage: 'https://pbs.twimg.com/profile_images/1148430319680393216/nNOYLkdH_400x400.png',
                cache: Duration(hours: 1),
                errorWidget: SizedBox(),
              ),
            ),
          );
        },
      );
    },
  ),
)

            ],
          ),
        ),
      ),
    );
  }
}
