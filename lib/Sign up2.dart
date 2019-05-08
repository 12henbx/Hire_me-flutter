import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pucukan_flutter_app/Home.dart' as first;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pucukan_flutter_app/Authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pucukan_flutter_app/util/AppUtil.dart';
import 'package:camera/camera.dart';
import 'package:pucukan_flutter_app/util/firebaseUtil.dart';
import 'package:pucukan_flutter_app/Sign up3.dart';
//import 'package:pucukan_flutter_app/util/cameraUtil.dart';
import 'package:pucukan_flutter_app/cameraView.dart' as camera;

//import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
//import 'package:pucukan_flutter_app/JoblistScreen.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
FirebaseAnonymouslyUtil firebaseAnonymouslyUtil;
bool _isLoading = false;

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new SignUp2Page(),
    );
  }
}

class SignUp2Page extends StatefulWidget {
  final BaseAuth auth;
  const SignUp2Page({Key key, this.auth}) : super(key: key);
  @override
  State createState() => new SignUp2PageState();
}

class SignUp2PageState extends State<SignUp2Page>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  String _email, _password, _konfirmpass;

  @override
  void initState() {
    for (int i=1961;i<2004;i++){
      Tahun_list.add(i.toString());
    }
    super.initState();

    /*FlutterMobileVision.start().then((previewSizes) => setState(() {
      _previewOcr = previewSizes[_cameraOcr].first;
    }));*/
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [const Color(0xFF143549), const Color(0xff102343)],
    begin: FractionalOffset.topRight,
    end: FractionalOffset.bottomLeft,
    stops: [0.0,1.0],
    tileMode: TileMode.clamp
    ),
    ),child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomPadding: false,
        body: new Stack(fit: StackFit.expand, children: <Widget>[
          new Theme(
              data: new ThemeData(
                  brightness: Brightness.dark,
                  fontFamily: 'OpenSans',
                  inputDecorationTheme: new InputDecorationTheme(
                    // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                    labelStyle:
                    new TextStyle(color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400),
                  )),
              isMaterialAppTheme: true,
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.only(top: 80.0)),
                    new RichText(
                      text: TextSpan(text: 'Pendaftaran akun',
                          style: TextStyle(
                            fontFamily: 'OpenSans', fontSize: 36,)
                      ),
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 15.0)),
                    new RichText(
                      text: TextSpan(text: 'Unggah data kependudukan :',
                          style: TextStyle(
                            fontFamily: 'OpenSans', fontSize: 24,)
                      ),
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 50.0)),
                    new Container(
                      padding: const EdgeInsets.all(25.0),
                      child: new Form(
                        autovalidate: true,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              padding: EdgeInsets.only(right: 8),
                              child:
                            new FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              onPressed: () => {Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => camera.CameraTest()),
                              )},
                              color: Colors.lightBlue[100],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,// Replace with a Row for horizontal icon + text
                                children: <Widget>[
                                  Icon(Icons.file_upload, size: 88),
                                  Text("Unggah berkas"),
                                ],
                              ),
                            ), width: 150.0, height: 150.0,
                            ), new Container(
                              padding: EdgeInsets.only(left: 8),
                              child:
                            new FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUp3Page()),
                                )
                              },
                              color: Colors.lightBlue[100],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,// Replace with a Row for horizontal icon + text
                                children: <Widget>[
                                  Icon(Icons.edit, size: 88),
                                  Text("Isi manual"),
                                ],
                              ),
                            ), width: 150.0, height: 150.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ]
              )
          ),/*
          new Theme(
              data: new ThemeData(
                  brightness: Brightness.dark,
                  fontFamily: 'OpenSans',
                  inputDecorationTheme: new InputDecorationTheme(
                    // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                    labelStyle:
                    new TextStyle(color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400),
                  )),
              isMaterialAppTheme: true,
              child:
              new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new MaterialButton(
                      height: 50.0,
                      minWidth: 150.0,
                      color: Color(0xffE0FFFF),
                      splashColor: Color(0xFF143549),
                      textColor: Color(0xff102343),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                      child: new Text(
                        'Selanjutnya', style: TextStyle(fontSize: 20),),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp3Page()),
                        );
                      },
                    ),
                    new Padding(padding: const EdgeInsets.only(bottom: 40.0)),
                  ]
              )
          )*/
          /*new Image(
          image: new AssetImage("assets/girl.jpeg"),
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
          color: Colors.black87,
        ),*/
        ]
        )
    ));
  }


  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      AppUtil().showAlert("Email is Required");
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      AppUtil().showAlert("Invalid Email");
      return "Invalid Email";
    } else {
      return null;
    }
  }
}