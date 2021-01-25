import 'PaymentResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CinetPaymentScreen extends StatefulWidget {
  String apiKey;

  int siteId;

  String notificationUrl;

  double amount;

  String transactionId;

  String currency;

  String designation;

  String cpmCustom;

  CinetPaymentScreen(
      this.apiKey,
      this.siteId,
      this.notificationUrl,
      this.amount,
      this.transactionId,
      this.currency,
      this.designation,
      this.cpmCustom);

  @override
  _CinetPaymentScreenState createState() => _CinetPaymentScreenState();
}

class _CinetPaymentScreenState extends State<CinetPaymentScreen> {
  @override
  void initState() {
    super.initState();

    print('NotificationUrl >> ${widget.notificationUrl}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: InAppWebView(
            initialFile: "assets/cinetpay.html",
            initialHeaders: {},
            initialOptions: new InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
                useOnLoadResource: true,
              ),
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              /* controller.evaluateJavascript(
                  source:
                      'window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {'
                      ''
                      'initData("${widget.apiKey}", ${widget.siteId}, "${widget.notificationUrl}", ${widget.amount}, "${widget.transactionId}", "${widget.currency}", "${widget.designation}",  "${widget.cpmCustom}"); '
                      ''
                      ' });'); */
              /* await controller.evaluateJavascript(
                  source:
                      """initData("${widget.apiKey}", ${widget.siteId}, "${widget.notificationUrl}",
                      ${widget.amount}, "${widget.transactionId}", "${widget.currency}", "${widget.designation}",  "${widget.cpmCustom}");""");
                      controller.addJavaScriptHandler(
                          handlerName: 'success',
                          callback: (args) {
                            onMessage("success");
                            return "success";
                          }); */

              controller.addJavaScriptHandler(
                  handlerName: 'elementToSend',
                  callback: (args) {
                    return {
                      'api_key': "${widget.apiKey}",
                      'site_id': "${widget.siteId}",
                      'notification_url': "${widget.notificationUrl}",
                      'amount': "${widget.amount}",
                      'transaction_id': "${widget.transactionId}",
                      'currency': "${widget.currency}",
                      'designation': "${widget.designation}",
                      'cpmCustom': "${widget.cpmCustom}"
                    };
                  });

              controller.addJavaScriptHandler(
                  handlerName: 'success',
                  callback: (args) {
                    onMessage("success");
                    return "success";
                  });

              controller.addJavaScriptHandler(
                  handlerName: 'error',
                  callback: (args) {
                    onMessage("error");
                    return "error";
                  });
            },
            onLoadStart: (InAppWebViewController controller, String url) {
              print("started $url");
            },
            onProgressChanged:
                (InAppWebViewController controller, int progress) {},
            onConsoleMessage:
                (InAppWebViewController controller, ConsoleMessage message) {
              print("ConsoleMessage ${message.message}");
            },
          ),
        ),
      ),
    );
  }

  onMessage(String message) {
    if (message != null) {
      PaymentResponse paymentResponse;

      if (message == "success") {
        paymentResponse = PaymentResponse(true, "Votre paiement est validé");
      } else {
        paymentResponse = PaymentResponse(false, "Erreur rencontrée");
      }

      Navigator.of(context).pop(paymentResponse);
    }
  }
}
