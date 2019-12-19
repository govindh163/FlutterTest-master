import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:page_transition/page_transition.dart';
import 'package:swipedetector/swipedetector.dart';
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => new _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var headerList = ['English', 'தமிழ்'];
  var index = 0;
  List<News> _list = new List<News>();
  Future<List<News>> fetchNews() async {
    //Use your own api key if this stops working
    final response = await http.get(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=f8c15ba22b0b4ec08dd9f84c3480d709');
    Map map = json.decode(response.body);
    final responseJson = json.decode(response.body);
    //print(map['articles'][0]);
    //print(responseJson['articles'][1]);
    for (int i = 0; i < map['articles'].length; i++) {
      if (map['articles'][i]['author'] != null) {
        _list.add(new News.fromJson(map['articles'][i]));
      }
    }
    return _list;
  }

  _refresh() {
    setState(() {
      fetchNews();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void showToast() {
    Fluttertoast.showToast(
      msg:"Hy Flu",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          title: new Text('Inshorts swipe'),
          actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _refresh,
            )
          ],
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new DrawerHeader(
                child: new Column(
                  children: <Widget>[
                    new TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Search',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    new Expanded(
                      child: new GridView.count(
                        crossAxisCount: 2,
                        children: new List.generate(2, (index) {
                          return new Center(
                            child: new Text(
                              headerList[index],
                              style: new TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
                decoration: new BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              new CustomListTile(),
            ],
          ),
        ),
        body: new FutureBuilder(
            future: fetchNews(),
            builder:
                (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
              if (snapshot.hasData) {
                return SwipeDetector(
                  swipeConfiguration: SwipeConfiguration(
                      horizontalSwipeMaxHeightThreshold: 50.0,
                      horizontalSwipeMinDisplacement:50.0,
                      horizontalSwipeMinVelocity: 50.0),
                  child: new Dismissible(
                    key: Key(index.toString()),
                    direction: DismissDirection.vertical,
                    onDismissed: (direction) {
                      setState(() {
                        index++;
                      });
                    },
                    child: new Column(
                      children: <Widget>[
                        new Image.network(
                          snapshot.data[index].urlToImage,
                          fit: BoxFit.contain,
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(16.0),
                          child: new Text(
                            '${snapshot.data[index].title}',
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ),
                        new Padding(
                            padding: new EdgeInsets.all(16.0),
                            child: new Text(
                              '${snapshot.data[index].description}',
                              style: TextStyle(fontSize: 18.0),
                            )),
                      ],
                    ),
                  ),
                  onSwipeLeft: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: WebView(url:"${snapshot.data[index].url}")));
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Stack(
        children: <Widget>[
          new Image.network(
            "https://static-s.aa-cdn.net/img/ios/1364923832/10631815770314daa538bf1a859d345f?v=1",
            scale: 0.5,
          ),
          new Text('IPL 2020')
        ],
      ),
    );
  }
}

class News {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;

  News(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt});

  factory News.fromJson(Map<String, dynamic> json) {
    return new News(
        //  source: (json['source'] as List)
        //   ?.map((e) =>
        //       e == null ? null : new Source.fromJson(e as Map<String, dynamic>))
        //   ?.toList(),
        source: new Source.fromJson(json['source']),
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt']);
  }
}

class Source {
  String name;
  String id;

  Source({this.name, this.id});

  factory Source.fromJson(Map<String, dynamic> json) {
    return new Source(name: json['name'], id: json['id']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'name': name, 'id': id};
}
//return new ListView.builder(
//   itemCount: snapshot.data.length,
//   itemBuilder:(context, index) {return new Card(
//             child: new Column(
//     children: <Widget>[
//       new Image.network(snapshot.data[index].urlToImage,
//       fit: BoxFit.contain,),
//       new Padding(
//         padding: new EdgeInsets.all(16.0),
//                         child: new Text('${snapshot.data[index].title}',
//         style: new TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 20.0
//         ),),
//       ),
//       new Padding(
//         padding: new EdgeInsets.all(16.0),
//         child: new Text('${snapshot.data[index].description}',
//         style: TextStyle(
//           fontSize: 18.0
//         ),))
//     ],
//   ),
// );
//   }
//   );
class WebView extends StatelessWidget {
final String url;
WebView({@required this.url});
  @override
  Widget build(BuildContext context) {
    return  WebviewScaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: false,
          textInputAction: TextInputAction.go,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: url,
            hintStyle: TextStyle(color: Colors.black54),
          ),
        ),
      ),
      url: url,
      withZoom: false,
    );
  }
}
