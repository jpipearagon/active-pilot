import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MessageView extends StatelessWidget {

  final Function onTap;
  final String title;
  final String message;
  MessageView({Key? key, required this.title, required this.message, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
              'assets/gifs/success.json',
              width: 80,
              height: 80,
              repeat: false
          ),
          SizedBox(height: 20,),
          Text(
            title,
            style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 30,
                fontWeight: FontWeight.w700 ,
                color: Color.fromRGBO(46,56,77,1)
            ),
          ),
          SizedBox(height: 20,),
          Text(
            message,
            style: TextStyle(
                fontFamily: "Open Sans",
                fontSize: 14,
                fontWeight: FontWeight.w400 ,
                color: Color.fromRGBO(0,0,0,1)
            ),
          ),
          SizedBox(height: 40,),
          Center(
            child: ButtonTheme(
              minWidth: 154.0,
              height: 45.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(223, 173, 78, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)
                  ),
                ),
                child: Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  onTap();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
