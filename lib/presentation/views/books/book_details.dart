import 'package:book_app/infrastructure/models/book.dart';
import 'package:book_app/presentation/elements/custom_appbar.dart';
import 'package:flutter/material.dart';

class BookDetailsView extends StatelessWidget {
  final BookModel model;

  const BookDetailsView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBar(context, text: model.title.toString(), showText: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(model.content.toString()),
        ),
      ),
    );
  }
}
