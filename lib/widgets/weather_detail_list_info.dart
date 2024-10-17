import 'package:flutter/material.dart';
import 'package:ospace/service/api_helper.dart';
import 'package:ospace/widgets/detail_weathe_info.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:weather_pack/weather_pack.dart';

class WeatherDetailListInfo extends StatelessWidget {
  const WeatherDetailListInfo({
    super.key,
    required this.currently,
  });

  final WeatherCurrent currently;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade300,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //icon
                  DetailInfoTile(
                    title: 'Feels Like',
                    data: '${currently.tempFeelsLike}°C',
                    icon: PhosphorIcon(PhosphorIcons.thermometer(),
                        size: 30),
                  ),

                  //vertical divider
                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  //icon
                  DetailInfoTile(
                    title: 'Percepitation',
                    data: ApiHelper().worksTempUnits(temp: currently.tempFeelsLike!),
                    icon:
                        PhosphorIcon(PhosphorIcons.drop(), size: 30),
                  ),

                  //vertical divider
                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  //icon
                  DetailInfoTile(
                    title: 'Wind Speed',
                    data: '${currently.windSpeed} km/h',
                    icon:
                        PhosphorIcon(PhosphorIcons.wind(), size: 30),
                  ),

                  //
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //icon
                  DetailInfoTile(
                    title: 'UVI index',
                    data: '${currently.uvi}',
                    icon: PhosphorIcon(PhosphorIcons.thermometer(),
                        size: 30),
                  ),

                  //vertical divider
                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  //icon
                  DetailInfoTile(
                    title: 'Humidity',
                    data: '${currently.humidity}%',
                    icon:
                        PhosphorIcon(PhosphorIcons.dropHalfBottom(), size: 30),
                  ),

                  //vertical divider
                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  //icon
                  DetailInfoTile(
                    title: 'Cloudiness',
                    data: '${currently.cloudiness}%',
                    icon:
                        PhosphorIcon(PhosphorIcons.cloud(), size: 30),
                  ),

                  //
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
