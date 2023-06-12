import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projetopdi/pages/article_page.dart';
import 'package:projetopdi/pages/feed_page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> _newsArticles = [];
  int _visibleNewsCount = 5;
  bool _isWidget1Selected = true;

  Future<void> _getNews() async {
    var response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=a964128e026d428cb6c14992c24f9670'),
    );
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      setState(() {
        _newsArticles = jsonData['articles'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getNews();
  }

  void _navigateToArticle(String url, String journalName) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ArticlePage(url: url, journalName: journalName)),
    );
  }

  void _navigateToFeedPage() {
    setState(() {
      _isWidget1Selected = false;
    });
  }

  void _showMoreNews() {
    setState(() {
      _visibleNewsCount += 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              color: Color.fromRGBO(253, 250, 223, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 16.0,
                  top: (MediaQuery.of(context).size.height * 1 / 8 -
                          MediaQuery.of(context).size.height * 1 / 16) /
                      2,
                  child: IconButton(
                    onPressed: () {
                      // Perform action on icon button press
                    },
                    icon: Icon(
                      // Replace with your custom icon
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  right: 16.0,
                  top: (MediaQuery.of(context).size.height * 0.04),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 1 / 32,
                    backgroundImage: AssetImage(
                        'lib/images/ea22b48af50725aac57cff4f97c045fe.1000x1000x1.jpg'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: _isWidget1Selected ? 2 : 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isWidget1Selected = true;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: _isWidget1Selected
                            ? Color.fromRGBO(253, 250, 223, 1)
                            : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Noticias',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: _isWidget1Selected ? 1 : 2,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isWidget1Selected = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: _isWidget1Selected
                            ? Colors.white
                            : Color.fromRGBO(253, 250, 223, 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Feed',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AnimatedCrossFade(
                    duration: Duration(milliseconds: 500),
                    crossFadeState: _isWidget1Selected
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Column(
                      children: [
                        for (var index = 0;
                            index < _visibleNewsCount &&
                                index < _newsArticles.length;
                            index++)
                          GestureDetector(
                            onTap: () {
                              _navigateToArticle(_newsArticles[index]['url'],
                                  _newsArticles[index]['source']['name']);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _newsArticles[index]['title'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text(
                                              _newsArticles[index]['source']
                                                  ['name'],
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Flexible(
                                        flex: 1,
                                        child: _newsArticles[index]
                                                    ['urlToImage'] ==
                                                null
                                            ? Container()
                                            : Image.network(_newsArticles[index]
                                                ['urlToImage']),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (_visibleNewsCount < _newsArticles.length)
                          TextButton(
                            onPressed: _showMoreNews,
                            child: Text(
                              'Show More News',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                      ],
                    ),
                    secondChild: FeedPage(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
