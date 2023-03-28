import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:red_flag/data/repository/subscription_payment_repository.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/model/subscription_payment_model.dart';
import 'package:red_flag/screens/bottom_navigation.dart';
import 'package:red_flag/widgets/common.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

class SubscriptionViewModel extends ChangeNotifier{
  List<SubscriptionPayment> _paymentList = [];
  List<SubscriptionPayment> get paymentList => _paymentList;
  bool _isLoading = false;
  bool get isLoading =>_isLoading;
  Offerings? offerings;

  loading(bool? loading){
  _isLoading = loading ?? false;
  notifyListeners();
 }
  final SubscriptionPaymentRepository _subscriptionPaymentRepository = SubscriptionPaymentRepository(); 
  Future<void> updateSubscriptionStatus ({bool? status}) async {
    await FirebaseFirestore.instance.collection("UserData").doc(UserData.getUserId()).update({"isPremium":status ?? false});
    await UserData.updatePremiumStatus(status ?? false);
    notifyListeners();
  }
  Future<void> savePaymentDetails (BuildContext context, {String? amount}) async {
   final subscription =  SubscriptionPayment(
      profilePic: UserData.getUserProfilePic(),
      fullname: UserData.fullName(),
      userId: UserData.getUserId(),
      status: "Completed",
      paymentDate: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amount

    );

  bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();
   try{   
    if (isConnected == true) {
     _subscriptionPaymentRepository.createPaymentDetails(subscriptionPayment:subscription);
     Navigator.pushNamedAndRemoveUntil(context, BottomNavigation.routeName, (route) => false) ;
    } else {
      showerrorDialog("No network connection 😞", context,false);
    }
    } catch (e){
      showerrorDialog("Unable to save Payment Details", context,false);
    }
  }

 Future<void> getSubscription(BuildContext context) async {
    try{
     loading(true);
    _paymentList = await _subscriptionPaymentRepository.getPaymentDetails();
      loading(false);
    } catch(e){
      loading(false);
    }
    // print(riddleList.map((e) => print(e.title)));
  }

// get offering or products from revenue cat 
  Future fetchOffers() async {
   offerings =  await Purchases.getOfferings();
   print(offerings?.current?.monthly.toString());
   notifyListeners();
  }



}