import 'package:flutter/foundation.dart';
import 'package:flutter_shop/shop_screen.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}
// Mé
class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;
  // FONCTION QUI VA PERMETTRE DE TROUVER LE PRIS TOTAL EN VENANT MULTIPLIER LE PRIX
  // DU PRODUIT PAR LA QUANTITÉ 
  double get totalPrice {
    double total = 0;
    for (var cartItem in _cartItems) {
      total += cartItem.product.price * cartItem.quantity;
    }
    return total;
  }
// MÉTHODE PERMETTANT D'AJOUTER UN PRODUIT DE PLUS DANS LE PANIER
  void addToCart(Product product) {
    final existingCartItemIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    // SI ON EST SUPÉRIEUR À 0 ALORS ON AJOUTE UNE QUANTIÉ AU PRODUIT
    // SINON ON AJOUTE LE PRODUIT AU PANIER
    if (existingCartItemIndex >= 0) {
      _cartItems[existingCartItemIndex].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }

    notifyListeners();
  }
// MÉTHODE PERMETTANT DE SUPPRIMER UN PRODUIT DE MOINS DANS LE PANIER
  void removeFromCart(Product product) {
    final existingCartItemIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );
    // SI ON EST SUPÉRIEUR À 0 ALORS ON SUPPRIME UNE QUANTIÉ AU PRODUIT
    // SINON ON SUPPRIME LE PRODUIT ENTIÈREMENT DU PANIER
    if (existingCartItemIndex >= 0) {
      if (_cartItems[existingCartItemIndex].quantity > 1) {
        _cartItems[existingCartItemIndex].quantity--;
      } else {
        _cartItems.removeAt(existingCartItemIndex);
      }
    }

    notifyListeners();
  }
}
