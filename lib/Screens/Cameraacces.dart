import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  File _fileImage;

  Future getImage(bool isCamera)async{
    File fileimage;
    if(isCamera){
      fileimage= await ImagePicker.pickImage(source: ImageSource.camera);
    }
    else {
      fileimage=await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _fileImage= fileimage;
    });
  }

  @override
  Widget build(BuildContext context) {

    final button = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: FlatButton.icon(
        label: Text('Add the Image'),
        icon:Icon(Icons.add_a_photo),
        onPressed: () {
          getImage(false);
        },
        padding: EdgeInsets.all(16),
        color: Colors.lightBlueAccent,

      ),
    );

    final forgotLabel = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: FlatButton.icon(
        label:  Text('Open Camera'),
        icon:Icon(Icons.camera_alt),
        onPressed: () {
          getImage(true);
        },
        padding: EdgeInsets.all(16),
        color: Colors.lightBlueAccent,
      ),
    );
    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: Column(
        children: <Widget>[ button,forgotLabel,
          _fileImage==null?Container(
            child: Center(
              child: Text("If you choose or Take photo it will be displayed here"),
            ),
          ):Image.file(_fileImage,height: 500,width:300,fit: BoxFit.fill,)
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Access Camera'),),
      body: body,
    );
  }
}
