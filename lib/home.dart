import 'dart:async';
import 'dart:convert';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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

    Future<List<String>> loadNewsArticles() async {
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
                      Text('Temp',style: TextStyle(fontSize: 20),)
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
