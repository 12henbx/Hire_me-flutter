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
import 'package:pucukan_flutter_app/util/firebaseUtil.dart';
import 'package:pucukan_flutter_app/Sign up2.dart';
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
      home: new SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  final BaseAuth auth;

  const SignUpPage({Key key, this.auth}) : super(key: key);
  @override
  State createState() => new SignUpPageState();
}

class SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
  bool _isLoading = false;

  String _email, _password, _konfirmpass;

  @override
  void initState() {
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

  void _signUp(String user, String pass) {
    setState(() {
      if (validateEmail(user) == null) {
        _isLoading = true;
        firebaseAnonymouslyUtil
            .createUser(user, pass)
            .then((String user) => login(user, pass));
        //.catchError((e) => loginError(e));
      }
    });
  }

  void login(String email, String pass) {
    firebaseAnonymouslyUtil
        .signIn(email, pass)
        .then((FirebaseUser user) => moveUserDashboardScreen(user));
    //.catchError((e) => loginError(e));
  }

  @override
  void moveUserDashboardScreen(FirebaseUser currentUser) {
    Navigator.of(context).push<String>(
      new MaterialPageRoute(
        builder: (context) => first.JobListScreen(),
      ),
    );
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
    ),child:
        Scaffold(
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
                    new Padding(padding: const EdgeInsets.only(top: 30.0)),
                    new Container(
                      padding: const EdgeInsets.all(25.0),
                      child: new Form(
                        autovalidate: true,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Email :",
                              ),
                              keyboardType: TextInputType.emailAddress,
                              //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                              onSaved: (value) => _email = value,
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Password :",
                              ),
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              //validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                              onSaved: (value) => _password = value,
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Konfirmasi Password :",
                              ),
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                              onSaved: (value) => _konfirmpass = value,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
              )
          ),
                /*new Image(
          image: new AssetImage("assets/girl.jpeg"),
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
          color: Colors.black87,
        ),*/
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
                            MaterialPageRoute(builder: (context) => SignUp2Page()),
                          );
                        },
                      ),
                      new Padding(padding: const EdgeInsets.only(bottom: 40.0)),
                    ]
                )
                ),
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

/*
  ///
  /// OCR Method
  ///
  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        flash: _torchOcr,
        autoFocus: _autoFocusOcr,
        multiple: _multipleOcr,
        waitTap: _waitTapOcr,
        showText: _showTextOcr,
        preview: _previewOcr,
        camera: _cameraOcr,
        fps: 2.0,
      );
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }

    if (!mounted) return;

    setState(() => _textsOcr = texts);
  }*/

