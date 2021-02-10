import 'package:flutter/material.dart';

class EditProfileView extends StatefulWidget {

  EditProfileView(
      {Key key,})
      : super(key: key);

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(238,238,238,1)),
            borderRadius: BorderRadius.circular(4),

        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text("Dates",
                style: TextStyle(
                    color: Color.fromRGBO(4,41,68,1),
                    fontSize: 14,
                    fontFamily: "Open Sans",
                    fontWeight: FontWeight.w700),),
              SizedBox(height: 10,),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(238,238,238,1)
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Licence: ",
                    style: TextStyle(
                        color: Color.fromRGBO(4,41,68,1),
                        fontSize: 12,
                        fontFamily: "Open Sans",
                        fontWeight: FontWeight.w700),),
                  Text("1256578394940",
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
                      Text("Birthday: ",
                        style: TextStyle(
                            color: Color.fromRGBO(4,41,68,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),),
                      Text("05/11/2020",
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
                      Text("Gender: ",
                        style: TextStyle(
                            color: Color.fromRGBO(4,41,68,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),),
                      Text("05/11/2020",
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
                      Text("Signature: ",
                        style: TextStyle(
                            color: Color.fromRGBO(4,41,68,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),),
                      Text("John Hopkins",
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
                      Text("Phone: ",
                        style: TextStyle(
                            color: Color.fromRGBO(4,41,68,1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),),
                      Text("342354345345",
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
      ),
    );
  }
}
