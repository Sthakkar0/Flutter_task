import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_insomniacs/bloc/Product_detail_Bloc/product_detail_event.dart';
import '../../repository/product_repository.dart';

import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository productRepository;

  ProductDetailBloc(this.productRepository)
    : super(ProductDetailInitialState()) {
    on<FetchProductDetailEvent>((event, emit) async {
      emit(ProductDetailLoadingState());
      try {
        final product = await productRepository.fetchProductDetails(
          event.productId,
        );
        emit(ProductDetailLoadedState(product));
      } catch (e) {
        emit(ProductDetailErrorState(e.toString()));
      }
    });
  }
}
