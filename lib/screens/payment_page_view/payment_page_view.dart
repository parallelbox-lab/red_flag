import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/view_model/pay_pal_init_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPageView extends StatefulWidget {
  const PaymentPageView({ Key? key,this.onFinish, required this.amount }) : super(key: key);
  final Function? onFinish;
  final int amount;

  @override
  State<PaymentPageView> createState() => _PaymentPageViewState();
}

class _PaymentPageViewState extends State<PaymentPageView> {
  late WebViewController controllerGlobal;
  bool isLoading = true;
Future<bool> _handleBackButton(BuildContext context) async {
  if (await controllerGlobal.canGoBack()) {
     controllerGlobal.goBack();
     return Future.value(false);
  } else {
    // Scaffold.of(context).showSnackBar(
    //   const SnackBar(content: Text("No back history item")),
    // );
    return Future.value(true);
      } 
    }

@override
  void initState() {
    super.initState();
    final provider = Provider.of<PayPalInitViewModel>(context, listen: false);
    provider.init(widget.amount);

  }

  final Completer<WebViewController> _controller =
        Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PayPalInitViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: "Subscribe to Premium",),
      ),
       body: Stack(
          children: [
            

            // WebView(
            //   // onProgress: (int progess) {
            //   //  const CircularProgressIndicator();
            //   // },
            //   navigationDelegate: (NavigationRequest request) {
            //     if (request.url.startsWith(provider.checkoutUrl??"")) {
            //      final uri = Uri.parse(request.url);
            //      final payerID = uri.queryParameters['PayerID'];
            //     if (payerID != null) {
            //     provider.payPalServices.executePayment(provider.executeUrl, payerID, provider.accessToken).then((id) {
            //       widget.onFinish!(id);
            //       Navigator.of(context).pop();
            //     });
               
            //   } else {
            //     Navigator.of(context).pop();
            //   }
            //   Navigator.of(context).pop();
            // }
            //   return NavigationDecision.prevent;             
            //     // return NavigationDecision.navigate;
            //   },
            //   initialUrl: provider.checkoutUrl??"",
            //   javascriptMode: JavascriptMode.unrestricted,
            //   onWebViewCreated: (WebViewController webViewController) {
            //     _controller.future.then((value) => controllerGlobal = value);
            //     _controller.complete(webViewController);
            //   },
            //    onPageFinished: (finish) {
            //   setState(() {
            //     isLoading = false;
            //   });
            // },
            // ),
             isLoading ? const Center( child: CircularProgressIndicator(),)
                    : Stack(),
          ],
        ),
    );
  }
}