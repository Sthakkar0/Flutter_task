
import 'package:flutter_task_insomniacs/model/itemModel.dart';

abstract class ProductDetailState {}

class ProductDetailInitialState extends ProductDetailState {}

class ProductDetailLoadingState extends ProductDetailState {}

class ProductDetailLoadedState extends ProductDetailState {
  final ItemModel product;

  ProductDetailLoadedState(this.product);
}

class ProductDetailErrorState extends ProductDetailState {
  final String message;

  ProductDetailErrorState(this.message);
}
