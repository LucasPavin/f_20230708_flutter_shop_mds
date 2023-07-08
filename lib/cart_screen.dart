import 'package:flutter/material.dart';
import 'package:flutter_shop/shop_screen.dart';
import 'package:flutter_shop/card_provider.dart';
import 'package:provider/provider.dart';

// Écran permettant l'affiche du prix
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    // Si le panier est vide on renvoie le texte suivant
    if (cartProvider.cartItems.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }
    // On initialise le prix du panier à 0 par défaut
    double totalPrice = 0;

    return ListView(
      children: [
        // Rappele du nombres de produits dans le panier
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have ${cartProvider.cartItems.length} product(s) in your shopping cart'),
        ),
        for (var cartItem in cartProvider.cartItems)

          // Liste permettant de récupérer les informations du produits
          ListTile(
            leading: Image.network(cartItem.product.thumbnail),
            title: Text(cartItem.product.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price: \$${cartItem.product.price.toStringAsFixed(2)}'),
                Text('Quantity: ${cartItem.quantity}'),
                Text('Total: \$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}'),
              ],
            ),
            // Bouton qui va permettre d'appeler la fonction du carte_provider.dart 
            // Permettant donc de supprimer ou bien ajouter un produit de moins ou de plus
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.do_not_disturb_on),
                  onPressed: () {
                    cartProvider.removeFromCart(cartItem.product);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    cartProvider.addToCart(cartItem.product);
                  },
                ),
              ],
            ),
          ),
        // On va venir afficher le prix totals du panier
        Container(
          padding: const EdgeInsets.all(20),
          color: Colors.grey.shade300,
          child: Text('Total Price: \$${cartProvider.totalPrice.toStringAsFixed(2)}'),
        ),
      ],
    );
  }
}
