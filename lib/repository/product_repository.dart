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

  Future<dynamic> fetchProductDetail(int productId) async {
    try {
      final response = await apiHelper.get('/products/$productId');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }
}
