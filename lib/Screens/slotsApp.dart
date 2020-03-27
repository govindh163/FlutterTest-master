
import 'dart:math';
import 'dart:async';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sweetsheet/sweetsheet.dart';

class SlotsApp extends StatefulWidget {
  @override
  _SlotsAppState createState() => _SlotsAppState();
}

class _SlotsAppState extends State<SlotsApp> {
  final SweetSheet _sweetSheet = SweetSheet();
 int point=1000;
 bool isWin=true;
  List image=["assets/apple.png","assets/icons8-cherry.png","assets/icons8-star-512.png"];
  List num=[0,1,2];
  final _random = new Random();
 // var element = image[_random.nextInt(image.length)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Slots App"),),
      backgroundColor: Color(0XFFDBDBE8),
      body:Column(
       children: <Widget>[
         SizedBox(height: 30,),
        _getButton(  () => Navigator.pushNamed(context, "/slide") , "Slidable"),
         Container(
           padding: EdgeInsets.all(8),
           child: IndexedStack(
             children: <Widget>[
               Text(
                 "Credits Point: $point",
                 style: TextStyle(
                   color:isWin?Colors.green:Colors.red,
                   fontWeight: FontWeight.bold,
                   fontSize: 25,
                 ),
               ),
             ],
           ),
         ),
         SizedBox(height: 10,),
         _getButton( () => Navigator.pushNamed(context, "/crop"), "Crop Image"),
         Center(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
               Flexible(
                 flex:1,
                 child:  _getImageContainer(image[num[0]]),
               ),
               Flexible(
                 flex:1,
                 child:  _getImageContainer(image[num[1]]),
               ),
               Flexible(
                 flex:1,
                 child:  _getImageContainer(image[num[2]]),
               ),
             ],
           ),
         ),
         SizedBox(height: 50,),
         _getButton(_randomise,"Spin"),
         SizedBox(height: 10,),
         _getButton(getSheet,"Sheet"),
       ],
      )
    );
  }
  getSheet(){
    _sweetSheet.show(
      context: context,
      title: "Delete this post?",
      description: "This action will permanently delete this post.",
      type: SweetSheetType.WARNING,
      icon: Icons.delete,
      positive: SweetSheetAction(
        onPressed: () {
          Navigator.of(context).pop();
        },
        title: 'CANCEL',
      ),
      negative: SweetSheetAction(
        onPressed: () {
          Navigator.of(context).pop();
        },
        title: 'DELETE',
      ),
    );
  }
  _getImageContainer(fileImage){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)) ,
      color: isWin?Colors.green:Colors.red,
//      height:50 ,
//      width: 50,
      child: Image.asset(fileImage,fit: BoxFit.fitWidth,),
    ) ;
  }
  addPoint(){
    point=point+30;
  }
 deductPoint(){
   point=point-5;
 }
  _randomise(){
    num[0]=_random.nextInt(num.length-1);
    num[1]=_random.nextInt(num.length);
    num[2]=_random.nextInt(num.length);
    setState(() {});
     if(num[0]==num[1]&&num[1]==num[2]){
       addPoint();
       isWin=true;
       Fluttertoast.showToast(
         msg: 'You Win ',
         textColor: Colors.white,
         backgroundColor: Colors.green
       );
     }else{
       deductPoint();
       isWin=false;
       Fluttertoast.showToast(
         msg: 'Mismatch Try Again',
         textColor: Colors.white,
         backgroundColor: Colors.red
       );
     }
  }
  _getButton(fun,String text ){
    return SizedBox(
      width: 150,
      height: 70,
      child: FlatButton(
        color: Colors.blueGrey,
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        textColor: Colors.white,
        onPressed: fun,
        child: Text(text,style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}

class CropImage extends StatefulWidget {
  @override
  _CropImageState createState() => _CropImageState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _CropImageState extends State<CropImage> {
  AppState state;
  File imageFile;

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Cropper"),
      ),
      body: Center(
        child: imageFile != null ? Image.file(imageFile) : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          if (state == AppState.free)
            _pickImage();
          else if (state == AppState.picked)
            _cropImage();
          else if (state == AppState.cropped) _clearImage();
        },
        child: _buildButtonIcon(),
      ),
    );
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(Icons.add);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.clear);
    else
      return Container();
  }

  Future<Null> _pickImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        )
    );
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }
}

class Sliderdev extends StatefulWidget {
  @override
  _SliderdevState createState() => _SliderdevState();
}
class _SliderdevState extends State<Sliderdev> {
  @override
  Widget build(BuildContext context) {
    final List<String> items =
    new List<String>.generate(10, (i) => "item  ${i + 1}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Slideable Example"),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
          itemCount: items.length,
          itemBuilder: (context, int index) {
            return Slidable(
              actions: <Widget>[
                IconSlideAction(
                    icon: Icons.more,
                    caption: 'MORE',
                    color: Colors.blue,
                    onTap: () {
                      print("More ${items[index]} is Clicked");
                    }
                ),
              ],
              secondaryActions: <Widget>[
                IconSlideAction(
                    icon: Icons.clear,
                    color: Colors.red,
                    caption: 'Cancel',
                    onTap: () {
                      print("Cancel ${items[index]} is Clicked");
                    }
                )
              ],
              child: ListTile(
                leading: Icon(Icons.message),
                title: Text("${items[index]}"),
                subtitle: Text("Slide left or right"),
                trailing: Icon(Icons.arrow_back),
              ),
              actionPane: SlidableDrawerActionPane(),
            );
          }),
    );
  }
}