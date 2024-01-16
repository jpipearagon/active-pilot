import 'package:aircraft/src/apis/payment_api.dart';
import 'package:aircraft/src/bloc/invoices_bloc.dart';
import 'package:aircraft/src/models/Pay.dart';
import 'package:aircraft/src/models/Reservation.dart';
import 'package:aircraft/src/models/UserRole.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:aircraft/src/widgets/message_widget.dart';
import 'package:aircraft/utils/colors_util.dart';
import 'package:aircraft/utils/date_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

import 'web_view.dart';

class InvoiceReadyToPayView extends StatefulWidget {
  InvoiceReadyToPayView({
    Key? key,
  }) : super(key: key);

  @override
  _InvoiceReadyToPayViewState createState() => _InvoiceReadyToPayViewState();
}

class _InvoiceReadyToPayViewState extends State<InvoiceReadyToPayView> {
  final _invoiceBloc = InvoicesBloc();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _invoiceBloc.loadRservation();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        color: Colors.white,
        opacity: 1.0,
        progressIndicator: Lottie.asset('assets/gifs/35718-loader.json',
            width: 100, height: 100),
        isLoading: _isLoading,
        child: _app(context));
  }

  Widget _app(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder<dynamic>(
        stream: _invoiceBloc.reservationStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data is List<Reservation>) {
              final List<Reservation> list = snapshot.data;
              if (list.length > 0) {
                return ListView.builder(
                  key: Key("InvoiceReadyToPay"),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    Reservation reservation = list[index];
                    return _buildEvent(context, reservation);
                  },
                );
              } else {
                return Container(
                  child: Center(
                    child: Text(
                      "No reservation ready to pay found",
                      style: GoogleFonts.openSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(4, 41, 68, 1) // semi-bold
                      ),
                    ),
                  ),
                );
              }
            } else if(snapshot.data is String) {
              final String codeError = snapshot.data;
              return Container(
                child: Center(
                  child: Text(
                    codeError,
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
                  "Error load reservation",
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

  Widget _buildEvent(BuildContext context, Reservation reservation) {

    final prefs = SharedPreferencesUser();
    var title = "";
    var subtitle = "";
    final Role role = enumFromString(Role.values, prefs.role);
    switch (role) {
      case Role.admin:
      case Role.instructor:
        title = "${reservation.userPilot?.firstName} ${reservation.userPilot?.lastName}";
        subtitle = "${reservation.activity?.name}";
        break;

      case Role.pilot:
        if (prefs.isPilot) {
          title = prefs.flyAlone ? "${reservation.userInstructor?.instructor?.scheduleName}" : "${reservation.aircraft?.name}";
          subtitle = "${reservation.activity?.name}";
        }
        break;

      case Role.student:
      case Role.registered:
        title = "${reservation.userInstructor?.instructor?.scheduleName}";
        subtitle = "${reservation.activity?.name}";
        break;
    }

    return InkWell(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        DateUtil.getDateFormattedFromString(reservation.start ?? "", DateUtil.yyyyMMdd),
                        style: GoogleFonts.montserrat(
                          //fontFamily: "Montserrat",
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(4, 41, 68, 1) // semi-bold
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        DateUtil.getDateFormattedFromString(reservation.start ?? "", DateUtil.HHmma),
                        style: GoogleFonts.montserrat(
                          //fontFamily: "Montserrat",
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(165, 164, 164, 1) // semi-bold
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        DateUtil.getDateFormattedFromString(reservation.end ?? "", DateUtil.HHmma),
                        style: GoogleFonts.montserrat(
                          //fontFamily: "Montserrat",
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(165, 164, 164, 1) // semi-bold
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Container(
                    width: 1,
                    height: MediaQuery.of(context).size.height * 0.090,
                    decoration:
                    BoxDecoration(color: Color.fromRGBO(106, 107, 108, 1)),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.montserrat(
                              //fontFamily: "Montserrat",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(4, 41, 68, 1) // semi-bold
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.openSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(4, 41, 68, 1) // semi-bold
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorsUtils.getColorFromHex(
                                  reservation.status?.color ?? ""),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(12))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              10.0,
                              1.0,
                              10.0,
                              1.0,
                            ),
                            child: Text(
                              reservation.status?.name ?? "",
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white // semi-bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Container(
                    width: 1,
                    height: MediaQuery.of(context).size.height * 0.090,
                    decoration:
                    BoxDecoration(color: Color.fromRGBO(106, 107, 108, 1)),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "FT",
                              style: GoogleFonts.montserrat(
                                //fontFamily: "Montserrat",
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(4, 41, 68, 1) // semi-bold
                              ),
                            ),
                            Expanded(
                              child: AutoSizeText(
                                "${reservation.paying?.ft}",
                                minFontSize: 2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  //fontFamily: "Montserrat",
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(165, 164, 164, 1) // semi-bold
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "GTR",
                              style: GoogleFonts.montserrat(
                                //fontFamily: "Montserrat",
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(4, 41, 68, 1) // semi-bold
                              ),
                            ),

                            Text(
                              "${reservation.paying?.git}",
                              style: GoogleFonts.montserrat(
                                //fontFamily: "Montserrat",
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(165, 164, 164, 1) // semi-bold
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 0.3,
              width: double.infinity,
              decoration: BoxDecoration(color: Color.fromRGBO(106, 107, 108, 1)),
            ),
          ],
        ),
      ),
      onTap: () => goToReservation(context, reservation),
    );
  }

  void goToReservation(BuildContext context, Reservation reservation) {
    _checkGoToPay(context, reservation);
  }

  void _checkGoToPay(BuildContext context, Reservation reservation) async {
    setState(() {
      _isLoading = true;
    });

    final _paymentApi = PaymentApi();
    final paymentEnabled = await _paymentApi.checkPay();
    setState(() {
      _isLoading = false;
    });

    if(paymentEnabled) {
      _gotoPay(context, reservation);
    }
  }

  void _gotoPay(BuildContext context, Reservation reservation) async {
    setState(() {
      _isLoading = true;
    });

    final _paymentApi = PaymentApi();
    final paymentResponse =
    await _paymentApi.goToPay(reservation.sId ?? "");
    setState(() {
      _isLoading = false;
    });

    if(paymentResponse != null) {
      if(paymentResponse is Pay) {
        final result = await Navigator.of(context).pushNamed(OpenWebView.routeName, arguments: {"url": paymentResponse.url});
        if (result != null && result as bool && result) {
          setState(() {
            _invoiceBloc.loadRservation();
          });
        }
      } else if(paymentResponse is String) {
        final String codeError = paymentResponse;
        showMessage(context, "Error pay reservation", codeError);
      }
    } else {
      showMessage(context, "Error Pay", "Error pay reservation.");
    }
  }

}
