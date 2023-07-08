import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/card_provider.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Product {
  final int id;
  final String title;
  final String category;
  final String description;
  final int price;
  final double rating;
  final String thumbnail;

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.price,
    required this.rating,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      description: json['description'],
      price: json['price'],
      rating: json['rating'].toDouble(),
      thumbnail: json['thumbnail'],
    );
  }

}


class ShopScreen extends StatefulWidget  {

  @override
  State<ShopScreen> createState() => _ShopScreenState();

}

class _ShopScreenState extends State<ShopScreen> {


  Future<List<Product>> fetchProduct() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      List<Product> products = (body['products'] as List<dynamic>).map((jsonProduct) => Product.fromJson(jsonProduct)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  late Future<List<Product>> futureProduct;

  @override
  void initState() {
    super.initState();
    futureProduct = fetchProduct();
  }
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              FutureBuilder<List<Product>>(
                future: futureProduct,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Product> products = snapshot.data!;
                    return Wrap(
                      alignment: WrapAlignment.spaceAround,
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: products.map((product) {
                        return Container(
                          width: 400,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 400,
                                  height: 400,
                                  child: Image.network(
                                    product.thumbnail,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    product.category,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    product.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star_half, color: Colors.yellow),
                                    SizedBox(width: 5),
                                    Text(
                                      '${product.rating}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    product.description,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Prix : \$${product.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Provider.of<CartProvider>(context, listen: false)
                                              .addToCart(product);
                                        },
                                        child: Icon(Icons.shopping_cart),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
