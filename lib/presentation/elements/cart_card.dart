import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shimmer/shimmer.dart';

import '../../configs/frontend.dart';
import '../../infrastructure/models/cart.dart';
import 'custom_text.dart';

class CartCard extends StatefulWidget {
  final CartModel model;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartCard(
      {super.key,
      required this.model,
      required this.onIncrement,
      required this.onDecrement});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 3),
      child: Slidable(
        key: ValueKey(widget.model.hashCode),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            InkWell(
              onTap: () {
                // cart.removeItem(widget.model.productDetails.id.toString());
              },
              child: Container(
                height: 92,
                width: 187,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: FrontendConfigs.kPrimaryColor,
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          FrontendConfigs.kPrimaryColor.withOpacity(0.6),
                          FrontendConfigs.kPrimaryColor,
                        ])),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      CustomText(
                        text: "Delete",
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: FrontendConfigs.kTextFieldColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ExtendedImage.network(
                          widget.model.image.toString(),
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
                      width: 8,
                    ),
                    SizedBox(
                      width: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          CustomText(
                              text: widget.model.name.toString().length > 15
                                  ? "${widget.model.name.toString().substring(0, 15)}..."
                                  : widget.model.name.toString()),
                          const SizedBox(
                            height: 2,
                          ),
                          CustomText(
                            text: "x ${widget.model.quantity.toString()}",
                            fontSize: 12,
                            color: FrontendConfigs.kAuthTextColor,
                          ),
                          CustomText(
                              text:
                                  "${(widget.model.quantity * num.parse(widget.model.price)).toStringAsFixed(2)} Rs",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ],
                      ),
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              borderRadius: FrontendConfigs.kAppBorder,
                              onTap: () => widget.onDecrement(),
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: FrontendConfigs.kAppBorder,
                                    color: widget.model.quantity == 1
                                        ? FrontendConfigs.kTextFieldColor
                                        : Colors.grey),
                                child: Icon(
                                    widget.model.quantity <= 1
                                        ? Icons.delete
                                        : Icons.remove,
                                    color: widget.model.quantity <= 1
                                        ? Colors.red
                                        : Colors.white),
                              ),
                            ),
                            CustomText(
                              text: widget.model.quantity.toString(),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                              borderRadius: FrontendConfigs.kAppBorder,
                              onTap: () => widget.onIncrement(),
                              // onTap: () async {
                              //   // if (widget.model.quantity >=
                              //   //     widget.model.productDetails.stock!) {
                              //   //   getFlushBar(context,
                              //   //       title:
                              //   //           "Sorry! You cannot order more than ${widget.model.productDetails.stock.toString()} items.");
                              //   // } else {
                              //   //   cart.increment(
                              //   //       widget.model.productDetails.id.toString(),
                              //   //       1);
                              //   // }
                              // },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: FrontendConfigs.kAppBorder,
                                    color: FrontendConfigs.kPrimaryColor),
                                child:
                                    const Icon(Icons.add, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
