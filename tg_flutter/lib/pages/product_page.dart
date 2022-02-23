import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Product {
  final String id;
  final String name;
  final String imgURL;

  Product({
    required this.id,
    required this.name,
    required this.imgURL,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['res']['id'] as String,
      name: json['res']['name'] as String,
      imgURL: json['res']['imageURLs'] as String,
    );
  }
}

class Recommendation {
  final String id;
  final String name;
  final double avgRating;
  final int numRating;

  Recommendation(
      {required this.id,
      required this.name,
      required this.avgRating,
      required this.numRating});

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
        id: json['id'],
        name: json['name'],
        avgRating: json['average rating'],
        numRating: json['num rating']);
  }
  @override
  String toString() {
    return '''
    Recommended ID: ${id} 
    Product Name: ${name} 
    Average Rating: ${avgRating} 
    Number Rating: ${numRating}
    ''';
  }
}

class ProductPage extends StatefulWidget {
  ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController productController = TextEditingController();
  TextEditingController recommendationController = TextEditingController();

  String product = "";
  String recommendedUser = "";

  String _productName = "";
  String _productImgUrl = "";
  String _recommendationName = "";

  String _recommendedProducts = "";

  String _productString = "Your product will appear here if it exists! ";

  bool isVisible = false;

  Future<Product> _productExists() async {
    final url = 'http://127.0.0.1:8000/productExists?product=$product';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<List<Recommendation>> _fetchRecommendations() async {
    final url = 'http://127.0.0.1:8000/recommender?user=$recommendedUser';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)['children'] as List;
      return jsonResponse
          .map((recommendation) => Recommendation.fromJson(recommendation))
          .toList();
    } else {
      throw Exception('Failed to load recommendation');
    }
  }

// create list of the images you want to include
  Future _getImage(BuildContext context, String imageName) async {
    String? downloadURL;
    downloadURL =
        await FirebaseStorage.instance.ref().child(imageName).getDownloadURL();

    return downloadURL;
  }

  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Product Page")),
        // Include in setup - adding to the User page
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(children: [
              // Include in setup -- UserExists Query
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 50),
                  child: const Text(
                    'Product Search',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding:
                    EdgeInsets.only(top: 0, left: 150, right: 150, bottom: 10),
                child: TextField(
                  controller: productController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product ID',
                  ),
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                      top: 0, left: 150, right: 150, bottom: 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.orange,
                    child: const Text('Search'),
                    onPressed: () {
                      setState(() {
                        product = productController.text;
                      });

                      _productExists().then((result) {
                        // ignore: unnecessary_null_comparison
                        if (result.id != null) {
                          setState(() {
                            _productString = productController.text;
                            _productName = (result.name);
                            _productImgUrl = (result.imgURL);

                            _getImage(
                                context, "test/" + _productString + ".jpeg");
                            print(_productString + ".jpeg");
                            isButtonPressed = true;
                          });
                        } else {
                          setState(() {
                            isVisible = true;
                            _productName = "This product does not exist!";
                          });
                        }
                      });
                    },
                  )),
              if (isButtonPressed)
                FutureBuilder(
                    future:
                        _getImage(context, "test/" + _productString + ".jpeg"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text(
                          "Something went wrong",
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Image.network(
                          snapshot.data.toString(),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              Container(
                  padding: const EdgeInsets.only(
                      top: 0, left: 150, right: 150, bottom: 10),
                  child: Column(children: [
                    Text(
                      "Product Name: " + _productName,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ])
                  //

                  ),

              // Recommended Product

              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 50),
                  child: const Text(
                    'Enter User ID to Get Product Recommendations',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding:
                    EdgeInsets.only(top: 0, left: 150, right: 150, bottom: 10),
                child: TextField(
                  controller: recommendationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User ID',
                  ),
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                      top: 0, left: 150, right: 150, bottom: 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.orange,
                    child: const Text('Search'),
                    onPressed: () {
                      setState(() {
                        recommendedUser = recommendationController.text;
                      });

                      _fetchRecommendations().then((result) {
                        // ignore: unnecessary_null_comparison
                        if (result != null) {
                          setState(() {
                            _recommendationName = recommendationController.text;
                            _recommendedProducts =
                                result.join((", ")).replaceAll(",", "");
                          });
                        } else {
                          setState(() {
                            isVisible = true;
                            _recommendationName =
                                "The user you searched does not exist! Oops!";
                          });
                        }
                      });
                    },
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      top: 0, left: 150, right: 150, bottom: 10),
                  child: Column(children: [
                    Text(
                      "User Name: " + _recommendationName,
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(
                      _recommendedProducts.toString(),
                      style: const TextStyle(fontSize: 30),
                    ),
                  ])),
            ])));
  }
}
