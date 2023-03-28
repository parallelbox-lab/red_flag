import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/model/subscription_payment_model.dart';

class SubscriptionPaymentRepository {
final FirebaseFirestore _db = FirebaseFirestore.instance;
Future createPaymentDetails({SubscriptionPayment? subscriptionPayment}) async {
  var result = await _db.collection("Subscription").add(
      subscriptionPayment!.toJson()
    );
  await _db.collection("Subscription").doc(result.id).update({"id":result.id});
 }
 Future<List<SubscriptionPayment>> getPaymentDetails() async {
  return await _db.collection("Subscription").where("userId",isEqualTo: UserData.getUserId()).orderBy("paymentDate",descending: true)
        .get()
        .then(((value) => value.docs.map((e) => SubscriptionPayment.fromJson(e.data())).toList()))
        .catchError((error) {
        });
   }
}