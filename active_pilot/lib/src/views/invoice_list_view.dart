import 'package:aircraft/src/bloc/invoices_bloc.dart';
import 'package:aircraft/src/models/Invoice.dart';
import 'package:aircraft/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceListView extends StatefulWidget {
  InvoiceListView({
    Key? key,
  }) : super(key: key);

  @override
  _InvoiceListViewState createState() => _InvoiceListViewState();
}

class _InvoiceListViewState extends State<InvoiceListView> {
  final _invoiceBloc = InvoicesBloc();

  @override
  void initState() {
    super.initState();
    _invoiceBloc.loadInvoice();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder<dynamic>(
        stream: _invoiceBloc.invoiceStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data is List<Invoice>) {
              List<Invoice> list = snapshot.data;
              if (list.length > 0) {
                return ListView.builder(
                  key: Key("invoice"),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    Invoice invoice = list[index];
                    return _buildInvoiceItemRow(invoice);
                  },
                );
              } else {
                return Container(
                  child: Center(
                    child: Text(
                      "No logbook record found",
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
                  "Error load logbook",
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

  Widget _buildInvoiceItemRow(Invoice invoice) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(238, 238, 238, 1)),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Date: ",
                  style: TextStyle(
                      color: Color.fromRGBO(4, 41, 68, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  DateUtil.getDateFormattedFromString(
                      invoice.reservation?.start ?? "", DateUtil.yyyyMMdd),
                  style: TextStyle(
                      color: Color.fromRGBO(106, 107, 108, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                height: 1,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(238, 238, 238, 1))
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Aircraft",
                        style: TextStyle(
                            color: Color.fromRGBO(4, 41, 68, 1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${invoice.reservation?.aircraft?.registrationTail}",
                        style: TextStyle(
                            color: Color.fromRGBO(106, 107, 108, 1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Status",
                        style: TextStyle(
                            color: Color.fromRGBO(4, 41, 68, 1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${invoice.status}",
                        style: TextStyle(
                            color: invoice.paid ?? false ? Colors.lightGreen : Colors.redAccent,
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Amount",
                        style: TextStyle(
                            color: Color.fromRGBO(4, 41, 68, 1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${invoice.amount}",
                        style: TextStyle(
                            color: Color.fromRGBO(106, 107, 108, 1),
                            fontSize: 12,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {

      },
    );
  }

}
