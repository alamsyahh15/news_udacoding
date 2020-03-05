import 'package:flutter/material.dart';
import 'package:flutter_news_app/constant/ConstantFile.dart';
import 'package:flutter_news_app/model/ModelNews.dart';

class ItemListVertical extends StatelessWidget {
  List list;
  ItemListVertical({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        Article data = list[index];
        return   Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,bottom: 8),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: Container(
                        height: 120,
                        width: 150,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(ConstantFile().imageUrl + data.imageNews, fit: BoxFit.fill,)),
                      ),
                    ),

                    Flexible(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data.titleNews,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            Text(
                              data.contentNews,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              softWrap: true,
                              maxLines: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.access_time),
                                    SizedBox(width: 4,),
                                    Text("4 hr"),
                                    SizedBox(width: 4,),
                                    Text("| US & Canada",
                                      style: TextStyle(color: Colors.red),)
                                  ],
                                ),
                                Icon(Icons.bookmark, color: Colors.red,),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Divider(
                color: Colors.pink,
                height: 1,
                thickness: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
