import 'dart:convert';

import 'package:dayone_loginpage/main.dart';
import 'package:dayone_loginpage/model/grocery_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int addIconPress = -1;
  List<Product>? products;

  bool isLoading = true;

  Future<void> fetchProducts() async {
    try {
      final response = await http
          .get(Uri.parse('https://dummyjson.com/products/category/groceries'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final productList = jsonData['products'] as List;
        setState(() {
          products =
              productList.map((product) => Product.fromJson(product)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error fetching products: $error');
      setState(() {
        isLoading = false;
      });
    }
  }
  int selectedProductIndex = -1;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        title: const Text(
          'Deals of the Week',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : products == null
              ? const Center(child: Text('Failed to load products'))
              :

              Column(
                  children: [
                    Container(
                      height: mq.height * 0.05,
                      color: Colors.white,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: mq.width * 0.03),
                        child: Row(
                          children: [
                            Text('Total Items: ${products!.length}'),
                            const Spacer(),
                            const Icon(Icons.arrow_upward_outlined),
                            const Icon(Icons.arrow_downward_outlined),
                            const Icon(Icons.density_medium_rounded)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mq.height * 0.008,
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount:
                            products!.length, // Number of items in the grid

                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250 // Number of columns in the grid
                            ),
                        itemBuilder: (BuildContext context, int index) {
                          final productTitle = products![index].title;
                          final quantityPattern = RegExp(
                              r'(\d+(\.\d+)?)(\s+)?(kg|grams|gm|Gram)?',
                              caseSensitive: false);
                          final match =
                              quantityPattern.firstMatch(productTitle);

                          String productName = productTitle;
                          String productQuantity = '';

                          if (match != null) {
                            productName = productTitle
                                .replaceFirst(match.group(0)!, '')
                                .trim();
                            productQuantity = match.group(0)!;
                            productQuantity = productQuantity.length > 4 ? productQuantity.substring(0, 6) : productQuantity;
                          }
                          
                          return InkWell(
                            onTap: () {
                              setState(() {
                  selectedProductIndex = index; // Update selected index on tap
                });
                            },
                            child: Card(
                              elevation: 4.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 16,
                                          width: 16,
                                          margin: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                   color: index == selectedProductIndex ? Colors.red : Colors.green,)),
                                          child: Center(
                                            child: Container(
                                              width: 8.0,
                                              height: 8.0,
                                              decoration:  BoxDecoration(
                                                 color: index == selectedProductIndex ? Colors.red : Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width:mq.width * 0.02),
                                        SizedBox(
                                            height: mq.height * 0.08,
                                            width: mq.width * 0.2,
                                            child: Image.network(
                                                products![index].thumbnail)),
                                                const Spacer(),
                                        Text(
                                          productQuantity,
                                          style:
                                              const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                              height: mq.height * 0.008,
                                            ),
                                    Text(
                                      productName,
                                      overflow: TextOverflow
                                          .ellipsis, // Display ellipsis if text overflows
                                      maxLines: 1,
                                      style: const TextStyle(fontSize: 15.0),
                                    ),
                                    Text(
                                      products![index].brand,
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: mq.height * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('Rs',style: TextStyle(color: Colors.grey),),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          products![index].discountPercentage.toStringAsFixed(2),
                                          style: const TextStyle(color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            '\$${products![index].price.toStringAsFixed(2)}'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mq.height * 0.01,
                                    ),
                                    addIconPress !=index ?
                                    
                                         InkWell(
                                          onTap: () {
                                            setState(() {
                                              addIconPress =index;
                                              selectedProductIndex = index;
                                            });
                                          },
                                          child: Container(
                                              width: mq.width * 0.2,
                                              height: mq.height * 0.04,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                  Text(
                                                    'ADD',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                            ),
                                        )
                                        : const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '1',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Icon(
                                                Icons.add_circle,
                                                color: Colors.red,
                                              )
                                            ],
                                          ),
                                    SizedBox(
                                      height: mq.height * 0.01,
                                    ),
                                    const Text(
                                      'Express Deliver',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    const Text(
                                      '(Tomorrow mornong)',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
