import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:pucukan_flutter_app/Home.dart' as first;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pucukan_flutter_app/Authentication.dart';
import 'package:pucukan_flutter_app/Sign up.dart' as signup;
import 'package:pucukan_flutter_app/Home_Page.dart' as home;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:pucukan_flutter_app/JoblistScreen.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.teal),
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  final BaseAuth auth;

  const LoginPage({Key key, this.auth}) : super(key: key);
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  String _email='', _password='';

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  void _handleSignUp() async{

    _email = await widget.auth.signIn(_email, _password);
    print('Signed in: $_email');
  }

  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/hire_me.png');

    return new Container(
        decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [const Color(0xFF143549), const Color(0xff102343)],
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
    stops: [0.0,1.0],
    tileMode: TileMode.clamp
    ),
    ),child: Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomPadding: false,
      body: new Stack(fit: StackFit.expand, children: <Widget>[
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
                new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w400),
              )),
          isMaterialAppTheme: true,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image(image: assetsImage, width: 280.0), //height: 48.0),
              new Container(
                padding: const EdgeInsets.all(30.0),
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
                        //validator:(value) => _email==null ? 'Email can\'t be empty' : null,
                        onSaved: (value) => _email = value,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Password :",
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        //validator: value) => _password==null ? 'Password can\'t be empty' : null,
                        onSaved: (value) => _password = value,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 70.0),
                      ),
                      new MaterialButton(
                        height: 50.0,
                        minWidth: 150.0,
                        color: Color(0xffE0FFFF),
                        splashColor: Color(0xFF143549),
                        textColor: Color(0xff102343),
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                        child: new Text('Login',style: TextStyle(fontSize: 22),),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => home.MyHome()),
                          );
                        },
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top:14.0),
                      ),
                      new FlatButton(
                          child: new Text('Belum punya akun? Daftar',style: TextStyle(fontSize: 14),textAlign: TextAlign.center,), color: null, onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => signup.MyApp()));
                      },),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    ));
  }

}
