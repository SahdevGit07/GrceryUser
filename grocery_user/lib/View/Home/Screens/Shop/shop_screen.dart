import 'package:flutter/material.dart';
import 'package:grocery_user/Firebase/firebase_services.dart';
import 'package:grocery_user/View/Home/Screens/CategoryProduct/category_product.dart';
import 'package:grocery_user/View/Home/Screens/ShowDetailsProduct/show_details_product.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Model/product.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SearchBar(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    hintText: "Search",
                    leading: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(Icons.search),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 12, bottom: 10),
                  child: Text("Top Categories",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [allCatogoryWithProduct()],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 12),
                  child: Text("Top Selling",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                ),
                topProductItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  allCatogoryWithProduct() {
    return SizedBox(
      height: 100,
      child: StreamBuilder(
        stream: FirebaseServices().getAllCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 6, // Show a fixed number of shimmer placeholders
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor:
                              Colors.grey[300], // Placeholder color
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final alldata = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CategoryProductScreen(categoryId: alldata.id!)),
                      );
                    },
                    child: Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                NetworkImage(snapshot.data![index].imageUrl),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Container(),
            );
          }
        },
      ),
    );
  }

  topProductItem() {
    return StreamBuilder(
        stream: FirebaseServices().getallproduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
              itemCount: 6, // Display 6 shimmer items
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.2),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white70,
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              color: Colors.grey[300], // Shimmer placeholder
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 10,
                              width: 60,
                              color:
                                  Colors.grey[300], // Shimmer text placeholder
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 10,
                              width: 40,
                              color:
                                  Colors.grey[300], // Shimmer price placeholder
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            List<ProductModel> data = snapshot.data!;

            return Container(
              child: GridView.builder(
                controller: ScrollController(keepScrollOffset: false),
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ShowDetailsProduct(productModel: data[index]),
                          ));
                    },
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.2),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white70),
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            data[index].imageUrl))),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("Name : ${data[index].name}"),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("Price : ${data[index].price}")
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
