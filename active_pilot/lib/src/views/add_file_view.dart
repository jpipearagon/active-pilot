import 'package:aircraft/src/apis/user_detail_api.dart';
import 'package:aircraft/src/models/ImageFile.dart';
import 'package:aircraft/src/models/UserDocuments.dart';
import 'package:aircraft/src/widgets/message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class AddFileView extends StatefulWidget {

  final Function finishUploadFile;
  final String idDocuments;
  final bool showExpired;

  AddFileView({Key? key, required this.idDocuments, required this.showExpired, required this.finishUploadFile}) : super(key: key);

  @override
  _AddFileViewState createState() => _AddFileViewState();
}

class _AddFileViewState extends State<AddFileView> {

  final TextEditingController _textEditingControllerExpedition =
  new TextEditingController();
  DateTime? _chosenDateTimeExpedition;
  final formatter = DateFormat("yyyy/MM/dd");
  List<PickedFile> _listFiles = [];
  final ImagePicker _picker = ImagePicker();
  bool _showLoad = false;

  @override
  Widget build(BuildContext context) {
    return _app(context);
  }

  Widget _app(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width - 100;
    final height = size.height/2.5;

    return Container(
      width: width,
      height: height,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Icon(Icons.close,
                  size: 30,
                  color: Color.fromRGBO(4, 41, 68, 1),),
                onTap: () => Navigator.of(context).pop(),
              )
            ],
          ),
          Text("Attach Files",
          style: GoogleFonts.montserrat(
            color: Color.fromRGBO(4, 41, 68, 1),
            fontSize: 14,
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: 10,),
          Visibility(
            child: _expeditionTextField(),
            visible: widget.showExpired,
          ),
          SizedBox(height: 10,),
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Add File",
                  style: GoogleFonts.montserrat(
                      color: Color.fromRGBO(4, 41, 68, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(width: 10,),
                Icon(Icons.add_a_photo)
              ],
            ),
            onTap: () => _showPicker(context),
          ),
          SizedBox(height: 10,),
          Expanded(child: _filesWidget(),),
          _showLoading(size)
        ],
      ),
    );
  }

  Widget _expeditionTextField() {
    return Container(
      child: TextField(
        autocorrect: false,
          readOnly: true,
        controller: _textEditingControllerExpedition,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Color.fromRGBO(106, 107, 108, 1)),
        decoration: InputDecoration(
            hintText: "Expedition date",
            hintStyle: GoogleFonts.openSans(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color.fromRGBO(106, 107, 108, 1)
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            ),
            prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                  width: 15,
                  height: 17,
                  child: Icon(Icons.calendar_today, color: Color.fromRGBO(223, 173, 78, 1))
              ),
            )
        ),
          onTap: () => _selectDateExpedition(context)
      ),
    );
  }

  Future<Null> _selectDateExpedition(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    final contentHeight = size.height/2;
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: contentHeight,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              // Close the modal
              CupertinoButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    if (_chosenDateTimeExpedition == null) {
                      _chosenDateTimeExpedition = DateTime.now();
                    }
                    _textEditingControllerExpedition.text = formatter.format(_chosenDateTimeExpedition ?? DateTime.now());
                  });
                  Navigator.of(context).pop();
                },
              ),
              Container(
                height: contentHeight*0.8,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: _chosenDateTimeExpedition,
                    onDateTimeChanged: (val) {
                      setState(() {
                        _chosenDateTimeExpedition = val;
                        _textEditingControllerExpedition.text = formatter.format(_chosenDateTimeExpedition ?? DateTime.now());
                      });
                    }),
              )
            ],
          ),
        )
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Pick Image from gallery'),
                      onTap: () {
                        _onImageButtonPressed(context, ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Take a Photo'),
                    onTap: () {
                      _onImageButtonPressed(context, ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Future _onImageButtonPressed(BuildContext context, ImageSource source) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
        imageQuality: 100,
      );
      if(pickedFile != null) {
        setState(() {
          _listFiles.add(pickedFile);
        });
      }
    } catch (e) {
      showMessage(context, "Error image selected", e.toString());
    }
  }

  Widget _filesWidget() {
    if(_listFiles.isNotEmpty) {
      return ListView.builder(
        itemCount: _listFiles.length,
        itemBuilder: (context, index) {
          PickedFile file = _listFiles[index];
          String fileName = file.path.split('/').last;
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
                onTap: () => _removeFile(index),
              )
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  void _removeFile(int index) {
    setState(() {
      _listFiles.removeAt(index);
    });
  }

  bool _checkUpload() {
    if (widget.showExpired) {
      return _listFiles.isNotEmpty && _chosenDateTimeExpedition != null;
    } else {
      return _listFiles.isNotEmpty;
    }
  }

  Widget _showLoading(Size size) {
    if(_showLoad) {
      return Center(
        child: Lottie.asset(
            'assets/gifs/35718-loader.json',
            width: 50,
            height: 50
        ),
      );
    } else {
      return MaterialButton(
        onPressed: () => {},
        child: ButtonTheme(
          minWidth: size.width * 0.48,
          height: 36,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _checkUpload() ? Color.fromRGBO(223, 173, 78, 1) : Color.fromRGBO(106,107,108,0.4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.5),
                  side: BorderSide(color: Colors.transparent)
              ),
            ),
            child: Text(
              "Upload Files",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: "Open Sans",
                  fontWeight: FontWeight.w400),
            ),
            onPressed: _checkUpload() ? () => _uploadFiles(): null,
          ),
        ),
      );
    }
  }

  void _uploadFiles() async {
    setState(() {
      _showLoad = true;
    });

    Map<String, String> fields = {
      "expirationDate": _textEditingControllerExpedition.text,
    };

    List<ImageFile> files = [];

    if(_listFiles.isNotEmpty) {
      _listFiles.forEach((file) {
        files.add(ImageFile(name: "files", file: file));
      });
    }

    final userDetailApi = UserDetailApi();
    final response = await userDetailApi.addFilesDocument(widget.idDocuments ?? "", fields, files);

    setState(() {
      _showLoad = false;
    });

    if(response != null) {
      if(response is UserDocuments) {
        widget.finishUploadFile();
        Navigator.of(context).pop();
      } else if(response is String) {
        final String codeError = response;
        showMessage(context, "Error Upload File", codeError);
      }
    } else {
      showMessage(context, "Error Upload File", "Error Upload File.");
    }
  }
}
