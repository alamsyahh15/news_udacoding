import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/ui_page/RegisterLogin/LoginPage.dart';
import 'package:flutter_news_app/ui_page/add_page/AddPage.dart';
import 'package:flutter_news_app/ui_page/history/HistoryPage.dart';
import 'package:flutter_news_app/ui_page/home/PageHome.dart';
import 'package:flutter_news_app/ui_page/popular/PopularPage.dart';
import 'package:flutter_news_app/ui_page/profile/ProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var listPage = [
    PageHome(),
    PopularPage(),
    ProfilePage(),
    HistoryPage(),
  ];

  final _bottomNavItem = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text("Home"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.star),
      title: Text("Popular"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text("Profile"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bookmark),
      title: Text("History"),
    ),
  ];

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    sharedPreferences.commit();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.subscribeToTopic("InternshipTopic");
    _firebaseMessaging.configure(

      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        print(notification['title']);
      },

      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final notification = message['notification'];
        print(notification['title']);
      },

      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        final notification = message['notification'];
        print(notification['title']);
      },

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 4, right: 4),
                alignment: Alignment.center,
                height: 25,
                width: 25,
                color: Colors.red,
                child: Text(
                  "B",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 4),
                alignment: Alignment.center,
                height: 25,
                width: 25,
                color: Colors.red,
                child: Text(
                  "B",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 4),
                alignment: Alignment.center,
                height: 25,
                width: 25,
                color: Colors.red,
                child: Text(
                  "C",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text(
                "NEWS",
                style: TextStyle(
                    color: Colors.red, letterSpacing: 3, fontSize: 25),
              )
            ],
          ),
        ),
        actions: <Widget>[

          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage()));
            },
            icon: Icon(Icons.note_add,color: Colors.red,size: 30,),
          ),

          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.red,size: 30,),
            onPressed: () {
              signOut();
            },
          )
        ],
      ),
      body: Center(
        child: listPage[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.red,
        items: _bottomNavItem,
        currentIndex: _selectedIndex,
        onTap: onSelected,
      ),
    );
  }
}
