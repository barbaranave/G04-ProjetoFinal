import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleArguments {
  final String url;
  final String journalName;

  ArticleArguments(this.url, this.journalName);
}

class ArticlePage extends StatelessWidget {
  final String url;
  final String journalName;

  const ArticlePage({Key? key, required this.url, required this.journalName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          journalName,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Color.fromRGBO(253, 250, 223, 1),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
