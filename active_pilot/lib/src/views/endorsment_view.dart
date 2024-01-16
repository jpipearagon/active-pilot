import 'package:aircraft/src/bloc/user_bloc.dart';
import 'package:aircraft/src/constants/application_colors.dart';
import 'package:aircraft/src/models/Endorsment.dart';
import 'package:aircraft/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EndorsmentView extends StatefulWidget {
  EndorsmentView({
    Key? key,
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

          if(snapshot.hasData) {
            if((snapshot.data?.length ?? 0) > 0) {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  Endorsment? endorsment = snapshot.data?[index];
                  if(endorsment != null){
                    return _buildEndorsmentItem(endorsment);
                  }
                },
              );
            } else {
              return Container(
                child: Center(
                  child: Text(
                    "No endorsment record found",
                    style: GoogleFonts.openSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(4, 41, 68, 1) // semi-bold
                    ),
                  ),
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text(
                  "Error load endorsment",
                  style: GoogleFonts.openSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(4, 41, 68, 1) // semi-bold
                  ),
                ),
              ),
            );
          }

          return Container();
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
              endorsment?.title ?? "",
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
                endorsment.description ?? "",
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
                    DateUtil.getDateFormattedFromString(endorsment.issuedDate ?? "", DateUtil.yyyyMMddHHmma),
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
                        endorsment.expirationDate ?? "",
                        DateUtil.yyyyMMddHHmma),
                    style: GoogleFonts.openSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey // semi-bold
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
