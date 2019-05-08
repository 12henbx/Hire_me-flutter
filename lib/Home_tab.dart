import 'package:flutter/material.dart';
import 'package:pucukan_flutter_app/util/Detail.dart' as desc;

List<String> listPekerjaan = [
  'assets/barista.png', 'assets/designer.png', 'assets/teacher.png'];

class Home_tab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [const Color(0xFFf4ffff), const Color(0xffe0ffff)],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp
          ),
        ), child: new Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.transparent,
      // Create a Listview and load the data when available
      body: new ListView.builder(
        itemCount: listPekerjaan.length == null ? 0 : listPekerjaan.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container
          (
              child: new GestureDetector(
              onTap: ()
          {
            /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Sign_up.MyApp()),
                  );*/
          },
          child: new Padding(
          padding: const EdgeInsets.all(15.0),
          child:new Card(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 8.0,
          color: Color(0xffE0FFFF),
          child: InkWell(
          onTap: () {
          //print(widget.item.company.trim());
          Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => desc.MyApp(),
                        ),
              );
          },child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          new ClipRRect(
          borderRadius: new BorderRadius.circular(8.0),
          child: Image.asset(listPekerjaan[index])
          ),
          const ListTile(
          title: Text('Courve'),
          subtitle: Text(
          'Pogung Baru'),
          ),
          ],
          ),
          )
          ))
          ,
          ));
        },
      ),
    ));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: true,
        leading: new Container(),
        backgroundColor: Color(0xfff4ffff),
        title: Image.asset(
            'assets/logoHireMe.png')); //Text('Hire Me!', style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold)));
  }

}