import 'package:flutter/material.dart';
import 'package:pucukan_flutter_app/Sign up.dart' as Sign_up;
import 'package:pucukan_flutter_app/Profile_edit.dart' as edit;
import 'package:pucukan_flutter_app/util/global.dart' as global;
import 'package:flutter/cupertino.dart';
import 'dart:async';

List<String> fotoriwayat = ['assets/barista.png', 'assets/gurutk.png', 'assets/penyiar.png', 'assets/guruprivat.png'];
List<String> listpekerjaan = ['Barista Tugu', 'Guru TK Bambini', 'Penyiar Radio Q','Guru Privat Matematika'];


void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  Profile_tab createState() => new Profile_tab();
}

//State is information of the application that can change over time or when some actions are taken.
class Profile_tab extends State<MyApp> {
  //String get _nama => edit.Profile_edit._nama;

  void _incrementTab(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    //String _nama,_email,_sekolah,_tglLahir,_domisili;
    return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: const Color(0xff102343),
                expandedHeight: 300.0,
                floating: false,
                actions: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.settings, size: 32,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => edit.MyApp()),
                      );
                    },
                  ),
                ],
                leading: new Container(),
                pinned: true,
                snap: false,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Albertus Pradana",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,fontFamily: 'OpenSans', fontWeight: FontWeight.bold,
                        )),
                    background: Image.asset(
                      'assets/profil.png',
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body:
          new Container(
        child: new Padding(padding: const EdgeInsets.all(12.0), child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 15),
            child:new Card(
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text('Mahasiswa TI UGM', style: TextStyle(fontSize: 18)),
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
                  new Text('Tentang', style: TextStyle(fontSize: 20,  fontWeight: FontWeight.bold)),
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
                  new Text('   19 Maret 1999'),
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
                  new Text('   SMA N 4 Denpasar'),
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
                  new Text('   Pogung Dalangan'),
                ],
              ),
            ),
          ),new Padding(
            padding: const EdgeInsets.only(left: 5,top: 15),
            child:new Card(
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text('Riwayat Pekerjaan', style: TextStyle(fontSize: 22,  fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),new Expanded(
            child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this would produce 2 rows.
              crossAxisCount: 2,
              // Generate 100 Widgets that display their index in the List
              children: new List<Widget>.generate(4, (index) {
                return new GridTile(
                    footer: new Container(
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.bottomLeft,
                      child: new Text(listpekerjaan[index], style: TextStyle(fontFamily: 'OpenSans'),
                      ),
                    ),
                    child: new Card(
                        color: Colors.white,
                        child: new Center(
                        child: new Image.asset(fotoriwayat[index]),
    ))
                );}),
            ),
          ),
            /*
              new GridView.builder(
                  itemCount: 6,
                  gridDelegate:
                  new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      child: new Card(
                        elevation: 5.0,
                        child: new Container(
                          alignment: Alignment.center,
                          child: new Text('Item $index'),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => new CupertinoAlertDialog(
                            title: new Column(
                              children: <Widget>[
                                new Text("GridView"),
                                new Icon(
                                  Icons.favorite,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            content: new Text("Selected Item $index"),
                            actions: <Widget>[
                              new FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: new Text("OK"))
                            ],
                          ),
                        );
                      },
                    );
                  })*/

          ]
        )),
          )


    ));
  }
}
