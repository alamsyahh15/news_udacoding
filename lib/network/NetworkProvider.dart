import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/constant/ConstantFile.dart';
import 'package:flutter_news_app/model/ModelNews.dart';
import 'package:flutter_news_app/model/ModelUser.dart';
import 'package:flutter_news_app/ui_page/DashboardPage.dart';
import 'package:http/http.dart' as http;

abstract class BaseEndpoint{
  void registerUser(String myName, String myEmail, String myPassword, BuildContext context);
  Future<List> loginUser(String myEmail, String myPassword, BuildContext context);
  Future<List> getNews();
  void addNews(String title, String content, String description, File image);
  void sendNotification(String urlImage);
  void updateImage(String idUser, File imageUser);
  void updateProfile(String idUser, String myName, String myEmail, String myPassword);
}


class NetworkProvider extends BaseEndpoint{

  @override
  void registerUser(String myName, String myEmail, String myPassword, BuildContext context) async{
    // TODO: implement registerUser
    final response = await http.post(ConstantFile().baseUrl+"registerUser",body: {
      'name': myName,
      'email': myEmail,
      'password': myPassword
    });
    var listData = jsonDecode(response.body);

    if(listData['status'] == 200){
      print(listData['message']);
      AwesomeDialog(context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          tittle: 'Information Register',
          desc: listData['message'],
          btnOkText: "Go to Login",
          btnOkOnPress: () {}).show();
    }else {
      print(listData['message']);
      AwesomeDialog(context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          tittle: 'Information Register',
          desc: listData['message'],
          btnOkOnPress: () {}).show();
    }
  }

  @override
  Future<List> loginUser(String myEmail, String myPassword, BuildContext context) async{
    // TODO: implement loginUser
    final response = await http.post(ConstantFile().baseUrl +"loginUser", body: {
      'email': myEmail,
      'password' : myPassword
    });

    //Cara Manual
    var listData1 = jsonDecode(response.body);
    List listUser = listData1['user'];
    print("Tag Saya ${listUser[0]}");

    ModelUser listData = modelUserFromJson(response.body);
    if(listData.status == 200){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
      return listData.user;
    } else {
      return null;
    }
  }

  @override
  Future<List> getNews() async {
    // TODO: implement getNews
    final response = await http.get(ConstantFile().baseUrl +"getNews");
    ModelNews listData = modelNewsFromJson(response.body);

    return listData.article;
  }

  @override
  void addNews(String title, String content, String description, File image) async{
    // TODO: implement addNews

    var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();

    var request = http.MultipartRequest('POST',
        Uri.parse(ConstantFile().baseUrl + "addNews"));
    var multipart = http.MultipartFile('image',stream,length,filename: image.path);

    request.files.add(multipart);
    request.fields['title'] = title;
    request.fields['content'] = content;
    request.fields['description'] = description;
    var response = await request.send();
    if(response.statusCode == 200){
      print("Image Uploaded");
    } else {
      print("Image Failed Uploaded");
    }
  }

  @override
  void sendNotification(String urlImage) async{
    // TODO: implement sendNotification
    final body = jsonEncode({
      "to": "/topics/InternshipTopic",
      "topic" : "InternshipTopic",
      "notification" : {
        "body" : "test",
        "title" : "Heyy.. Ada berita baru ayo check..",
        "sound": "default",
        "image": urlImage,
      },
    });
    await http.post("https://fcm.googleapis.com/fcm/send", headers: {
      HttpHeaders.authorizationHeader: ConstantFile().keyServer,
      HttpHeaders.contentTypeHeader: "application/json"
    }, body: body);
    
  }

  @override
  void updateImage(String idUser, File imageUser) async{
    // TODO: implement updateImage
    var stream = http.ByteStream(DelegatingStream.typed(imageUser.openRead()));
    var length = await imageUser.length();

    var request = http.MultipartRequest('POST',
        Uri.parse(ConstantFile().baseUrl + "updateImage"));
    var multipart = http.MultipartFile('image',stream,length,filename: imageUser.path);

    request.files.add(multipart);
    request.fields['iduser'] = idUser;
    var response = await request.send();
    if(response.statusCode == 200){
      print("Image Uploaded");
    } else {
      print("Image Failed Uploaded");
    }
  }

  @override
  void updateProfile(String idUser, String myName, String myEmail, String myPassword) async{
    // TODO: implement updateProfile
    final response = await http.post(ConstantFile().baseUrl + "updateProfile", body: {
      'iduser': idUser,
      'name': myName,
      'email': myEmail,
      'password': myPassword
    });
    var listData = jsonDecode(response.body);
    if(listData['status'] == 200){
      print(listData['message']);
    } else {
      print(listData['message']);
    }
  }


}