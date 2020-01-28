import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Signup extends StatefulWidget {

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            TopBar_signup(),
            Positioned(
              top: 40,
              left: 4,
              child: IconButton(
                onPressed: () {},
                color: Colors.white,
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            Positioned(
              top: 210,
              left: 44,
              child: Text(
                'Welcome\nBack',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 34,right: 34,top: 400,bottom: 50),
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 34,right: 34,bottom: 44),
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 44.0),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              wordSpacing: 2,
                              color: Colors.grey[800]
                          ),
                        ),
                      ),
                      Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[800],
                          radius: 40,
                          child: Icon(Icons.arrow_forward,size: 28,color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              wordSpacing: 2,
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            wordSpacing: 2,
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}

class TopBar_signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 360.0,
      ),
      painter: Signuppainter(),
    );
  }
}

class Signuppainter extends CustomPainter{

  Color colorOne = Colors.orange[500];
  Color colorTwo = Colors.grey[800];
  Color colorThree = Colors.blue[400];

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();


    path.lineTo(size.width * 0.4, 0);
    path.quadraticBezierTo(size.width * 0.50, size.height * 1.4, size.width * 1.44, size.height );
    path.lineTo(size.width, 0);
    path.close();

    paint.color = colorThree;
    canvas.drawPath(path, paint);



    path = Path();
    path.lineTo(0, size.height * 0.90);
    path.quadraticBezierTo(size.width *0.6, size.height * 1.34, size.width * 0.58, size.height * 0.74);
    path.quadraticBezierTo(size.width * 0.58, size.height * 0.4, size.width * 0.8, size.height * 0.3);
    path.quadraticBezierTo(size.width, size.height * 0.23, size.width,size.height * 0.14);
    path.lineTo(size.width,0);
    path.close();

    paint.color = colorTwo;
    canvas.drawPath(path, paint);




    path = Path();
    path.lineTo(0, size.height * 0.54);
    path.quadraticBezierTo(size.width *0.14, size.height * 0.54, size.width * 0.18, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.23, size.height * 0.24, size.width * 0.4, size.height * 0.19);
    path.quadraticBezierTo(size.width * 0.64, size.height * 0.11, size.width * 0.64,0);
    path.lineTo(size.width,0);
    path.close();

    paint.color = colorOne;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

}