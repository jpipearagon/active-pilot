import 'package:aircraft/src/bloc/user_bloc.dart';
import 'package:aircraft/src/constants/application_colors.dart';
import 'package:aircraft/src/models/Endorsment.dart';
import 'package:aircraft/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EndorsmentView extends StatefulWidget {
  EndorsmentView({
    Key key,
  }) : super(key: key);

  @override
  _EndorsmentViewState createState() => _EndorsmentViewState();
}

class _EndorsmentViewState extends State<EndorsmentView> {
  final _userBloc = UserBloc();

  @override
  void initState() {
    super.initState();
    _userBloc.loadEndorsments();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder<List<Endorsment>>(
        stream: _userBloc.endorsmentStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Endorsment endorsment = snapshot.data[index];
                    return _buildEndorsmentItem(endorsment);
                  },
                )
              : Container();
        },
      ),
    );
  }

  Widget _buildEndorsmentItem(Endorsment endorsment) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16.0,
        8.0,
        16.0,
        8.0,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 21),
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(238, 238, 238, 1)),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            Text(
              endorsment.title,
              style: GoogleFonts.openSans(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: ApplicationColors().primaryColor // semi-bold
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                endorsment.description,
                style: GoogleFonts.openSans(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black // semi-bold
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Row(
                children: [
                  Text(
                    'Issued: ',
                    style: GoogleFonts.openSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: ApplicationColors().primaryColor // semi-bold
                        ),
                  ),
                  Text(
                    DateUtil.getDateFormattedFromString(endorsment.issuedDate,
                        DateUtil.yyyyMmddTHHmmssz, DateUtil.ddMMyyyy),
                    style: GoogleFonts.openSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey // semi-bold
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Text(
                      'Expires: ',
                      style: GoogleFonts.openSans(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: ApplicationColors().primaryColor // semi-bold
                          ),
                    ),
                  ),
                  Text(
                    DateUtil.getDateFormattedFromString(
                        endorsment.expirationDate,
                        DateUtil.yyyyMmddTHHmmssz,
                        DateUtil.ddMMyyyy),
                    style: GoogleFonts.openSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey // semi-bold
                        ),
                  ),
                ],
              ),
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Issued: ",
                      style: TextStyle(
                          color: Color.fromRGBO(4, 41, 68, 1),
                          fontSize: 12,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      endorsmentObject.issued,
                      style: TextStyle(
                          color: Color.fromRGBO(106, 107, 108, 1),
                          fontSize: 12,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Expires: ",
                      style: TextStyle(
                          color: Color.fromRGBO(4, 41, 68, 1),
                          fontSize: 12,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      endorsmentObject.expires,
                      style: TextStyle(
                          color: Color.fromRGBO(106, 107, 108, 1),
                          fontSize: 12,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w400),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Signature: ",
                      style: TextStyle(
                          color: Color.fromRGBO(4, 41, 68, 1),
                          fontSize: 12,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      endorsmentObject.signature,
                      style: TextStyle(
                          color: Color.fromRGBO(106, 107, 108, 1),
                          fontSize: 12,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Total: ",
                      style: TextStyle(
                          color: Color.fromRGBO(4, 41, 68, 1),
                          fontSize: 12,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      endorsmentObject.total,
                      style: TextStyle(
                          color: Color.fromRGBO(106, 107, 108, 1),
                          fontSize: 12,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w400),
                    )
                  ],
                )
              ],
            )*/
          ],
        ),
      ),
    );
  }
}
/*
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

  Endorsment(this.tag, this.issued, this.expires, this.signature, this.total);
}*/
