import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:ospace/model/news.dart';
import 'package:ospace/publisher/controllers/post/post.dart';
import 'package:ospace/publisher/screens/post/news_detail.dart';
import 'package:ospace/screens/custom_inapp_webview.dart';
import 'package:ospace/service/api_helper.dart';
import 'package:ospace/widgets/shimmer_card_widget.dart';
import 'package:shimmer/shimmer.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> links = [];
  List<int> allStoryIds = [];
  List<LocalNews> localNewsList = [];
  bool isLoadingMore = false;
  bool isLoadingInitial = true;
  int currentPage = 0;
  final int pageSize = 30;
  String tempC = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadLocalNews();
    // print(localNewsList[0]);
    loadInitialNews();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

Future<void> loadLocalNews() async {
  setState(() {
    isLoadingInitial = true;
  });

  localNewsList = await NewsService().getAllNews();
  print('Local News List: $localNewsList'); // Check if data is loaded

  if (mounted) {
    setState(() {
      isLoadingInitial = false;
    });
  }
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
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          // Tabs without AppBar
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Global News'),
              Tab(text: 'Local News'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Global News Tab with RefreshIndicator
                RefreshIndicator(
                  onRefresh: loadInitialNews,
                  child: Column(
                    children: [
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
                                                  child: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 40,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                )
                                              : Icon(
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

                // Local News Tab with RefreshIndicator
                RefreshIndicator(
                  onRefresh: loadLocalNews,
                  child: isLoadingInitial
                      ? Center(child: CircularProgressIndicator())
                      : localNewsList.isEmpty
                          ? Center(child: Text('No local news available'))
                          : ListView.builder(
                              itemCount: localNewsList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(localNewsList[index].coverImage!
                                        .replaceFirst('localhost', '192.168.43.131')),
                                  ),
                                  title: Text(localNewsList[index].title!),
                                  subtitle: Text('by ${localNewsList[index].publisherUserName!}'),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NewsDetailPage(news: localNewsList[index]),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
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
