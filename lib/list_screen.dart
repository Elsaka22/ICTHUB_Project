import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icthub_2/data/models/product_model.dart';
import 'package:icthub_2/product_screens.dart';

class ListScreen extends StatefulWidget {
  ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  Future<List<ProductData>> getData() async {
    List<ProductData> dataA = [];

    try {
      final res = await http.get(Uri.parse('https://dummyjson.com/products'));

      if (res.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(res.body);
        for (var item in responseData['products']) {
          dataA.add(ProductData.fromJson(item));
        }
      }
      return dataA;
    }
    catch (e) {
      print(e);
      return dataA;
    }
  }


  List<ProductData> myList = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
          () async {
        var data = await getData();
        setState(() {
          myList = data;
          isLoading = false;
        });
      },
    );
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('New Products'),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SafeArea(
        child: GridView.builder(
          itemCount: myList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        ProductScreen(
                          datax: myList[index],
                        ),
                    ));
              },
              child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: Image
                            .network(
                          myList[index].image,
                        )
                            .image),
                  ),
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            myList[index].name,
                          ),
                        ),
                        Text(
                          myList[index].brand,
                        ),
                        Text(
                          '${myList[index].price.toString()}\$',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
        ),
      ),
    );
  }
}
