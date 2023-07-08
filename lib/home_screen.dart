import 'package:flutter/material.dart';
import 'package:flutter_shop/shop_screen.dart';
import 'package:flutter_shop/account_screen.dart';
import 'package:flutter_shop/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
//
class _HomeScreenState extends State<HomeScreen> {
  // PAR DÉFAULT ON SOUFAITE QUE L'UTILISATEUR ARRIVE SUR LA PAGE 0 DONC LE ACCOUNT SCREEN
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    // SWITCH QUI PERMET DE CHANGER DE PAGE DANS LE MENU
    switch (selectedIndex) {
      case 0:
        page = AccountScreen();
        break;
      case 1:
        page = ShopScreen();
        break;
      case 2:
        page = CartScreen();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body: Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 1200,
                    destinations: [
                      // CHOIX L'ICONE + DU NOM ASSOCIÉ À L'ELÉMENT DU MENU
                      // ON FAIT LA MÊME CHOSE POUR CHAQUE "NavigationRailDestination"
                      NavigationRailDestination(
                        icon: Icon(Icons.account_circle),
                        label: Text('Account'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.shopping_basket),
                        label: Text('Cart'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: page,
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}