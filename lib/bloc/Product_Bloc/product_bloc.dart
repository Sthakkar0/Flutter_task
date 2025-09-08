import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_insomniacs/repository/product_repository.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductInitialState()) {
    on<FetchProductsEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final products = await productRepository.fetchProducts();
        emit(ProductLoadedState(products));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });
  }
}
