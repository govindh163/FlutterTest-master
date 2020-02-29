import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadImage extends StatefulWidget {
  _DownloadImageState createState() => _DownloadImageState();
}

class _DownloadImageState extends State<DownloadImage> {
  TextEditingController _controller = TextEditingController(
      text: "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search/jcr_content/main-pars/image/visual-reverse-image-search-v2_intro.jpg");
  var imgUrl = "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search/jcr_content/main-pars/image/visual-reverse-image-search-v2_intro.jpg";
  var dio = Dio();
  var progress = "";
  bool downloading = false;
  Future download1(Dio dio, String url) async {
    CancelToken cancelToken = CancelToken();

    Directory directory = await getExternalStorageDirectory();
    if(!Directory("${directory.path}/Downloaded Status/Videos").existsSync()){
      Directory("${directory.path}/Downloaded Status/Videos").createSync(recursive: true);
    }
    try {
      await dio.download(url, "${directory.path}/Downloaded Status/Videos",
          onReceiveProgress: showDownloadProgress, cancelToken: cancelToken);
    } catch (e) {
      print(e);
    }
  }
  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
  Future<void> _download() async {
    Dio dio = Dio();
    Directory dirToSave = await getExternalStorageDirectory();
    if(!Directory("${dirToSave.path}/Downloaded Status/Videos").existsSync()){
      Directory("${dirToSave.path}/Downloaded Status/Videos").createSync(recursive: true);
    }
    await dio.download(_controller.text, "${dirToSave.path}/myImage.jpg",
        onReceiveProgress: (rec, total) {
          setState(() {
            downloading = true;
            progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
          });
        });

    try {} catch (e) {
      throw e;
    }
    setState(() {
      downloading = false;
      progress = "Complete";
    });
  }
  var url =
      "https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action@1.0/docs/imgs/book.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Download Any Image'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            downloading ? CircularProgressIndicator() : SizedBox(),
            SizedBox(height: 10),
              Text(progress)  ,
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter image URL',
                ),
              ),
            ),
            SizedBox(height: 30),
            RaisedButton(
              child: Text('Download'),
              onPressed:  (){
              download1(dio, url,);
               // _download();
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}