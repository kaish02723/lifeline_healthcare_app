import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../config/app_config.dart';

class RazorpayService {

  Razorpay? razorpay;

  String paymentId = "";
  String orderId = "";
  String signature = "";
  String errorMessage = "";
  String walletName = "";

  /// 1️⃣ Razorpay init
  void initRazorpay() {
    razorpay = Razorpay();

    razorpay!.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      paymentSuccess,
    );

    razorpay!.on(
      Razorpay.EVENT_PAYMENT_ERROR,
      paymentError,
    );

    razorpay!.on(
      Razorpay.EVENT_EXTERNAL_WALLET,
      externalWallet,
    );
  }

  /// 2️⃣ Open payment screen
  void openRazorpay(String orderId, int amount, String key) {

    // SAFETY CHECK — YAHIN USE HOGA
    if (razorpay == null) {
      initRazorpay();
    }

    var options = {
      'key': key,              // backend se aaya hua key
      'amount': amount * 100,  // Razorpay = paise
      'currency': 'INR',
      'order_id': orderId,
      'name': 'LLHC',
      'description': 'Payment',
    };

    razorpay!.open(options);
  }


  /// 3️⃣ Success
  void paymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId ?? "";
    orderId = response.orderId ?? "";
    signature = response.signature ?? "";
  }

  /// 4️⃣ Error
  void paymentError(PaymentFailureResponse response) {
    errorMessage = response.message ?? "Payment failed";
  }

  /// 5️⃣ External wallet
  void externalWallet(ExternalWalletResponse response) {
    walletName = response.walletName ?? "";
  }

  /// 6️⃣ Clear
  void clear() {
    razorpay?.clear();
  }
}
//RazorpayService ko callback-based
// class RazorpayService {
//   late Razorpay _razorpay;
//
//   VoidCallback? onSuccess;
//   Function(String)? onError;
//
//   void init({
//     required VoidCallback success,
//     required Function(String) error,
//   }) {
//     onSuccess = success;
//     onError = error;
//
//     _razorpay = Razorpay();
//
//     _razorpay.on(
//       Razorpay.EVENT_PAYMENT_SUCCESS,
//           (_) => onSuccess?.call(),
//     );
//
//     _razorpay.on(
//       Razorpay.EVENT_PAYMENT_ERROR,
//           (e) => onError?.call(e.message ?? "Payment failed"),
//     );
//   }
//
//   void open(String orderId, int amount, String key) {
//     _razorpay.open({
//       "key": key,
//       "amount": amount,
//       "currency": "INR",
//       "order_id": orderId,
//       "name": "LLHC",
//     });
//   }
//
//   void dispose() {
//     _razorpay.clear();
//   }
// }
