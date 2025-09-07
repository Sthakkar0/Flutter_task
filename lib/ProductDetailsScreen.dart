import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api_helper.dart';
import 'bloc/Product_detail_Bloc/product_detail_bloc.dart';
import 'bloc/Product_detail_Bloc/product_detail_event.dart';
import 'bloc/Product_detail_Bloc/product_detail_state.dart';
import 'repository/product_repository.dart';

import 'custom_widget/expandableText.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductDetailBloc productDetailBloc;
  int selectedSize = 28;

  @override
  void initState() {
    super.initState();
    print("this is project");
    productDetailBloc = ProductDetailBloc(ProductRepository(ApiHelper()));
    productDetailBloc.add(FetchProductDetailEvent(widget.productId));
  }

  @override
  void dispose() {
    productDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light, // Android
        statusBarBrightness: Brightness.dark, // iOS
      ),
      child: Scaffold(
        body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          bloc: productDetailBloc,
          builder: (context, state) {
            if (state is ProductDetailLoadingState) {
              return const Center(child: CircularProgressIndicator(color: Colors.black,));
            } else if (state is ProductDetailLoadedState) {
              final productDetails = state.product;

              return SingleChildScrollView(
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: -50,
                              right: -50,
                              top: -50,
                              child: SvgPicture.asset(
                                "assets/svg/circle.svg",
                                height: 220,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    icon: Icon(
                                      Icons.arrow_back_ios_new,
                                      color:
                                          Colors.white, // ✅ white for contrast
                                    ),
                                  ),
                                  const Icon(
                                    Icons.favorite_border,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 16,
                              right: 16,
                              child: Center(
                                child: Image.network(
                                  productDetails.image??"",
                                  height: 300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              productDetails.title ?? '',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text((productDetails.category??"").toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(
                                  "\$${(productDetails.price as num?)?.toStringAsFixed(2) ?? '0.00'}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),

                            ExpandableTextWidget(
                              text: productDetails.description ?? '',
                            ),
                            Divider(),
                            const Text(
                              "Size",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(

                                children: [
                                  for (int size = 28; size <= 50; size++)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedSize = size;
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: selectedSize == size
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          size.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: selectedSize == size
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.black,
                                ), // Button background color
                                foregroundColor: WidgetStateProperty.all(
                                  Colors.white,
                                ), // Text color
                                fixedSize: WidgetStateProperty.all(
                                  Size(double.infinity, 50),
                                ), // Full width, height 50
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ), // Rounded corners
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ), // Border color and width
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Add To Cart",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),


                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ProductDetailErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Unexpected state'));
            }
          },
        ),
      ),
    );
  }
}
