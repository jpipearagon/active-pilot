import 'package:flutter/material.dart';

class EndorsmentView extends StatefulWidget {

  EndorsmentView(
      {Key key,})
      : super(key: key);

  @override
  _EndorsmentViewState createState() => _EndorsmentViewState();
}

class _EndorsmentViewState extends State<EndorsmentView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: _endorsment(context),
      ),
    );
  }

  List<Widget> _endorsment(BuildContext context) {
    return endorsment.map((endorsmentObject) {
      return ListTile(
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 21),
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(238,238,238,1)),
              borderRadius: BorderRadius.circular(4)
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Issued: ",
                        style: TextStyle(
                            color: Color.fromRGBO(4,41,68,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),),
                      Text(endorsmentObject.issued,
                        style: TextStyle(
                            color: Color.fromRGBO(106,107,108,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400),),
                    ],
                  ),
                  SizedBox(width: 20,),
                  Row(
                    children: [
                      Text("Expires: ",
                        style: TextStyle(
                            color: Color.fromRGBO(4,41,68,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),),
                      Text(endorsmentObject.expires,
                        style: TextStyle(
                            color: Color.fromRGBO(106,107,108,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400),)
                    ],
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Signature: ",
                        style: TextStyle(
                            color: Color.fromRGBO(4,41,68,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),),
                      Text(endorsmentObject.signature,
                        style: TextStyle(
                            color: Color.fromRGBO(106,107,108,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400),),
                    ],
                  ),
                  SizedBox(width: 20,),
                  Row(
                    children: [
                      Text("Total: ",
                        style: TextStyle(
                            color: Color.fromRGBO(4,41,68,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),),
                      Text(endorsmentObject.total,
                        style: TextStyle(
                            color: Color.fromRGBO(106,107,108,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400),)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        onTap: () {
          //openLog(log);
        },
      );
    }).toList();
  }
}

final List<Endorsment> endorsment = [
  Endorsment(1, '05/11/2020', "05/11/2021", " John Hopkins", "5.2 H"),
  Endorsment(2, '05/11/2020', "05/11/2021", " John Hopkins", "5.2 H"),
  Endorsment(3, '05/11/2020', "05/11/2021", " John Hopkins", "5.2 H"),
  Endorsment(4, '05/11/2020', "05/11/2021", " John Hopkins", "5.2 H"),
  Endorsment(5, '05/11/2020', "05/11/2021", " John Hopkins", "5.2 H"),
  Endorsment(6, '05/11/2020', "05/11/2021", " John Hopkins", "5.2 H"),
  Endorsment(7, '05/11/2020', "05/11/2021", " John Hopkins", "5.2 H"),
  Endorsment(8, '05/11/2020', "05/11/2021", " John Hopkins", "5.2 H"),
];

class Endorsment {
  int tag;
  String issued;
  String expires;
  String signature;
  String total;


  Endorsment(this.tag,
      this.issued,
      this.expires,
      this.signature,
      this.total);
}

