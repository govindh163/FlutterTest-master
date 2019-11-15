import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class MessageList extends StatefulWidget {
  @override
  MessageListState createState() => new MessageListState();
}

class MessageListState extends State<MessageList> {

  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://www.mocky.io/v2/5da03e75300000f868524bff"),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState(){
    this.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Listviews"), backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new  ListTile(
            title: new Text(data[index]["fruit"]),
            subtitle:new Text(data[index]["size"]) ,
            leading: CircleAvatar(child: new Text(data[index]["color"]),),
          );
        },
      ),
    );
  }
}
