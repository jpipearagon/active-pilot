import 'package:flutter/material.dart';

class LogBookView extends StatefulWidget {

  LogBookView(
      {Key key,})
      : super(key: key);

  @override
  _LogBookViewState createState() => _LogBookViewState();
}

class _LogBookViewState extends State<LogBookView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: _logBooks(context),
      ),
    );
  }

  List<Widget> _logBooks(BuildContext context) {
    return logbooks.map((log) {
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
                children: [
                  Text("Aircraft: ",
                    style: TextStyle(
                      color: Color.fromRGBO(4,41,68,1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700),),
                  Text(log.aircraft,
                    style: TextStyle(
                        color: Color.fromRGBO(106,107,108,1),
                        fontSize: 12,
                        fontFamily: "Open Sans",
                        fontWeight: FontWeight.w400),)
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Date: ",
                        style: TextStyle(
                            color: Color.fromRGBO(4,41,68,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),),
                      Text(log.date,
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
                      Text(log.total,
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
          openLog(log);
        },
      );
    }).toList();
  }

  void openLog(LogBook logBook) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Aircraft: ",
                        style: TextStyle(
                            color: Color.fromRGBO(4,41,68,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),),
                      Text(logBook.aircraft,
                        style: TextStyle(
                            color: Color.fromRGBO(106,107,108,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400),)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Date: ",
                            style: TextStyle(
                                color: Color.fromRGBO(4,41,68,1),
                                fontSize: 12,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w700),),
                          Text(logBook.date,
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
                          Text(logBook.total,
                            style: TextStyle(
                                color: Color.fromRGBO(106,107,108,1),
                                fontSize: 12,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w400),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("From: ",
                            style: TextStyle(
                                color: Color.fromRGBO(4,41,68,1),
                                fontSize: 12,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w700),),
                          Text(logBook.from,
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
                          Text("To: ",
                            style: TextStyle(
                                color: Color.fromRGBO(4,41,68,1),
                                fontSize: 12,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w700),),
                          Text(logBook.to,
                            style: TextStyle(
                                color: Color.fromRGBO(106,107,108,1),
                                fontSize: 12,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w400),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("PIC: ",
                            style: TextStyle(
                                color: Color.fromRGBO(4,41,68,1),
                                fontSize: 12,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w700),),
                          Text(logBook.pic,
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
                          Text("Distance: ",
                            style: TextStyle(
                                color: Color.fromRGBO(4,41,68,1),
                                fontSize: 12,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w700),),
                          Text(logBook.distance,
                            style: TextStyle(
                                color: Color.fromRGBO(106,107,108,1),
                                fontSize: 12,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w400),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Nigth: ",
                            style: TextStyle(
                                color: Color.fromRGBO(4,41,68,1),
                                fontSize: 12,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w700),),
                          Text(logBook.nigth,
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
                          Text("Crosscountry: ",
                            style: TextStyle(
                                color: Color.fromRGBO(4,41,68,1),
                                fontSize: 12,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w700),),
                          Text(logBook.crosscountry,
                            style: TextStyle(
                                color: Color.fromRGBO(106,107,108,1),
                                fontSize: 12,
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w400),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          })
                    ],
                  )
                ],
              ),
            ),

          );
        });
  }
}

final List<LogBook> logbooks = [
  LogBook(1, 'N64267 Cessna 172M', "05/12/2020", "5.2 H", "KLUK", "KBLKL", "2.1 H", "197.2", "0.0 H", "2.1 H"),
  LogBook(2, 'N64267 Cessna 172M', "05/12/2020", "5.2 H", "KLUK", "KBLKL", "2.1 H", "197.2", "0.0 H", "2.1 H"),
  LogBook(3, 'N64267 Cessna 172M', "05/12/2020", "5.2 H", "KLUK", "KBLKL", "2.1 H", "197.2", "0.0 H", "2.1 H"),
  LogBook(4, 'N64267 Cessna 172M', "05/12/2020", "5.2 H", "KLUK", "KBLKL", "2.1 H", "197.2", "0.0 H", "2.1 H"),
  LogBook(5, 'N64267 Cessna 172M', "05/12/2020", "5.2 H", "KLUK", "KBLKL", "2.1 H", "197.2", "0.0 H", "2.1 H"),
  LogBook(6, 'N64267 Cessna 172M', "05/12/2020", "5.2 H", "KLUK", "KBLKL", "2.1 H", "197.2", "0.0 H", "2.1 H"),
  LogBook(7, 'N64267 Cessna 172M', "05/12/2020", "5.2 H", "KLUK", "KBLKL", "2.1 H", "197.2", "0.0 H", "2.1 H"),
  LogBook(8, 'N64267 Cessna 172M', "05/12/2020", "5.2 H", "KLUK", "KBLKL", "2.1 H", "197.2", "0.0 H", "2.1 H"),
];

class LogBook {
  int tag;
  String aircraft;
  String date;
  String total;
  String from;
  String to;
  String pic;
  String distance;
  String nigth;
  String crosscountry;

  LogBook(this.tag,
      this.aircraft,
      this.date,
      this.total,
      this.from,
      this.to,
      this.pic,
      this.distance,
      this.nigth,
      this.crosscountry);
}
