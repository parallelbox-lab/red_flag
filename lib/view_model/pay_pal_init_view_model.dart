import 'package:flutter/material.dart';
import 'package:red_flag/data/services/paypal_services.dart';

class PayPalInitViewModel extends ChangeNotifier{
  String? checkoutUrl;
  String? executeUrl;
  String? accessToken;

  PayPalServices payPalServices = PayPalServices();
  // you can change default currency according to your need
  Map<dynamic,dynamic> defaultCurrency = {"symbol": "USD ", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "USD"};

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL= 'cancel.example.com';

  Future init(int? amount) async {
    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await payPalServices.getAccessToken();
        final transactions = getOrderParams(amount);
        final res =
        await payPalServices.createPaypalPayment(transactions, accessToken);
        if (res.isNotEmpty) {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
        }
      } catch (e) {
        print('exception: '+e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration:const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        // _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  // item name, price and quantity
  String itemName = 'Premium asaubscription';

  Map<String, dynamic> getOrderParams(int? amount) {
    Map<String, dynamic> temp = {
      "intent": "Subscription",
      "purchase_units": [
        {
          amount: {
            "currency_code": "USD",
            "value": "100.00",
          },
        },
      ],
      // "note_to_payer": "Contact us for any questions on your order.",
      // "redirect_urls": {
      //   "return_url": returnURL,
      //   "cancel_url": cancelURL
      // }
    };
    return temp;
  }

// payNow() async {
//     FlutterPaypalSDK sdk = FlutterPaypalSDK(
//       clientId: 'AWWXXr1Duyd4ZjJAUoCAQrfvifSbo2bqjreCNvvpwOtOr1PJA7IjYkivO38ZnlUPLPszFS75F2Ra_DTx',
//       clientSecret: 'EMUIOO9Z8YOYOYSVOItn9WZjOFm2wkTkRVaeCkgu-0Yla9Ipusg8CNAYLVOF4gzuPnRG9VRvMQaILXDU',
//       mode: Mode.sandbox, // this will use sandbox environment
//     );
//     AccessToken accessToken = await sdk.getAccessToken();
//     if (accessToken.token != null) {
//       Payment payment = await sdk.createPayment(
//         transaction(),
//         accessToken.token!,
//       );
//       if (payment.status) {
//         debugPrint(payment.approvalUrl);
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => PaypalWebview(
//         //       approveUrl: payment.approvalUrl!,
//         //       executeUrl: payment.executeUrl!,
//         //       accessToken: accessToken.token!,
//         //       sdk: sdk,
//         //     ),
//         //   ),
//         // );
//       }
//     }
//   }

//   transaction() {
//     Map<String, dynamic> transactions = {
//       "intent": "sale",
//       "payer": {
//         "payment_method": "paypal",
//       },
//       "redirect_urls": {
//         "return_url": "/success",
//         "cancel_url": "/cancel",
//       },
//       'transactions': [
//         {
//           "amount": {
//             "currency": "USD",
//             "total": "10",
//           },
//         }
//       ],
//     };

//     return transactions;
//   }
}