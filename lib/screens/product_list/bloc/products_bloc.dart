import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/product_response.dart';
import '../data/product_list_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductListRepository _productListRepository;

  ProductsBloc({
    required ProductListRepository productListRepository,
  })  : _productListRepository = productListRepository,
        super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) {});

    on<ProductListEvent>((event, emit) => getProducts(event, emit));
  }

  getProducts(ProductListEvent event, emit) async {
    emit(ProductsListStateBusy(true));
    final result = await _productListRepository.getProductList();
    result.when(success: (List<ProductsResponse?>? productsResponse) {
      emit(ProductsListStateBusy(true));
      emit(ProductsListStateSuccess(productsResponse));
    }, failure: (failure) {
      emit(ProductsListStateBusy(true));
      emit(ProductsListStateFailure(failure.toString()));
    });
  }
}
