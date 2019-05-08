import 'package:flutter/material.dart';
import 'package:pucukan_flutter_app/Home_Page.dart' as homepage;
import 'package:pucukan_flutter_app/util/global.dart' as global;
import 'package:pucukan_flutter_app/Sign up.dart' as Sign_up;
import 'dart:async';
//String _nama,_email,_sekolah,_tglLahir,_domisili;
void main() {
  //String _nama,_email,_sekolah,_tglLahir,_domisili;
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  Profile_edit createState() => new Profile_edit();
}

//State is information of the application that can change over time or when some actions are taken.
class Profile_edit extends State<MyApp> {
  String _nama,_email,_sekolah,_tglLahir,_domisili;

  @override
  Widget build(BuildContext context) {
    //String _nama,_email,_sekolah,_tglLahir,_domisili;
    // TODO: implement build
    return new Container(
        decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [const Color(0xFF143549), const Color(0xff102343)],
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
    stops: [0.0,1.0],
    tileMode: TileMode.clamp
    ),
    ),child:Scaffold(
    backgroundColor: Colors.transparent,
    resizeToAvoidBottomPadding: false,
      appBar: AppBar(centerTitle: true,leading: new Container(), backgroundColor: const Color(0xff102343),title: Text('Edit Profil',style: TextStyle(fontFamily: 'OpenSans', fontSize: 24)),),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
        padding: const EdgeInsets.all(30.0),
        child: new Form(
          autovalidate: true,
          child:
          new Padding(padding: const EdgeInsets.all(12.0),
              child:
          new Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
          new Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 15),
            child:new Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ClipRRect(
                      borderRadius: new BorderRadius.circular(100.0),
                      child: Image.asset('assets/profil.png',height: 100,)
                  ),
                ],
              ),
            ),
          ),new TextFormField(
            decoration: new InputDecoration(
              labelText: "Nama :",
            ),
            keyboardType: TextInputType.text,
            //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
            onSaved: (value) => _nama = value,
          ),
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
              labelText: "Pendidikan terakhir :",
            ),
            keyboardType: TextInputType.emailAddress,
            //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
            onSaved: (value) => _sekolah = value,
          ),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Tanggal lahir :",
            ),
            keyboardType: TextInputType.emailAddress,
            //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
            onSaved: (value) => _tglLahir = value,
          ),
          new TextFormField(
            decoration: new InputDecoration(
              labelText: "Domisili :",
            ),
            keyboardType: TextInputType.emailAddress,
            //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
            onSaved: (value) => _domisili = value,
          ),
          new MaterialButton(
            height: 50.0,
            minWidth: 150.0,
            color: Color(0xffE0FFFF),
            splashColor: Color(0xFF143549),
            textColor: Color(0xff102343),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0)),
            child: new Text(
              'Simpan perubahan',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => homepage.MyHome()),
              );
            },
          ),

                /*new Card(
              color: Color(0xff102343),
              child: Row(
                //mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Icon(Icons.assignment),
                  new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Nama :",
                    ),
                    keyboardType: TextInputType.text,
                    //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                    onSaved: (value) => _nama = value,
                  ),
                ],
              ),
            ),
          new Padding(
            padding: const EdgeInsets.only(left: 5),
            child:new Card(
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Icon(Icons.alternate_email),
                  new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Email :",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                    onSaved: (value) => _email = value,
                  ),
                ],
              ),
            ),
          ),new Padding(
            padding: const EdgeInsets.only(left: 5),
            child:new Card(
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Icon(Icons.school),
                  new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Pendidikan terakhir :",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                    onSaved: (value) => _sekolah = value,
                  ),
                ],
              ),
            ),
          ),new Padding(
            padding: const EdgeInsets.only(left: 5),
            child:new Card(
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Icon(Icons.calendar_today),
                  new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Tanggal lahir :",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                    onSaved: (value) => _tglLahir = value,
                  ),
                ],
              ),
            ),
          ),new Padding(
            padding: const EdgeInsets.only(left: 5),
            child:new Card(
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Icon(Icons.location_on),
                  new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Domisili :",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    //validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                    onSaved: (value) => _domisili = value,
                  ),
                ],
              ),
            ),
          ),*/]

          )
      )
    ))]
    ))])));
  }

}