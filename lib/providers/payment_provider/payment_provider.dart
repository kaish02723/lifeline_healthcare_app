import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../services/razor/payment_api_service.dart';
import '../../services/razor/razorpay_service.dart';

class PaymentProvider with ChangeNotifier {
  bool loading = false;
  String message = "";

  final PaymentApiService apiService = PaymentApiService();
  final RazorpayService razorpayService = RazorpayService();

  Future<void> startPayment(
      BuildContext context,
      String serviceType,
      String serviceId,
      int amount,
      Function() onPaymentSuccess,
      Function(String) onPaymentError,
      ) async {

    loading = true;
    notifyListeners();

    final response =
    await apiService.createOrder(context, serviceType, serviceId, amount.toDouble());
    print("PAYMENT INIT RESPONSE => $response");
    print("response Runtimr ${response.runtimeType}");

    if (response["order_id"] == null || response["key"] == null) {
      throw Exception("Invalid payment init data");
    }

    final String orderId = response["order_id"];
    final String key = response["key"];
    final int paymentId = response["payment_id"];
    razorpayService.initRazorpay();

    razorpayService.razorpay!.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse res) async {
        razorpayService.paymentSuccess(res);

        await apiService.verifyPayment(
          context,
          paymentId.toString(),     // DB payment_id
          res.paymentId!,           // Razorpay payment id
        );

        loading = false;
        notifyListeners();
        onPaymentSuccess();
      },
    );

    razorpayService.razorpay!.on(
      Razorpay.EVENT_PAYMENT_ERROR,
          (PaymentFailureResponse res) {
        loading = false;
        notifyListeners();
        onPaymentError(res.message ?? "Payment failed");
      },
    );

    razorpayService.openRazorpay(
      orderId,
      (amount * 100).toInt(), // ✅ correct
      key,
    );
  }
}
