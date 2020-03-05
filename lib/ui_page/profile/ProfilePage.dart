import 'package:flutter/material.dart';
import 'package:flutter_news_app/utils/SessionManager.dart';

import 'UpdateProfile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String myId, myEmail,myName, myPhoto;
  SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionManager.getPreference().then((value){
      setState(() {
        myId = sessionManager.globIduser;
        myEmail = sessionManager.globEmail;
        myName = sessionManager.globName;
        myPhoto = sessionManager.globPhoto;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text("Name: "),
        Text("Email: "),
        Text("Password: "),
        Text("Photo: "),

        RaisedButton(
          child: Text("Update Profile"),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfile(
              id : myId,
              name: myName,
              email: myEmail,
              photo: myPhoto,
            )));
          },

        )
      ],
    );
  }
}
