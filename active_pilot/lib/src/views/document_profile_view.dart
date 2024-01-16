import 'dart:ffi';

import 'package:aircraft/src/apis/user_detail_api.dart';
import 'package:aircraft/src/bloc/user_bloc.dart';
import 'package:aircraft/src/models/UserDocuments.dart';
import 'package:aircraft/src/views/add_file_view.dart';
import 'package:aircraft/src/widgets/message_widget.dart';
import 'package:aircraft/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class DocumentProfileView extends StatefulWidget {
  DocumentProfileView({
    Key? key,
  }) : super(key: key);

  @override
  _DocumentProfileViewState createState() => _DocumentProfileViewState();
}

class _DocumentProfileViewState extends State<DocumentProfileView> {
  final formatter = DateFormat("yyyy/MM/dd");
  final _userBloc = UserBloc();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _userBloc.loadDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        color: Colors.white,
        opacity: 1.0,
        progressIndicator: Lottie.asset(
            'assets/gifs/35718-loader.json',
            width: 100,
            height: 100
        ),
        isLoading: _isLoading,
        child: _app(context)
    );
  }

  Widget _app(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder<List<UserDocuments>>(
        stream: _userBloc.documentsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && (snapshot.data?.length ?? 0) > 0) {
            return ListView.builder(
              key: Key("documents"),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                UserDocuments? userDocuments = snapshot.data?[index];
                if(userDocuments != null){
                  return _buildItemDocuments(userDocuments);
                } else {
                  return Container();
                }
              },
            );
          }

          return Container();

        },
      ),
    );
  }

  Widget _buildItemDocuments(UserDocuments userDocuments) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(238, 238, 238, 1)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 10.0,
                  ),
                  child: Text(
                    "${userDocuments.documentTemplate?.title?.toUpperCase()}",
                    style: TextStyle(
                        color: Color.fromRGBO(4, 41, 68, 1),
                        fontSize: 14,
                        fontFamily: "Open Sans",
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Visibility(
                  visible: !((userDocuments.files?.length ?? 0) > 0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
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
                        child: Text("Missing",
                          style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white // semi-bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              decoration:
              BoxDecoration(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Expiration: ",
                  style: TextStyle(
                      color: Color.fromRGBO(4, 41, 68, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "${DateUtil.getDateFormattedFromString(userDocuments?.expirationDate ?? "", DateUtil.yyyyMMdd)}",
                  style: TextStyle(
                      color: Color.fromRGBO(106, 107, 108, 1),
                      fontSize: 12,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Row(
                children: [
                  Icon(Icons.file_upload, color: Color.fromRGBO(106, 107, 108, 1)),
                  SizedBox(width: 5,),
                  Text(
                    "Upload documents",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color.fromRGBO(106, 107, 108, 1),
                      decoration: TextDecoration.underline
                    ),
                  )
                ],
              ),
              onTap: () => _showAddFile(userDocuments.sId ?? "", userDocuments.documentTemplate?.expires ?? false),
            ),
            SizedBox(
              height: 10,
            ),
            _buildAttachment(userDocuments.sId ?? "", userDocuments.files ?? [])
          ],
        ),
      ),
    );
  }

  Widget _buildAttachment(String idDocument, List<Files> files) {
    if(files != null && files.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1,
            decoration:
            BoxDecoration(color: Color.fromRGBO(238, 238, 238, 1)),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 10.0,
            ),
            child: Text(
              "Attached Files",
              style: TextStyle(
                  color: Color.fromRGBO(4, 41, 68, 1),
                  fontSize: 14,
                  fontFamily: "Open Sans",
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            decoration:
            BoxDecoration(color: Color.fromRGBO(238, 238, 238, 1)),
          ),
          SizedBox(
            height: 10,
          ),
          _listAttachment(idDocument, files),
          SizedBox(
            height: 20,
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _listAttachment(String idDocument, List<Files> files) {
    double height = 31 * files.length.toDouble();
    return Container(
      height: height,
      child: ListView.builder(
        itemCount: files.length,
          itemBuilder: (context, index) {
            Files file = files[index];
            String? fileName = file.url?.split('/').last;
            return SizedBox(
              height: 30,
              child: ListTile(
                  title: Text(
                    "$fileName",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                        color: Color.fromRGBO(106, 107, 108, 1),
                        fontWeight: FontWeight.w600,
                        fontSize: 12
                    ),
                  ),
                  leading: Icon(Icons.attach_file, color: Color.fromRGBO(4, 41, 68, 1),),
                  trailing: InkWell(
                    child: Icon(Icons.clear,
                        color: Color.fromRGBO(106, 107, 108, 1)
                    ),
                    onTap: () => _removeFile(idDocument, file),
                  )
              ),
            );
          },
          physics: const NeverScrollableScrollPhysics()
      ),
    );
  }

  void _removeFile(String idDocument, Files file) async{
    setState(() {
      _isLoading = true;
    });

    final userDetailApi = UserDetailApi();
    final response = await userDetailApi.removeFilesDocument(idDocument, file.sId ?? "");

    setState(() {
      _isLoading = false;
    });

    if(response != null) {
      if(response is UserDocuments) {
        _userBloc.loadDocuments();
      } else if(response is String) {
        final String codeError = response;
        showMessage(context, "Error Remove File", codeError);
      }
    } else {
      showMessage(context, "Error Remove", "Error remove user file.");
    }
  }

  void _showAddFile(String idDocuments, bool showField) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: AddFileView(idDocuments: idDocuments, showExpired: showField, finishUploadFile: _finishUploadFiles,),
          );
        });
  }

  void _finishUploadFiles() {
    _userBloc.loadDocuments();
  }
}
