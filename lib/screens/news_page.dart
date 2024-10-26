import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:ospace/publisher/home_publisher.dart';
import 'package:ospace/publisher/screens/settings.dart';
import 'package:ospace/screens/crypto_page.dart';
import 'package:ospace/screens/custom_inapp_webview.dart';
import 'package:ospace/screens/weather_page.dart';
import 'package:ospace/service/api_helper.dart';
import 'package:ospace/widgets/shimmer_card_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shimmer/shimmer.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<String> links = [];
  List<int> allStoryIds = [];
  bool isLoadingMore = false;
  bool isLoadingInitial = true;
  int currentPage = 0;
  final int pageSize = 30;
  String tempC = '';

  @override
  void initState() {
    super.initState();
    loadInitialNews();
  }

  Future<void> loadInitialNews() async {
    setState(() {
      isLoadingInitial = true;
    });

    allStoryIds = await ApiHelper().fetchNewsStoryIds();
    await loadMoreNews();

    if (mounted) {
      setState(() {
        isLoadingInitial = false;
      });
    }
  }

  Future<void> loadMoreNews() async {
    if (currentPage * pageSize >= allStoryIds.length) return;

    if (mounted) {
      setState(() {
        isLoadingMore = true;
      });
    }

    final start = currentPage * pageSize;
    final end = (start + pageSize > allStoryIds.length) ? allStoryIds.length : start + pageSize;
    final storyIdsToLoad = allStoryIds.sublist(start, end);

    final newLinks = await ApiHelper().loadNewsArticlesByIds(storyIdsToLoad);

    if (mounted) {
      setState(() {
        links.addAll(newLinks);
        isLoadingMore = false;
        currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text('News'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: KActionsWidget(tempC: tempC),
          ),
        ],
      ),
      drawer: const KDrawerWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text('NEWS', style: TextStyle(fontSize: 20)),

              //   ],
              // ),
              Expanded(
                child: isLoadingInitial
                    ? ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const ShimmerNewsCard();
                        },
                      )
                    : ListView.builder(
                        itemCount: links.length + 1,
                        itemBuilder: (context, index) {
                          if (index == links.length) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: GestureDetector(
                                  onTap: loadMoreNews,
                                  child: isLoadingMore
                                      ? Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child:  Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 40,
                                            color: Colors.grey.shade700,
                                          ),
                                        )
                                      :  Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 40,
                                          color: Colors.grey.shade700,
                                        ),
                                ),
                              ),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnyLinkPreview(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CustomInAppBrowser(
                                      url: links[index],
                                    ),
                                  ),
                                );
                              },
                              link: links[index],
                              displayDirection: UIDirection.uiDirectionHorizontal,
                              errorImage:
                                  'https://pbs.twimg.com/profile_images/1148430319680393216/nNOYLkdH_400x400.png',
                              cache: const Duration(hours: 1),
                              errorWidget: Container(),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KActionsWidget extends StatelessWidget {
  const KActionsWidget({
    super.key,
    required this.tempC,
  });

  final String tempC;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('BTC', style: TextStyle(fontSize: 20)),
        const SizedBox(width: 20),
        Column(
          children: [
            Image.asset(
              'assets/icons/storm.png',
              width: 25,
              height: 25,
            ),
            Text('$tempC °C', style: const TextStyle(fontSize: 15)),
          ],
        ),
      ],
    );
  }
}

class KDrawerWidget extends StatelessWidget {
  const KDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
           DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Center(child: Text('OmniSpace', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
          ),
          ListTile(
            title: const Text('Publish', style: TextStyle(fontSize: 20)),
            leading:  Icon(Icons.speaker_notes),

            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePublisher()));
            },
          ),
          ListTile(
            title: const Text('News', style: TextStyle(fontSize: 20)),
            leading: const Icon(Icons.newspaper),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NewsPage()));
            },
          ),
          ListTile(
            title: const Text('Weather', style: TextStyle(fontSize: 20)),
            leading:  Icon(PhosphorIcons.cloudSun(PhosphorIconsStyle.duotone)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const WeatherPage()));
            },
          ),
          ListTile(
            title: const Text('Crypto', style: TextStyle(fontSize: 20)),
            leading:  Icon(PhosphorIcons.currencyBtc(PhosphorIconsStyle.duotone)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CryptoPage()));
            },
          ),
          ListTile(
            title: const Text('Settings', style: TextStyle(fontSize: 20)),
            leading:  Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
            },
          ),
          ListTile(
            title: const Text('Logout', style: TextStyle(fontSize: 20)),
            leading:  Icon(Icons.logout),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          ),
        ],
      ),
    );
  }
}
