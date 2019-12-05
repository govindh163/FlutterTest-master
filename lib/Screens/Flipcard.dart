import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardFlip extends StatefulWidget {
  @override
  _CardFlipState createState() => _CardFlipState();
}

class _CardFlipState extends State<CardFlip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("India"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Card(
            color: Colors.orangeAccent,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                print('Card tapped.');
              },
              child: Container(
                width: 300,
                height: 40,
                child: Center(
                  child: Text('INDIA',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                children: <Widget>[
                  FlipCard(
                    direction: FlipDirection.HORIZONTAL,
                    front: CountryCard(title: 'Capital',color: Colors.orange,),
                    back: CountryDetailCard(
                      title: "Delhi",
                      color: Colors.deepOrange,
                    ),
                  ),
                  FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: CountryCard(title: 'Population'),
                    back: CountryDetailCard(
                      title: "5555",
                      color: Colors.deepPurple,
                    ),
                  ),
                  FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: CountryCard(title: 'Flag',color: Colors.green,),
                    back: Card(
                      color: Colors.white,
                      elevation: 10,
                      child: Center(
                          child: SvgPicture.network(
                        "https://restcountries.eu/data/ind.svg",
                        width: 200,
                      )),
                    ),
                  ),
                  FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: CountryCard(title: 'Currency',),
                    back: CountryDetailCard(
                      title: "₹",
                      color: Colors.blue,
                    ),
                  ),
//            GestureDetector(
//                onTap: () {
//                  Navigator.of(context).pushNamed(CountryMap.routeName,
//                      arguments: {
//                        'name': country['name'],
//                        'latlng': country['latlng']
//                      });
//                },
//                child: CountryCard(title: 'Show on Map')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CountryDetailCard extends StatelessWidget {
  final String title;
  final MaterialColor color;
  CountryDetailCard({this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 10,
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final String title;
  final Color color;
  const CountryCard({Key key, this.title,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color:color ,
      elevation: 10,
      child: Center(
          child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
    );
  }
}
