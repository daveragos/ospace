import 'package:flutter/material.dart';
import 'package:ospace/widgets/detail_weathe_info.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu),
                    SizedBox(width: 20),
                    Text('T O D A Y', style: TextStyle(fontSize: 20)),
                    Row(
                      children: [
                        Text('BTC', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text('12°C', style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(children: [
                    Text('Mekele, Ethiopia', style: TextStyle(fontSize: 20)),
                    Text('Tuesday, Oct 15, 2024 7:00 PM',
                        style: TextStyle(fontSize: 15)),
                  ]),
                  Row(children: [
                    Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        child: Text('C', style: TextStyle(fontSize: 20))),
                    Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.teal,
                        ),
                        child: Text('F', style: TextStyle(fontSize: 20))),
                  ]),
                ]),
                SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(children: [
                    Text('26°C', style: TextStyle(fontSize: 86)),
                    Text('light rain', style: TextStyle(fontSize: 16)),
                  ]),
                  SizedBox(
                    width: 148,
                    height: 148,
                    child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/116/116251.png',
                        fit: BoxFit.cover),
                  ),
                ]),
                SizedBox(height: 20),
                Container(
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
                                data: '26°C',
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
                                data: '50%',
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
                                data: '10 km/h',
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
                                title: 'Feels Like',
                                data: '26°C',
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
                                data: '50%',
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
                                data: '10 km/h',
                                icon:
                                    PhosphorIcon(PhosphorIcons.wind(), size: 30),
                              ),

                              //
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            PhosphorIcon(PhosphorIcons.clock(), size: 30),
                            SizedBox(
                              width: 10,
                            ),
                            Text('24 hour forecast',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 128.0,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          scrollDirection: Axis.horizontal,
                          children: [],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          PhosphorIcon(PhosphorIconsRegular.calendar),
                          const SizedBox(width: 4.0),
                          Text(
                            '7-Day Forecast',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text('more details ▶'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 4,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('Today'),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 36.0,
                                  width: 36.0,
                                  child: Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/116/116251.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'LIGHT RAIN',
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '26°C',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                     Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 4,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('Today'),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 36.0,
                                  width: 36.0,
                                  child: Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/116/116251.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'LIGHT RAIN',
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '26°C',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                     Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 4,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('Today'),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 36.0,
                                  width: 36.0,
                                  child: Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/116/116251.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'LIGHT RAIN',
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '26°C',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                     Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 4,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('Today'),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 36.0,
                                  width: 36.0,
                                  child: Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/116/116251.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'LIGHT RAIN',
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '26°C',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                     Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 4,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('Today'),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 36.0,
                                  width: 36.0,
                                  child: Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/116/116251.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'LIGHT RAIN',
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '26°C',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
