import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import 'SneakersHomePage.dart';
import 'bloc/Navigation_Bloc/navigation_bloc.dart';

import 'bloc/Navigation_Bloc/navigation_event.dart';
import 'bloc/Navigation_Bloc/navigation_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Roboto",
        appBarTheme: Theme.of(
          context,
        ).appBarTheme.copyWith(systemOverlayStyle: SystemUiOverlayStyle.dark),
      ),
      home: BlocProvider(
        create: (_) => NavigationBloc(),
        child: const SneakersListScreen(),
      ),
    );
  }
}

class SneakersListScreen extends StatelessWidget {
  const SneakersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const SneakersHomePage(),
      const CategoriesPage(),
      const ProductScreen(),
      const FavoritesPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is NavigationUpdated) {
            return pages[state.selectedIndex];
          }
          return pages[0]; // Default to the first page
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          final selectedIndex = state is NavigationUpdated
              ? state.selectedIndex
              : 0;
          return BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.pink,
            unselectedItemColor: Colors.white70,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: selectedIndex,
            onTap: (index) =>
                context.read<NavigationBloc>().add(UpdateNavigation(index)),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.category_2),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.menu_1),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.shopping_bag),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.heart),
                label: "Favorites",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.user),
                label: "Profile",
              ),
            ],
          );
        },
      ),
    );
  }
}
