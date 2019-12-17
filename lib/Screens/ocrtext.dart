import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  BottomBar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  int _counter = 0;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static   List<Widget> _widgetOptions = <Widget>[
    PaintIt(),
    Text(
      'Fav Emoji 😂🤣',
      style: optionStyle,
    ),
    Text(
      '😂❤🎉😍🤞👍🙌 Press Windows + : or ; key to get Instant emoji box In windows',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navy Bar"),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        itemCornerRadius: 8,
        onItemSelected:_onItemTapped,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Draw anything'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: Text('Write Name'),
            activeColor: Colors.purpleAccent,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Fav Emoji 😂🤣'),
            activeColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}

class PaintIt extends StatefulWidget {
  @override
  _PaintItState createState() => new _PaintItState();
}

class _PaintItState extends State<PaintIt> {
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox object = context.findRenderObject();
              Offset _localPosition =
              object.globalToLocal(details.globalPosition);
              _points = new List.from(_points)..add(_localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
          child: new CustomPaint(
            painter: new Signature(points: _points),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.clear),
        onPressed: () => _points.clear(),
      ),
    );
  }
}

class Signature extends CustomPainter {
  List<Offset> points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.pinkAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}