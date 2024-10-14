import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:ospace/service/api_helper.dart';
import 'package:ospace/widgets/shimmer_card_widget.dart';
import 'package:weather_pack/weather_pack.dart';
import 'package:shimmer/shimmer.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<String> links = []; // Stores the currently visible links
  List<int> allStoryIds = []; // Stores all the story IDs from the first API call
  bool isLoadingMore = false;
  bool isLoadingInitial = true; // Initial loading state
  int currentPage = 0;
  final int pageSize = 30; // Number of articles to load at once
  String tempC = '';
  Image weatherImage = Image.asset(
    width: 50,
    height: 50,
    ImagePathWeather.getPathWeatherIcon('13d'),
    package: ImagePathWeather.packageName,
  );

  @override
  void initState() {
    super.initState();
    fetchWeather();
    loadInitialNews();
  }

  // Fetch the initial list of news stories
  Future<void> loadInitialNews() async {
    setState(() {
      isLoadingInitial = true; // Set initial loading state to true
    });

    // Fetch all the story IDs (only once)
    allStoryIds = await ApiHelper().fetchNewsStoryIds();

    // Load the first page of stories
    await loadMoreNews();
  if (mounted) {
    setState(() {
      isLoadingInitial = false; // Initial load finished
    });
  }
  }
// Fetch the weather information and update the state
Future<void> fetchWeather() async {
  final apiHelper = ApiHelper();
  await apiHelper.getOnecallWeatherWays(api: '3721410d028c8efa237d9196d80a6061');

  if (mounted) {
    setState(() {
      tempC = apiHelper.worksTempUnits(temp: apiHelper.currently?.temp ?? 270);
      weatherImage = apiHelper.getWeatherIcon(apiHelper.currently?.weatherIcon ?? '13d');
    });
  }
}

// Load more news articles based on currentPage and pageSize
Future<void> loadMoreNews() async {
  if (currentPage * pageSize >= allStoryIds.length) return; // No more stories to load

  if (mounted) {
  setState(() {
    isLoadingMore = true;
  });
  }
  // Get the story IDs for the current page
  final start = currentPage * pageSize;
  final end = (start + pageSize > allStoryIds.length) ? allStoryIds.length : start + pageSize;
  final storyIdsToLoad = allStoryIds.sublist(start, end);

  // Fetch story details and append them to the list of links
  final newLinks = await ApiHelper().loadNewsArticlesByIds(storyIdsToLoad);

  if (mounted) {
    setState(() {
      links.addAll(newLinks);
      isLoadingMore = false;
      currentPage++; // Increment the page for future "Load More" actions
    });
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
              // Header with weather and BTC info
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

              // News list with shimmer effect for loading
              Flexible(
                child: isLoadingInitial
                    ? ListView.builder(
                        itemCount: 10, // Placeholder shimmer items during initial loading
                        itemBuilder: (context, index) {
                          return ShimmerNewsCard();
                        },
                      )
                    : ListView.builder(
                        itemCount: links.length + 1, // Extra item for the "Load More" button
                        itemBuilder: (context, index) {
                          if (index == links.length) {
                            // Show "Load More" icon
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

                          // Show news item
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
  errorWidget: Container(), // Use Container() instead of SizedBox()
)

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
