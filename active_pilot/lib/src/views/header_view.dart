import 'package:aircraft/src/constants/application_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderView extends StatelessWidget {

  final String title;
  final String subtitle;
  HeaderView({Key key, @required this.title, @required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildTitle(context),
    );
  }

  Widget buildTitle(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;

    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                top: paddingTop + 10.0,
                bottom: 4.0,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 12.0,
                      color: ApplicationColors().backArrow,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 11.0,
                      ),
                      child: Text(
                        title,
                        style: GoogleFonts.montserrat(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white // semi-bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 23.0,
                top: 0.0,
              ),
              child: Text(
                subtitle,
                style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white // semi-bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
