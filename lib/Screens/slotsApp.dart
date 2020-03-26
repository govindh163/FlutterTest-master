
import 'dart:math';

import 'package:flutter/material.dart';
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
         SizedBox(height: 70,),
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
         SizedBox(height: 120,),
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

