import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:book_app/infrastructure/models/book.dart';
import 'package:book_app/infrastructure/models/user.dart';
import 'package:book_app/infrastructure/services/book.dart';
import 'package:book_app/infrastructure/services/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../infrastructure/models/cart.dart';
import '../../infrastructure/services/auth.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvents, CartState> {
  SharedPreferences prefs;
  List<CartModel> _cartList = [];

  CartBloc(this.prefs) : super(CartInitial()) {
    on<CartEvents>((event, emit) async {
      emit(CartLoading());

      if (event is AddItem) {
        try {
          addItem(event.model);
          emit(const CartUpdated());
        } catch (e) {
          emit(const CartFailed('An undefined error occurred.'));
        }
      } else if (event is GetCartList) {
        try {
         getCartItems();
          emit(CartLoaded(getCartItems()));
        } catch (e) {
          emit(const CartFailed('An undefined error occurred.'));
        }
      } else if (event is IncrementQuantity) {
        try {
          increment(event.productID, 1);

          emit(const CartUpdated());
        } catch (e) {
          emit(const CartFailed('An undefined error occurred.'));
        }
      } else if (event is DecrementQuantity) {
        try {
          decrement(event.productID);

          emit(const CartUpdated());
        } catch (e) {
          emit(const CartFailed('An undefined error occurred.'));
        }
      }
    });
  }

  void getListFromStorage() {
    _cartList = cartModelFromJson(prefs.getString('CART_DATA'));
  }

  void addItem(CartModel model) async {
    _cartList = getCartItems();
    bool flag = false;
    _cartList.map((e) {
      if (e.id == model.id) {
        flag = true;
      }
    }).toList();
    if (!flag) {
      _cartList.add(model);
      prefs.setString('CART_DATA', cartModelToJson(_cartList));

      getListFromStorage();
    } else {
      increment(model.id, model.quantity);
    }
  }

  int getItemQuantity(String id) {
    int quantity = 0;
    _cartList.map((e) {
      if (e.id == id) {
        quantity = e.quantity;
      }
    }).toList();

    return quantity;
  }

  void removeItem(String id) async {
    _cartList.removeWhere((e) {
      return e.id == id;
    });
    prefs.setString('CART_DATA', cartModelToJson(_cartList));
  }

  void increment(String id, int quantity) async {
    _cartList.map((e) {
      if (e.id == id) {
        e.quantity += 1;
      }
    }).toList();

    prefs.setString('CART_DATA', cartModelToJson(_cartList));
    getListFromStorage();
  }

  void decrement(String id) async {
    int index = _cartList.indexWhere((e) => e.id == id);
    if (index != -1) {
      if (_cartList[index].quantity == 1) {
        removeItem(id);
      } else {
        _cartList[index].quantity--;
      }
    }

    prefs.setString('CART_DATA', cartModelToJson(_cartList));
    getListFromStorage();
  }

  num getSubTotal() {
    num total = 0;
    _cartList.map((e) {
      total += num.parse(e.price.toString().trim()) * e.quantity;
    }).toList();
    return total;
  }

  List<CartModel> getCartItems() {
    _cartList = cartModelFromJson(prefs.getString('CART_DATA'));
    log(_cartList.length.toString());
    return _cartList;
  }

  void emptyCart() {
    _cartList.clear();
  }
}
