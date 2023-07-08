import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phone;
  final String postalCode;
  final String city;
  final String address;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
    required this.postalCode,
    required this.city,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'].toString(),
      postalCode: json["address"]['postalCode'].toString(),
      address: json['address']["address"].toString(),
      city: json["address"]['city'].toString(),
    );
  }
}


class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late Future<User> futureUser;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }
 // ON VIENT FAIRE UN APPEL À L'API DUMMYJSON/USER
  Future<User> fetchUser() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/user'));

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      List<dynamic> users = body['users'];

      if (users.isNotEmpty) {
        Map<String, dynamic> userData = users[0];
        return User.fromJson(userData);
      } else {
        throw Exception('No users found');
      }
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data!;

            // Mise à jour des contrôleurs de champs de texte avec les données de l'utilisateur
            nameController.text = user.lastName;
            firstNameController.text = user.firstName;
            usernameController.text = user.username;
            emailController.text = user.email;
            phoneController.text = user.phone.toString();
            postalCodeController.text = user.postalCode.toString();
            cityController.text = user.city.toString();
            addressController.text = user.address.toString();

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Contenu qui sera visible sur le fornt de l'application 
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        // Appel de d'une image prise sur internet
                        child: Image.network(
                          'https://i.dummyjson.com/data/products/2/3.jpg',
                          scale: 2,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(
                              'Mon compte',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Nom',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16, height: 3),
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            TextField(
                              controller: firstNameController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Prénom',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16, height: 3),
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Pseudo',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16, height: 3),
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Téléphone',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16, height: 3),
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Email',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16, height: 3),
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: addressController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Adresse',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16, height: 3),
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            TextField(
                              controller: postalCodeController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Code Postal',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16, height: 3),
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            TextField(
                              controller: cityController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Ville',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16, height: 3),
                                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
