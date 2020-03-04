import 'package:flutter/material.dart';

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
        return  Container(
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          height: MediaQuery.of(context).size.height / 4.5,
          color: Colors.green,
          width: MediaQuery.of(context).size.width,
        );
      },
    );
  }
}
