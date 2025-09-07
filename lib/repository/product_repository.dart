import 'package:flutter_task_insomniacs/model/itemModel.dart';
import 'package:flutter_task_insomniacs/model/productModel.dart';

import '../api_helper.dart';

class ProductRepository {
  final ApiHelper apiHelper;

  ProductRepository(this.apiHelper);

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await apiHelper.get('/products');
      return (response as List<dynamic>)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<ItemModel> fetchProductDetails(int productId) async {
    final response = await apiHelper.get('/products/$productId');

    return ItemModel.fromJson(response); // Convert to ItemModel
  }
}
