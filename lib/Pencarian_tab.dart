import 'package:flutter/material.dart';
import 'package:pucukan_flutter_app/Sign up.dart' as Sign_up;
import 'package:dio/dio.dart';
import 'package:pucukan_flutter_app/Home_Page.dart' as first;
import 'package:pucukan_flutter_app/Profile_tab.dart' as profil;
import 'dart:async';

List<String> listPekerjaan = ['Test', 'Test2', 'Test3', 'Test4'];

void main() => runApp(new MaterialApp(
      home: new SearchListExample(),
    ));

class SearchListExample extends StatefulWidget {
  @override
  Pencarian_tab createState() => new Pencarian_tab();
}

class Pencarian_tab extends State<SearchListExample> {
  Widget appBarTitle = new Image.asset('assets/logoHireMe.png');
  Icon icon = new Icon(
    Icons.search,
    color: Color(0xff102343),
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _list;
  bool _isSearching;
  String _searchText = "";
  List searchresult = new List();

  _SearchListExampleState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    values();
  }

  void values() {
    _list = List();
    _list.add("Desain Grafis");
    _list.add("Barista");
    _list.add("Guru Privat Matematika SD");
    _list.add("Guru Privat Musik [Gitar]");
    _list.add("Penyiar Radio");
    _list.add("Panitia Event Organizer");
    _list.add("Editor Video");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //key: globalKey,
        appBar: buildAppBar(context),
        body: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Flexible(
                  child: searchresult.length != 0 || _controller.text.isNotEmpty
                      ? new ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchresult.length,
                          itemBuilder: (BuildContext context, int index) {
                            String listData = searchresult[index];
                            return new ListTile(
                              title: new Text(listData.toString()),
                            );
                          },
                        )
                      : new ListView.builder(
                          shrinkWrap: true,
                          itemCount: _list.length,
                          itemBuilder: (BuildContext context, int index) {
                            String listData = _list[index];
                            return new ListTile(
                              title: new Text(listData.toString(),style: TextStyle(fontFamily: 'OpenSans', fontSize: 16),),
                            );
                          },
                        ))
            ],
          ),
        ));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: true,leading: new Container(), backgroundColor: const Color(0xfff4ffff),title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            if (this.icon.icon == Icons.search) {
              this.icon = new Icon(
                Icons.close,
                color: Color(0xff102343),
              );
              this.appBarTitle = new TextField(
                controller: _controller,
                style: new TextStyle(
                  color: Color(0xff102343),
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Color(0xff102343)),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Color(0xff102343))),
                onChanged: searchOperation,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);


  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Color(0xff102343),
      );
      this.appBarTitle = new Image.asset('assets/logoHireMe.png');
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }
}
