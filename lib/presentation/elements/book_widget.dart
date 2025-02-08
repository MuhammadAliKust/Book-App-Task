import 'package:book_app/application/cart_bloc/cart_bloc.dart';
import 'package:book_app/infrastructure/models/book.dart';
import 'package:book_app/infrastructure/models/cart.dart';
import 'package:book_app/presentation/views/books/book_details.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../configs/frontend.dart';
import '../../injection_container.dart';
import 'custom_text.dart';

class BookWidget extends StatelessWidget {
  final BookModel model;

  const BookWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 30,
                color: const Color(0xffC6C6C6).withOpacity(0.3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 130,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ExtendedImage.network(
                model.coverImage.toString(),
                cacheHeight: 200,
                cacheWidth: 200,
                fit: BoxFit.fill,
                cache: true,
                loadStateChanged: (ExtendedImageState state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Image.asset(
                          "assets/images/book.png",
                          fit: BoxFit.fill,
                          color: Colors.grey,
                        ),
                      );
                    case LoadState.failed:
                      return Image.asset(
                        "assets/images/book.png",
                        fit: BoxFit.fill,
                        color: Colors.grey[350],
                      );
                    default:
                      return state.completedWidget;
                  }
                },
                borderRadius:
                const BorderRadius.all(Radius.circular(30.0)),
                //cancelToken: cancellationToken,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomText(
              text: model.title.toString(),
              maxLines: 1,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomText(
              text: "\$${model.price.toString()}",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context.read<CartBloc>().add(AddItem(
                          model: CartModel(
                              name: model.title.toString(),
                              id: model.id.toString(),
                              price: model.price.toString(),
                              image: model.coverImage.toString(),
                              quantity: 1)));
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: FrontendConfigs.kPrimaryColor),
                      child: Center(
                        child: CustomText(
                          text: 'Buy Now',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookDetailsView(model: model)));
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: FrontendConfigs.kPrimaryColor),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward,
                        size: 23,
                        color: FrontendConfigs.kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
