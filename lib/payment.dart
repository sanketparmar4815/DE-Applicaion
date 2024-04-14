import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class payment extends StatefulWidget {
  const payment({Key? key}) : super(key: key);

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  Razorpay razorpay = Razorpay();
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
