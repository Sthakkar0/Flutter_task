import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/productModel.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../../repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductInitialState()) {
    on<FetchProductsEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        List<ProductModel> products = await productRepository.fetchProducts();
        emit(ProductLoadedState(products));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });
  }
}
