
abstract class ProductDetailState {}

class ProductDetailInitialState extends ProductDetailState {}

class ProductDetailLoadingState extends ProductDetailState {}

class ProductDetailLoadedState extends ProductDetailState {
  final dynamic product;

  ProductDetailLoadedState(this.product);
}

class ProductDetailErrorState extends ProductDetailState {
  final String message;

  ProductDetailErrorState(this.message);
}
