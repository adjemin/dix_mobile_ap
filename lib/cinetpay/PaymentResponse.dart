class PaymentResponse{

  bool success;
  String message;

  PaymentResponse(this.success, this.message);

  factory PaymentResponse.fromJson(Map<String, dynamic> json) => PaymentResponse(json["success"] as bool, json["message"] as String);

  Map<String, dynamic> toJson() => {
    "success":this.success,
    "message":this.message
  };


}
