import 'package:flutter/material.dart';

import 'app_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String message;

  const CustomErrorWidget(
      {super.key, required this.message, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            "Oops!!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: AppButton(
            onPressed: () => onTap(),
            btnLabel: 'Reload!',
          ),
        )
      ],
    );
  }
}
