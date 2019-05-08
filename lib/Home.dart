import 'package:flutter/material.dart';
import 'package:pucukan_flutter_app/Job.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart' as parser;

//void main() => runApp(MyApp());

class JobListScreen extends StatefulWidget {
  //FirebaseUser currentUser;

  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  List<Job> jobsList = [];
  //_JobListScreenState(currentUser);
  //extract the link from the inner HTML
  getLink(String html) {
    if (html.length > 10) {
      String link = html.substring(9);
      var i = link.indexOf('" target="');
      link = link.replaceRange(i, link.length, "");
      return link;
    } else
      return "NoURL";
  }

  Future<List<String>> getData() async {
    //initialize a new list
    List<String> myList = [];

    //connect to flutter jobs web site
    http.Response response = await http.get('https://testflutter.000webhostapp.com');

    //parse and extract the data from the web site
    dom.Document document = parser.parse(response.body);
    document.getElementsByTagName('tr').forEach((child) {
      jobsList.add(Job(
        title: child.getElementsByTagName('th').first.text,
        dateAdded: child.getElementsByTagName('th').last.text,
        location: child.getElementsByTagName('th')[2].text,
        company: child.getElementsByTagName('th')[1].text,
        url: 'testetts',//getLink(child.getElementsByTagName("th").first.innerHtml.trim()),
      ));
    });
    // remove the first item which is the title item in the table
    jobsList.removeAt(0);

    print("data loaded");
    //just to wait until the get request completed
    return myList;
  }

  showAbout() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("About Flutter Jobs"),
          children: <Widget>[
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    text: 'This App is just an client of'),
                TextSpan(
                    style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    text: ' flutterjobs.info '),
                TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    text: "which is a is a job board for Flutter jobs "),
                TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                    text: "the app created by raouf rahiche ")
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            )
          ],
          contentPadding:
          EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0, bottom: 5.0),
        );
      },
    );
  }

  buildListView() {
//    return JobListView();
  }

  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData().then((d) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.info), color: Colors.white, onPressed: showAbout)
        ],
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('App Bar'),//JobsAppTitle(),
      ),
      //drawer: CustomDrawer(),
      body: !loading
          ? RefreshIndicator(
        onRefresh: () async {
          jobsList.clear();
          await getData();
          setState(() {});
        },
        child: JobListView(list: jobsList),
      )
          : Center(
        child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
      ),
    );
  }
}
class JobListView extends StatefulWidget {
  const JobListView({
    Key key,
    this.list,
  }) : super(key: key);
  final List<Job> list;

  @override
  JobListViewState createState() {
    return new JobListViewState();
  }
}

class JobListViewState extends State<JobListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.list.isNotEmpty
            ? widget.list.map((item) {
          return Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Stack(
              children: <Widget>[
                Dismissible(
                  key: Key(item.company),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    setState(() {
                      widget.list.removeAt(widget.list.indexOf(item));
                    });
                  },
                  child: ClippedItem(item: item),
                ),
                //CircleCompanyLogo(
                //  company: item.company,
                //),
              ],
            ),
          );
        }).toList()
            : []);
  }
}

class ClippedItem extends StatefulWidget {
  const ClippedItem({
    Key key,
    this.item,
  }) : super(key: key);

  final Job item;

  @override
  ClippedItemState createState() {
    return ClippedItemState();
  }
}

class ClippedItemState extends State<ClippedItem>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation = Tween<Offset>(begin: Offset(200.0, 0.0), end: Offset(0.0, 0.0))
        .animate(curvedAnimation);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: ClipPath(
        clipper: Clipper(),
        child: Card(
          color: Color.fromRGBO(47, 65, 123, 1.0),
          elevation: 5.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          child: InkWell(
            onTap: () {
              print(widget.item.company.trim());
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detail(widget.item),
                ),
              );*/
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, top: 20.0, right: 10.0, bottom: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                            height: 50.0,
                            child: Text(
                              widget.item.title.trim(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        color: Colors.white70,
                      ),
                      Text(
                        widget.item.dateAdded.trim(),
                        style: TextStyle(color: Colors.white70),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        widget.item.location.trim(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.location_city,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    var radius = 28.0;

    path.lineTo(0.0, size.height / 2 + radius);
    path.arcToPoint(
      Offset(0.0, size.height / 2 - radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
