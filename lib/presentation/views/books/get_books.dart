import 'dart:developer';

import 'package:book_app/application/book_bloc/book_bloc.dart';
import 'package:book_app/application/cart_bloc/cart_bloc.dart';
import 'package:book_app/configs/frontend.dart';
import 'package:book_app/infrastructure/models/cart.dart';
import 'package:book_app/presentation/elements/auth_field.dart';
import 'package:book_app/presentation/elements/book_widget.dart';
import 'package:book_app/presentation/elements/custom_text.dart';
import 'package:book_app/presentation/views/books/book_details.dart';
import 'package:book_app/presentation/views/books/search_books.dart';
import 'package:book_app/presentation/views/cart/cart.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../injection_container.dart';
import '../../elements/app_button.dart';
import '../../elements/error_widget.dart';
import '../../elements/processing_widget.dart';

class GetBooksView extends StatefulWidget {
  const GetBooksView({super.key});

  @override
  State<GetBooksView> createState() => _GetBooksViewState();
}

class _GetBooksViewState extends State<GetBooksView> {
  @override
  void initState() {
    // if (state is CartInitial) {
    context.read<CartBloc>().add(GetCartList());
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<BookBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CartBloc>(),
        ),
      ],
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 0,
              backgroundColor: Colors.white,
              leading: const SizedBox(),
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Books ",
                      style: GoogleFonts.raleway(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "Junction! 👋",
                      style: GoogleFonts.raleway(
                        color: FrontendConfigs.kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Badge(
                  isLabelVisible:
                      context.watch<CartBloc>().getCartItems().isNotEmpty,
                  label: Text(context
                      .watch<CartBloc>()
                      .getCartItems()
                      .length
                      .toString()),
                  offset: const Offset(-1, 6),
                  child: IconButton(
                      onPressed: () async {
                        await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CartView()))
                            .then((val) {
                          context.read<CartBloc>().add(GetCartList());
                        });
                      },
                      icon: const Icon(CupertinoIcons.shopping_cart)),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FrontendConfigs.appDivider,
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchBookView()));
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: FrontendConfigs.kTextFieldColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            const Icon(CupertinoIcons.search),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomText(
                              text: 'Search for Books',
                              fontSize: 13,
                              color: FrontendConfigs.kPrimaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: 'Best Sellers 🔥',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: BlocListener<BookBloc, BookState>(
                      listener: (context, state) {},
                      child: BlocBuilder<BookBloc, BookState>(
                        builder: (context, state) {
                          if (state is BookInitial) {
                            BlocProvider.of<BookBloc>(context)
                                .add(GetBooksEvent());
                            return const ProcessingWidget();
                          } else if (state is BookLoading) {
                            return const Center(child: ProcessingWidget());
                          } else if (state is BookLoaded) {
                            return GridView.builder(
                                clipBehavior: Clip.none,
                                itemCount: state.model.data!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 0.65,
                                        mainAxisSpacing: 20),
                                itemBuilder: (context, i) {
                                  return BookWidget(
                                      model: state.model.data![i]);
                                });
                          } else if (state is BookFailed) {
                            return CustomErrorWidget(
                                message: state.message.toString(),
                                onTap: () {
                                  BlocProvider.of<BookBloc>(context)
                                      .add(GetBooksEvent());
                                });
                          } else {
                            return CustomErrorWidget(
                                message: "Something went wrong.",
                                onTap: () {
                                  BlocProvider.of<BookBloc>(context)
                                      .add(GetBooksEvent());
                                });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
