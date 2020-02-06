import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';


class TfModel extends StatefulWidget {
  @override
  _TfModelState createState() => _TfModelState();
}

class _TfModelState extends State<TfModel> {
  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachable Machine Learning'),
      ),
      body: _loading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null ? Container() : Image.file(_image),
            SizedBox(
              height: 20,
            ),
            _outputs != null
                ? Text(
              "${_outputs[0]["label"]}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                background: Paint()..color = Colors.white,
              ),
            )
                : Container(),
            SizedBox(
              height: 20,
            ),
            _outputs != null?   Text(
              " This is ${_outputs[0]["confidence"]*100}%  True",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                background: Paint()..color = Colors.white,
              ),
            ):Container(
              width: 250,
              child: Center(child: Text("Pick a Dog or Cat Image I Can Differentiate It😉😏😏",style: TextStyle(
              color: Colors.pinkAccent,fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic
            ),),),),
//            Positioned(
//              top:30,
//              left: 20,
//              right: 30,
//              child:Container(
//                color: Colors.blue,
//                child: FloatingActionButton(
//                  onPressed: openCamera,
//                  child: Icon(Icons.camera_alt),
//                ),
//              )
//            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: Icon(Icons.image),
      ),
    );
  }

  openCamera()async{
  var  fileimage= await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image=fileimage;
    });
  }
  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}