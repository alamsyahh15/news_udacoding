import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/network/NetworkProvider.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  BaseEndpoint network = NetworkProvider();
  TextEditingController etTitle = TextEditingController();
  TextEditingController etContent = TextEditingController();
  TextEditingController etDescription = TextEditingController();
  File _image;
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text("Please choose media to select"),
            content: Container(
              height: MediaQuery.of(context).size.height / 6.5,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        Text("From Gallery")
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        Text("From Camera")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future getImage(ImageSource media) async {
    var img = await ImagePicker.pickImage(source: media);
    if (img != null) {
      setState(() {
        _image = img;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Make a new post",
          style: TextStyle(color: Colors.red),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () async{
              network.addNews(
                  etTitle.text.toString(),
                  etContent.text.toString(),
                  etDescription.text.toString(),
                  _image
              );
              await network.getNews();
              Navigator.pop(context);
              },
            child: Text("Posting"),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Title
              TextFormField(
                controller: etTitle,
                minLines: 2,
                maxLines: 5,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    hintText: "Input Your Title"),
              ),

              //Content
              TextFormField(
                controller: etContent,
                minLines: 2,
                maxLines: 5,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    hintText: "Input Your Content"),
              ),

              //Description
              TextFormField(
                controller: etDescription,
                minLines: 3,
                maxLines: 15,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    hintText: "What's on your mind?"),
              ),

              Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: _image == null
                      ? Center()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _image,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 5,
                          ))),

              //Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.red,
                  child: Text(
                    "Select Image",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    myAlert();
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
