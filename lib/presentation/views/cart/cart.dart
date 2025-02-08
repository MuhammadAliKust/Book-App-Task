import 'package:book_app/application/cart_bloc/cart_bloc.dart';
import 'package:book_app/infrastructure/models/cart.dart';
import 'package:book_app/presentation/elements/cart_card.dart';
import 'package:book_app/presentation/elements/custom_appbar.dart';
import 'package:book_app/presentation/elements/processing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../configs/frontend.dart';
import '../../../injection_container.dart';
import '../../elements/app_button.dart';
import '../../elements/custom_text.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<CartModel> cartList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, text: 'Cart', showText: true),

      body: BlocProvider(
        create: (context) => sl<CartBloc>(),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartInitial ||
                state is CartLoading ||
                state is CartUpdated) {
              BlocProvider.of<CartBloc>(context).add(GetCartList());
            } else if (state is CartLoaded) {
              cartList = state.cartList;
            } else if (state is CartFailed) {
              return Center(
                child: Text(state.message.toString()),
              );
            }

            return Column(
              children: [
                FrontendConfigs.appDivider,
                Expanded(
                  child: ListView.builder(
                      itemCount: cartList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return CartCard(
                          model: cartList[i],
                          onIncrement: () {
                            context.read<CartBloc>().add(
                                IncrementQuantity(cartList[i].id.toString()));
                          },
                          onDecrement: () {
                            context.read<CartBloc>().add(
                                DecrementQuantity(cartList[i].id.toString()));
                          },
                        );
                      }),
                ),
                FrontendConfigs.appDivider,
                Column(
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Total",
                                fontSize: 12,
                                color: FrontendConfigs.kAuthTextColor,
                              ),
                              CustomText(
                                text:
                                    "${BlocProvider.of<CartBloc>(context).getSubTotal().toStringAsFixed(2)} Rs",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          AppButton(
                            onPressed: () {},
                            btnLabel: "Buy Now",
                            btnColor: FrontendConfigs.kPrimaryColor,
                            height: 38,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
