import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/ModelUser.dart';
import 'package:flutter_news_app/network/NetworkProvider.dart';
import 'package:flutter_news_app/ui_page/DashboardPage.dart';
import 'package:flutter_news_app/ui_page/RegisterLogin/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BaseEndpoint network = NetworkProvider();
  TextEditingController etPassword = new TextEditingController();
  TextEditingController etEmail = new TextEditingController();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  var _token;
  var status = false;
  var globIduser, globName, globEmail, globPhoto;
  var globStatus;

  void onValidate() async {
    if (etEmail.text.isEmpty || etPassword.text.isEmpty) {
      print("Gagal");
    } else {
      List listData = await network.loginUser(
          etEmail.text.toString(), etPassword.text.toString(), context);
      User data = listData[0];
      print("myData : ${data.idUser} ${data.fullnameUser} ${data.emailUser}");
      setState(() {
        status = true;
        _firebaseMessaging.getToken().then((token){
          print("Mytoken : $token");
          _token = token;
        });
        savePreference(status, data.idUser, data.fullnameUser, data.emailUser,
            data.photoUser);
      });
    }
  }

  void savePreference(bool status, String idUser, String fullnameUser,
      String emailUser, String photoUser) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("myStatus", status);
    sharedPreferences.setString("myIduser", idUser);
    sharedPreferences.setString("myName", fullnameUser);
    sharedPreferences.setString("myEmail", emailUser);
    sharedPreferences.setString("myPhoto", photoUser);
    sharedPreferences.commit();
  }

  void getPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      globStatus = sharedPreferences.getBool("myStatus");
      globIduser = sharedPreferences.getString("myIduser");
      globName = sharedPreferences.getString("myName");
      globEmail = sharedPreferences.getString("myEmail");
      globPhoto = sharedPreferences.getString("myPhoto");
      if(globStatus == true){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
      } else {
        print("Status masih gantung");
      }
    });
    print("Global Status = $globStatus");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(32),
            padding: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Login",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Welcome back,\nplease logi\nto your account",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: etEmail,
                  decoration: InputDecoration(hintText: "Email Address"),
                ),
                TextFormField(
                  controller: etPassword,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Password"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16, bottom: 16),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      onValidate();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, letterSpacing: 3),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      "Already have an Account? Sign in",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
