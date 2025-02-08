import 'package:book_app/application/book_bloc/book_bloc.dart';
import 'package:book_app/configs/frontend.dart';
import 'package:book_app/presentation/elements/auth_field.dart';
import 'package:book_app/presentation/elements/custom_appbar.dart';
import 'package:book_app/presentation/elements/custom_text.dart';
import 'package:book_app/presentation/views/books/book_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infrastructure/models/book.dart';
import '../../../injection_container.dart';
import '../../elements/book_widget.dart';
import '../../elements/error_widget.dart';
import '../../elements/processing_widget.dart';

class SearchBookView extends StatelessWidget {
  SearchBookView({super.key});

  TextEditingController searchController = TextEditingController();

  List<BookModel> bookList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BookBloc>(),
      child: Scaffold(
        appBar: customAppBar(context, text: 'Search Books', showText: true),
        body: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            return BlocListener<BookBloc, BookState>(
              listener: (context, state) {
                if (state is BookLoaded) {
                  bookList.clear();
                  bookList.addAll(state.model.data!);
                } else if (state is BookFailed) {}
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: searchController,
                      onSubmitted: (val) {
                        if (searchController.text.isNotEmpty) {
                          BlocProvider.of<BookBloc>(context)
                              .add(SearchBookEvent(searchController.text));
                        }
                      },
                      text: 'Search Books',
                      onTap: () {},
                      keyBoardType: TextInputType.text,
                      icon: 'assets/images/profile.svg',
                    ),
                    FrontendConfigs.appDivider,
                    Expanded(
                      child: state is BookLoading
                          ? const Center(
                              child: ProcessingWidget(),
                            )
                          : bookList.isEmpty && state is BookLoaded
                              ? Center(
                                  child: CustomText(
                                    text: 'No Data Found!',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : GridView.builder(
                                  clipBehavior: Clip.none,
                                  itemCount: bookList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          childAspectRatio: 0.65,
                                          mainAxisSpacing: 20),
                                  itemBuilder: (context, i) {
                                    return BookWidget(model: bookList[i]);
                                  }),
                    )
                  ],
                ),
              ),
            );
            if (state is BookInitial) {
              BlocProvider.of<BookBloc>(context).add(GetBooksEvent());
              return const ProcessingWidget();
            } else if (state is BookLoading) {
              return const ProcessingWidget();
            } else if (state is BookLoaded) {
            } else if (state is BookFailed) {
              return CustomErrorWidget(
                  message: state.message.toString(),
                  onTap: () {
                    BlocProvider.of<BookBloc>(context).add(GetBooksEvent());
                  });
            } else {
              return CustomErrorWidget(
                  message: "Something went wrong.",
                  onTap: () {
                    BlocProvider.of<BookBloc>(context).add(GetBooksEvent());
                  });
            }
          },
        ),
      ),
    );
  }
}
