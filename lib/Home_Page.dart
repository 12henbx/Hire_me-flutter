import 'package:flutter/material.dart';
import 'package:pucukan_flutter_app/Home_tab.dart' as home_tab;
import 'package:pucukan_flutter_app/Pencarian_tab.dart' as pencarian_tab;
import 'package:pucukan_flutter_app/Profile_tab.dart' as profil_tab;
import 'package:pucukan_flutter_app/Sign up.dart' as Sign_up;
import 'dart:async';


//List<String> listPekerjaan = ['assets/barista.png', 'assets/designer.png', 'assets/teacher.png'];

void main() {
  runApp(new MaterialApp(
    // Title
      title: "",
      // Home
      home: new MyHome()));
}

class MyHome extends StatefulWidget {
  @override
  _State createState() => new _State();
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<MyHome> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //appBar: buildAppBar(context),
      // Set the TabBar view as the body of the Scaffold
      body: new TabBarView(
        // Add tabs as widgets
        children: <Widget>[new home_tab.Home_tab(), new pencarian_tab.SearchListExample(), new profil_tab.MyApp()],
        // set the controller
        controller: controller,
      ),
      // Set the bottom navigation bar
      bottomNavigationBar: new Material(
        // set the color of the bottom navigation bar
        color: Color(0xff102343),
        // set the tab bar as the child of bottom navigation bar
        child: new TabBar(
          tabs: <Tab>[
            new Tab(
              // set icon to the tab
              icon: new Icon(Icons.home),
            ),
            new Tab(
              icon: new Icon(Icons.search),
            ),
            new Tab(
              icon: new Icon(Icons.account_circle),
            ),
          ],
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: true,leading: new Container(), backgroundColor: const Color(0xff102343),title: Text('Hire Me!', style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold)));
  }
}
