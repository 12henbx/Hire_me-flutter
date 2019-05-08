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
import 'package:pucukan_flutter_app/Home_Page.dart' as home;
import 'package:pucukan_flutter_app/Pencarian_tab.dart' as pencarian;
import 'package:pucukan_flutter_app/util/firebaseUtil.dart';

//import 'package:pucukan_flutter_app/util/cameraUtil.dart';
import 'package:pucukan_flutter_app/cameraView.dart' as camera;

//import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
//import 'package:pucukan_flutter_app/JoblistScreen.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
FirebaseAnonymouslyUtil firebaseAnonymouslyUtil;
bool _isLoading = false;
String _email, _password, _konfirmpass;
List <String> Tanggal_list=['1', '2', '3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'];
List <String> Bulan_list=['Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember'];
List <String> Tahun_list = ['1960'];//=['1980','1981','1982','1983','1984','1985','1986','1987','1988','1989','1990','1991','1992','1993','1994','1995','1996','1997','1998','1999','2000','2001'];
String dropdownTanggal, dropdownBulan, dropdownTahun;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    iter();
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new SignUp3Page(),
    );
  }
}
void iter(){
  for (int i=1961;i<2004;i++){
    Tahun_list.add(i.toString());
  }
}

class SignUp3Page extends StatefulWidget {
  final BaseAuth auth;

  const SignUp3Page({Key key, this.auth}) : super(key: key);

  @override
  State createState() => new SignUp3PageState();
}

class SignUp3PageState extends State<SignUp3Page>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                    labelStyle: new TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400),
                  )),
              isMaterialAppTheme: true,
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.only(top: 80.0,left: 20)),
                    new RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Pendaftaran akun',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 36,
                          )),
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 20.0)),
                    new Container(
                      padding: const EdgeInsets.all(20.0),
                      child: new Form(
                        autovalidate: true,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Nama :",
                              ),
                              keyboardType: TextInputType.emailAddress,
                              //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                              onSaved: (value) => _email = value,
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Pendidikan terakhir :",
                              ),
                              keyboardType: TextInputType.text,
                              //validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                              onSaved: (value) => _password = value,
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Domisili :",
                              ),
                              keyboardType: TextInputType.text,
                              //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                              onSaved: (value) => _konfirmpass = value,
                            ),

                          ],
                        ),
                      ),
                    ),new Container(
                      padding: const EdgeInsets.all(15),
                    child:
                    new RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: 'Tanggal lahir :',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 18,
                          )),
                    ),),
                    new Theme(
                        data:
                        Theme.of(context).copyWith(
                          canvasColor: Color(0xFF102343),
                          hintColor: Colors.white,
                        ),
                      child:
                    new Container(
                        padding: const EdgeInsets.only(left:32, top: 10, right: 32),
                        child: new Form(
                            autovalidate: true,
                            child: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new DropdownButton<String>(
                                    hint: Text('Tanggal'),
                                    value:dropdownTanggal,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownTanggal = newValue;
                                      });
                                    },
                                    items: Tanggal_list//<String>['1', '2', '3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value,style: TextStyle(color: Colors.white),),
                                      );
                                    }).toList(),
                                  ),
                                  new Padding(padding: const EdgeInsets.only(right: 15.0)),
                                  new DropdownButton<String>(
                                    hint: Text('Bulan'),
                                    value:dropdownBulan,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownBulan = newValue;
                                      });
                                    },
                                    items: Bulan_list //<String>['1', '2', '3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value,style: TextStyle(color: Colors.white),),
                                      );
                                    }).toList(),
                                  ),
                                  new Padding(padding: const EdgeInsets.only(right: 15.0)),
                                  new DropdownButton<String>(
                                    hint: Text('Tahun'),
                                    value:dropdownTahun,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownTahun = newValue;
                                      });
                                    },
                                    items: Tahun_list //<String>['1', '2', '3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value,style: TextStyle(color: Colors.white),),
                                      );
                                    }).toList(),
                                  ),
                                ]))))
                  ])),
          new Theme(
              data: new ThemeData(
                  brightness: Brightness.dark,
                  fontFamily: 'OpenSans',
                  inputDecorationTheme: new InputDecorationTheme(
                    // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                    labelStyle: new TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400),
                  )),
              isMaterialAppTheme: true,
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new MaterialButton(
                      height: 50.0,
                      minWidth: 150.0,
                      color: Color(0xffE0FFFF),
                      splashColor: Color(0xFF143549),
                      textColor: Color(0xff102343),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0)),
                      child: new Text(
                        'Selanjutnya',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => home.MyHome()),
                        );
                      },
                    ),
                    new Padding(padding: const EdgeInsets.only(bottom: 40.0)),
                  ])),
        ])));
  }
}
