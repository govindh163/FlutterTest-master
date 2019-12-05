import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSPluginRecipe extends StatefulWidget {
  @override
  _TTSPluginRecipeState createState() => _TTSPluginRecipeState();
}

class _TTSPluginRecipeState extends State<TTSPluginRecipe> {
  final TextEditingController _descriptioncontroller = TextEditingController();

  String description =
      "Hey Flutter";
  bool isPlaying = false;
  FlutterTts _flutterTts;
  dynamic language;
  dynamic voice;

  @override
  void initState() {
    super.initState();
    initializeTts();
  }

  @override
  void dispose() {
    super.dispose();
    _flutterTts.stop();
  }

  initializeTts() {
    _flutterTts = FlutterTts();

    _flutterTts.setStartHandler(() {
      setState(() {
        isPlaying = true;
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    _flutterTts.setErrorHandler((err) {
      setState(() {
        print("error occurred: " + err);
        isPlaying = false;
      });
    });
  }

  void setTtsLanguage() async {
    await _flutterTts.setLanguage("en-US");
    List<dynamic> languages = await _flutterTts.getLanguages;
    print(languages);
  }

  void speechSettings1() {
    _flutterTts.setVoice("en-us-x-sfg#male_1-local");
    _flutterTts.setPitch(1.5);
    _flutterTts.setSpeechRate(.9);
  }

  void speechSettings2() {
    _flutterTts.setVoice("en-us-x-sfg#male_2-local");
    _flutterTts.setPitch(1);
    _flutterTts.setSpeechRate(0.5);
  }

  Future _speak(String text) async {
    if (text != null && text.isNotEmpty) {
      var result = await _flutterTts.speak(text);
      if (result == 1)
        setState(() {
          isPlaying = true;
        });
    }
  }

  Future _stop() async {
    var result = await _flutterTts.stop();
    if (result == 1)
      setState(() {
        isPlaying = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alexa"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    colors: [Colors.orange, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Hey Flutter",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.25,
                            width: MediaQuery.of(context).size.width / 1.25,
                            child: Image.network(
                                "https://picsum.photos/id/237/200/300"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                    controller: _descriptioncontroller,
                    onChanged: (value) {
                     setState(() {
                       description = value;
                     });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Type words to speak',
                    )),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(description),
                ),
                playButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget playButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 30.0, right: 30.0, bottom: 20.0),
            child: FlatButton(
              onPressed: () {
                //fetch another image
                setState(() {
                  //speechSettings1();
                  isPlaying ? _stop() : _speak(description);
                });
              },
              child: isPlaying
                  ? Icon(
                Icons.stop,
                size: 60,
                color: Colors.red,
              )
                  : Icon(
                Icons.play_arrow,
                size: 60,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
