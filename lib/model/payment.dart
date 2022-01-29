class ModelPayment{

  late String tran_ref,cart_description,cart_amount;

  ModelPayment.fromJson(Map<dynamic, dynamic> json) {
    tran_ref = json['tran_ref'];
    cart_description = json['cart_description'];
    cart_amount = json['cart_amount'];
  }
}