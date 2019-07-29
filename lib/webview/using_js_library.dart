import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:fuchsia_webview_flutter/webview.dart';
import 'dart_apex_charts_example.dart';

class UsingJSLibraryInWebView extends StatelessWidget {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

 // var control = FuchsiaWebView();
  DrawSimpleBar opt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Run JS LIbrary in Webview")),
      body: Center(
        child: FutureBuilder<String>(
          future: _loadLocalHTML(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Builder(
                builder: (context) {
                  return WebView(
                    initialUrl: new Uri.dataFromString(snapshot.data,
                            mimeType: 'text/html')
                        .toString(),
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FutureBuilder<WebViewController>(
          future: _controller.future,
          builder: (BuildContext context,
              AsyncSnapshot<WebViewController> controller) {
            if (controller.hasData) {
              return FloatingActionButton(
                onPressed: () async {
                  controller.data.evaluateJavascript(
//                      "cube.material.color.setHex('0x' + Math.floor(Math.random() * 16777215).toString(16));");
                      opt.options.toString());
                },
                child: const Icon(Icons.refresh),
              );
            }
            return Container();
          }),
    );
  }
}

Future<String> _loadLocalHTML() async {
  return await rootBundle.loadString('assets/index.html');
}
