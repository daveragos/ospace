import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:ospace/screens/custom_inapp_webview.dart';
import 'package:ospace/service/api_helper.dart';
import 'package:ospace/widgets/shimmer_card_widget.dart';
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
                              showMultimedia: true,

                              backgroundColor: Colors.white,
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

