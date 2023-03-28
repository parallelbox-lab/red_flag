
class SubscriptionPayment{
  String? id;
  String? amount;
  String? profilePic;
  String? userId;
  String? fullname;
  String? status;
  String? paymentDate;

  SubscriptionPayment({
    this.id,
    this.amount,
    this.profilePic,
    this.fullname,
    this.userId,
    this.status,
    this.paymentDate
  });


  SubscriptionPayment.fromJson(Map<String, dynamic> map,)
   : id = map['id'],
    amount = map["amount"],
    profilePic = map["profilePic"],
    paymentDate = map["paymentDate"],
     fullname = map['fullName'],
     status = map["status"],
     userId = map['userId'];

     Map<String, dynamic> toJson(){
    return {
     'id' : id,
    'profilePic' : profilePic,
    'amount' : amount,
    'status' : status,
     'fullName' : fullname,
     'paymentDate' : paymentDate,
     'userId' : userId,
    };
 }
}