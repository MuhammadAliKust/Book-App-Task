part of 'cart_bloc.dart';

@immutable
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartModel> cartList;

  const CartLoaded(this.cartList);
}

class CartUpdated extends CartState {
  const CartUpdated();
}

class CartFailed extends CartState {
  final String message;

  const CartFailed(this.message);
}
