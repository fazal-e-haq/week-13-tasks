import 'package:flutter/material.dart';
import 'package:optimized_provider_app/Models/product_model.dart';
import 'package:optimized_provider_app/Providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProductTileWidget extends StatelessWidget {
  const ProductTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
// Widgets that only change on screen
    return Consumer2<ProductModel, UserProvider>(
      builder: (_, product, user, _) {
        return ListTile(
          title: Text(product.name),
          subtitle: Text(user.name),
          trailing: IconButton(
            onPressed: product.toggleFavorite,
            icon: product.favorite
                ? Icon(Icons.favorite, color: Colors.red)
                : Icon(Icons.favorite_border),
          ),
        );
      },
    );
  }
}
