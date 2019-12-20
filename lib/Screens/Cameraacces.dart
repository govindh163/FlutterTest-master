import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  VideoPlayerController _controller;

  File _fileImage;
  File _fileVideo;
  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }
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
  Future getVideo(bool isCamera)async{
    File fileVideo;
    if(isCamera){
      fileVideo= await ImagePicker.pickVideo(source: ImageSource.camera);
    }
    else {
      fileVideo=await ImagePicker.pickVideo(source: ImageSource.gallery);
    }
     setState(() {
      _fileVideo= fileVideo;
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
    final Video = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: FlatButton.icon(
        label:  Text('Open Video Camera'),
        icon:Icon(Icons.camera_alt),
        onPressed: () {
          getVideo(true);
        },
        padding: EdgeInsets.all(16),
        color: Colors.lightBlueAccent,
      ),
    );
    final Videogal = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: FlatButton.icon(
        label:  Text('Open Video '),
        icon:Icon(Icons.camera_alt),
        onPressed: () {
          getVideo(false);
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
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[ button,forgotLabel,Video,Videogal,
            _fileImage==null?Container(
              child: Center(
                child: Text("If you choose or Take photo it will be displayed here"),
              ),
            ):Image.file(_fileImage,height: 500,width:300,fit: BoxFit.fill,),
            _fileVideo==null?Container(
              child: Center(
                child: Text("If you choose or Take Video it will be displayed here"),
              ),
            ):  StatusVideo(
              videoPlayerController: VideoPlayerController.file(_fileVideo),
              looping: true,
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Access Camera'),),
      body: body,
    );
  }
}


class StatusVideo extends StatefulWidget {

  final VideoPlayerController videoPlayerController;
  final bool looping;

  final double aspectRatio;

  StatusVideo({
    @required this.videoPlayerController,
    this.looping,

    this.aspectRatio,
    Key key,
  }): super(key:key);

  @override
  _StatusVideoState createState() => _StatusVideoState();
}

class _StatusVideoState extends State<StatusVideo> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        autoInitialize:true,
        looping: widget.looping,
        allowFullScreen: true,
        aspectRatio: 6/9,
        //autoPlay: true,
        errorBuilder: (context, errorMessage){
          return Center(child: Text(errorMessage),);
        }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 0),
            child: AspectRatio(
              aspectRatio: 6/10,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}