import 'package:flutter/material.dart';
import 'package:optimized_provider_app/Models/product_model.dart';
import 'package:optimized_provider_app/Providers/product_provider.dart';
import 'package:optimized_provider_app/Providers/user_provider.dart';
import 'package:optimized_provider_app/Widgets/product_tile_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController controller = ScrollController();

  // Add items in list when app start
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductProvider>().loadProduct();
    });
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        context.read<ProductProvider>().loadProduct();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = context.select<ProductProvider, List<ProductModel>>(
      (value) => value.products,
    );
    final loading = context.select<ProductProvider, bool>(
      (value) => value.loading,
    );

    return Scaffold(
      // Show User name
      appBar: AppBar(
        title: Selector<UserProvider, String>(
          selector: (_, provider) => provider.name,
          builder: (_, name, _) {
            return Text(name);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 16),

          // List of items
          child: ListView.builder(
            controller: controller,
            itemCount: products.length + 1,

            itemBuilder: (context, index) {
              if (index == products.length) {
                return loading
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox();
              }
              return ChangeNotifierProvider.value(
                value: products[index],
                child: const ProductTileWidget(),
              );
            },
          ),
        ),
      ),
    );
  }
}
