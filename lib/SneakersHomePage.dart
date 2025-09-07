import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'ProductDetailsScreen.dart';
import 'bloc/Product_Bloc/product_bloc.dart';
import 'bloc/Product_Bloc/product_event.dart';
import 'bloc/Product_Bloc/product_state.dart';
import 'model/productModel.dart';
import 'repository/product_repository.dart';
import 'api_helper.dart';

class SneakersHomePage extends StatelessWidget {
  const SneakersHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productRepository = ProductRepository(ApiHelper());
    return BlocProvider(
      create: (context) =>
          ProductBloc(productRepository)..add(FetchProductsEvent()),
      child: Scaffold(
        backgroundColor: Color(0xfff2f2ef),
        appBar: AppBar(
          backgroundColor: Color(0xfff2f2ef),
          elevation: 0,
          leading: const Icon(Icons.menu, color: Colors.black),
          title: TextField(
            decoration: InputDecoration(
              hintText: "Search product",
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Sneakers",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                  Wrap(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Iconsax.sort, size: 25),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.filter_alt_outlined, size: 25),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return Expanded(
                      child: GridView.builder(
                        itemCount: 6,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.75,
                            ),
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is ProductLoadedState) {
                    return Expanded(
                      child: GridView.builder(
                        itemCount: state.products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.75,
                            ),
                        itemBuilder: (context, index) {
                          final ProductModel product = state.products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailScreen(productId: product.id!,),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 25),
                                      Expanded(
                                        child: Center(
                                          child: Image.network(
                                            product.image ?? "",
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 8),
                                      Text(
                                        product.title ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        product.description ?? "",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$${product.price ?? " "}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Wrap(crossAxisAlignment: WrapCrossAlignment.end,
                                            children: [
                                              Icon(Icons.star,color: Colors.yellow,size: 20,),
                                              Text(product.rating?.rate.toString()??"")
                                            ],
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: -10,
                                    top: -5,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: const Icon(Icons.favorite_border),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is ProductErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text("No products available"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("📂 Categories Page"));
  }
}

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("🛒 Product Page"));
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("❤️ Favorites Page"));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("👤 Profile Page"));
  }
}
