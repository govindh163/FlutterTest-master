import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class CallPhone extends StatefulWidget {
  @override
  _CallPhoneState createState() => _CallPhoneState();
}

class _CallPhoneState extends State<CallPhone> {
  var  phone = ' ';
  TextEditingController _numberController = TextEditingController();
  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  _callPhone() async {
    if (await canLaunch("tel://$phone")) {
      setState(() {
        phone = _numberController.text;
      });
      await launch("tel:$phone");
    } else {
      throw 'Could not Call Phone';
    }
  }
  _smsPhone() async {
    if (await canLaunch("sms://$phone")) {
      setState(() {
        phone = _numberController.text;
      });
      await launch("sms:$phone");
    } else {
      throw 'Could not Call Phone';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Call Phone from App Example')),
      body: Center(
          child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: _numberController,

                decoration: new InputDecoration(prefixText:'+91 ',labelText: "Enter your number"),
                keyboardType: TextInputType.number,
              ),
            ),
            RaisedButton(
              onPressed: _callPhone,
              child: Text('Call Phone'),
              color: Colors.red,
            ),
            RaisedButton(
              onPressed: _smsPhone,
              child: Text('Send Sms'),
              color: Colors.red,
            ),
            RaisedButton(
              onPressed: _smsPhone,
              child: Text('Access Contacts'),
              color: Colors.red,
            ),
          ],
          )),
    );
  }
  
}