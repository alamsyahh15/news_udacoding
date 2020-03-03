import 'package:flutter/material.dart';
import 'package:flutter_news_app/network/NetworkProvider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey <FormState> _key = new GlobalKey();
  String myName, myEmail, myPassword;
  BaseEndpoint network = NetworkProvider();
  var _obSecure = true;
  void onHidePassword(){
    if(_obSecure == true){
      setState(() {
        _obSecure = false;
      });
    } else {
      setState(() {
        _obSecure = true;
      });
    }
  }

  void sendToDatabase(){
    if(_key.currentState.validate()){
      _key.currentState.save();
      if(myName.isEmpty || myEmail.isEmpty || myPassword.isEmpty){
        print("Form Tidak Boleh Kosong");
      } else {
        network.registerUser(myName, myEmail, myPassword,context);
      }
    } else {
      print("Not Validate");
    }
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
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Register",
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Lets get\nyou on board",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Full Name"),
                    onSaved: (value){
                      myName = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Email Address"),
                    onSaved: (value){
                      myEmail = value;
                    },
                  ),
                  TextFormField(
                    obscureText: _obSecure,
                    onSaved: (value){
                      myPassword = value;
                    },
                    decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                           _obSecure ? Icons.visibility : Icons.visibility_off,
                            size: 35,
                          ),
                          onPressed: () {
                           onHidePassword();
                          },
                        )),
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
                        sendToDatabase();
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white, letterSpacing: 3),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
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
          ),
        ],
      ),
    );
  }
}
