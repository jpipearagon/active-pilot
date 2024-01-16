import 'dart:async';
import 'dart:io';

import 'package:aircraft/src/bloc/deeplink_bloc.dart';
import 'package:aircraft/src/constants/application_colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'header_view.dart';

class OpenWebView extends StatefulWidget {

  static final routeName = "webview";

  @override
  _OpenWebViewState createState() => _OpenWebViewState();
}

class _OpenWebViewState extends State<OpenWebView> {

  String title = "";
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _deeplinkListener();
  }

  @override
  Widget build(BuildContext context) {

    final Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    String url = arguments?["url"];
    String webTitle = "";
    if(arguments?["title"] != null) {
      webTitle = arguments?["title"];
    }
    title = webTitle;

    return Scaffold(
      backgroundColor: ApplicationColors().primaryColor,
      body: Column(
        children: [
          HeaderView(title: title, subtitle: ""),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(top: 10),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(4, 41, 68, 1)
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                      )
                  ),
                  child: WebView(
                    initialUrl: url,
                    javascriptMode: JavascriptMode.unrestricted,
                    navigationDelegate: (NavigationRequest request) {
                      if (request.url.startsWith("acpi://com.activepilot.aircraft/events")) {
                        _launchURL(request.url);
                        return NavigationDecision.prevent;
                      } else {
                        return NavigationDecision.navigate;
                      }
                    },
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  void _deeplinkListener() {
    DeepLinkBloc deepLinkBloc = DeepLinkBloc();
    streamSubscription = deepLinkBloc.state.listen((event) {
        Navigator.of(context).pop(true);
    });
  }
}

