import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:pucukan_flutter_app/Home.dart' as first;
import 'package:google_sign_in/google_sign_in.dart';


void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        backgroundColor: Colors.transparent,
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Image.asset('assets/Deskripsi.png',width: 360,height: 672), ]
        )
    );
  }
}

