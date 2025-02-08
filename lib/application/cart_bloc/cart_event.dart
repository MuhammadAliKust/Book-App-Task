part of 'cart_bloc.dart';

@immutable
abstract class CartEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class AddItem extends CartEvents {
  final CartModel model;

  AddItem({required this.model});
}

class GetCartList extends CartEvents {
  GetCartList();
}

class IncrementQuantity extends CartEvents {
  final String productID;

  IncrementQuantity(this.productID);
}

class DecrementQuantity extends CartEvents {
  final String productID;

  DecrementQuantity(this.productID);
}
