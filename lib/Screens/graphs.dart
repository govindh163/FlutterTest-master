import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatisticsPage extends StatefulWidget {

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    final List<SubscriberSeries>data=[
      SubscriberSeries(
          year: '2008',
          subcribers: 10000000,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)
      ),
      SubscriberSeries(
          year: '2009',
          subcribers: 11000000,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)
      ),
      SubscriberSeries(
          year: '2010',
          subcribers: 12000000,
          barColor: charts.ColorUtil.fromDartColor(Colors.redAccent)
      ),
      SubscriberSeries(
          year: '2011',
          subcribers: 11000000,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)
      ),
      SubscriberSeries(
          year: '2012',
          subcribers: 8500000,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)
      ),
      SubscriberSeries(
          year: '2013',
          subcribers: 10000000,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)
      ),
      SubscriberSeries(
          year: '2013',
          subcribers: 6000000,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)
      ),
      SubscriberSeries(
          year: '2018',
          subcribers: 6000000,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)
      ),
    ];
    return Scaffold(
        appBar: AppBar(title: Text('Statistics'),),
        body:  SubscriberChart(
          data: data,
        )
    );
  }
}

class SubscriberSeries{
  final String year;
  final int subcribers;
  final charts.Color barColor;

  SubscriberSeries({this.barColor,this.subcribers,this.year});


}
class SubscriberChart extends StatelessWidget {
  final List<SubscriberSeries> data;
  SubscriberChart({this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<SubscriberSeries,String>>series=[
      charts.Series(
        id:'Subscribe',
        data: data,
        domainFn:  (SubscriberSeries series,_)=>series.year,
        measureFn: (SubscriberSeries series,_)=>series.subcribers,
        colorFn: (SubscriberSeries series,_)=>series.barColor,
      ),
    ];
    return  Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Column(
          children: <Widget>[
            Text("World Chart",style: Theme.of(context).textTheme.body2,),
            Expanded(child: charts.BarChart(series,animate: true,))
          ],
        ),
      ),
    );
  }
}
