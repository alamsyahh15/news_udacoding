import 'package:flutter/material.dart';
import 'package:flutter_news_app/network/NetworkProvider.dart';
import 'package:flutter_news_app/ui_page/home/ItemListVertical.dart';

import 'ItemListHorizontal.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  BaseEndpoint network = NetworkProvider();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
          child: Text("Stories", style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),),
        ),


        Container(
          height: MediaQuery.of(context).size.height / 4,
          child: FutureBuilder(
            future: network.getNews(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasError) print( snapshot.error);
              return snapshot.hasData
                  ? ItemListHorizontal(list: snapshot.data)
                  : Center(child: CircularProgressIndicator(),);
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16, top: 16),
          child: Text("Headlines", style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),),
        ),

        FutureBuilder(
          future: network.getNews(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ItemListVertical(list:  snapshot.data,)
                : Center(child: CircularProgressIndicator(),);
          },
        )
      ],
    );
  }
}
