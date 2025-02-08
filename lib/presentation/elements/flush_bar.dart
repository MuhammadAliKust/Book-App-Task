import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../views/cart/cart.dart';

getFlushBar(
  BuildContext context, {
  required String title,
}) {
  return Flushbar(
    message: title,
    icon: const Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.blue,
    ),
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    duration: const Duration(seconds: 3),
  )..show(context);
}

addToCartFlushBar(
  BuildContext context, {
  required String title,
}) {
  return Flushbar(
    message: title,
    icon: const Icon(
      Icons.check_circle_outline_rounded,
      size: 28.0,
      color: Colors.green,
    ),
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    duration: const Duration(seconds: 3),
    mainButton: TextButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const CartView()));
      },
      child: const Text(
        "Go to Cart",
        style: TextStyle(color: Colors.yellow),
      ),
    ),
  )..show(context);
}
