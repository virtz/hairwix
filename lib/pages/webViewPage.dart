import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hairmarket/pages/index.dart';
import 'package:hairmarket/providers/cartProvider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String fullname;
  final String referenceId;
  final String email;

  const WebViewPage({Key key, this.fullname, this.referenceId, this.email})
      : super(key: key);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (BuildContext context) {
          return launchWebview();
        }),
        floatingActionButton: nextButton(),
      ),
    );
  }

  Widget launchWebview() {
    var cartProvider = Provider.of<CartProvider>(context);
    var fullname = widget.fullname;
    var referenceId = widget.referenceId;
    var email = widget.email;
    var totalPrice = cartProvider.total;
    var url =
        "https://hairwix.com/customer/paymentgateway?refid=$referenceId&email=$email&name=$fullname&price=$totalPrice";

    print(url);

    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      gestureNavigationEnabled: true,
    );
  }

  Widget nextButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                // final String url = await controller.data.currentUrl();
                // Scaffold.of(context).showSnackBar(
                //   SnackBar(content: Text('Favorited $url')),
                // );
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Index()));
              },
              child: const Icon(Icons.arrow_right,),tooltip: 'Select when done with payment',
            );
          }
          return Container();
        });
  }
}
