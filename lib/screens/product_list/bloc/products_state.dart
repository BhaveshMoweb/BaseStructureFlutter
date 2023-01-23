part of 'products_bloc.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsListStateBusy extends ProductsState {
  final bool isBusy;

  ProductsListStateBusy(this.isBusy);
}

class ProductsListStateFailure extends ProductsState {
  final String error;

  ProductsListStateFailure(this.error);
}

class ProductsListStateSuccess extends ProductsState {
  final List<ProductsResponse?>? productsResponse;

  ProductsListStateSuccess(this.productsResponse);
}
