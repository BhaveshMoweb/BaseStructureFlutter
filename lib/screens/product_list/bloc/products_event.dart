part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class ProductListEvent extends ProductsEvent {
  ProductListEvent();
}
