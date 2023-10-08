import 'package:flutter/material.dart';
import 'package:icthub_2/data/models/product_model.dart';

class ProductScreen extends StatelessWidget {
  final ProductData dataX;
  const ProductScreen({super.key, required this.dataX});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              child: Image.network(
                fit: BoxFit.fill,
                dataX.image,
                height: 300,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              dataX.detail,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.teal,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Text(
                        dataX.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Price: ${dataX.price.toString()} \$',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('back'),
            ),
          ],
        ),
      ),
    );
  }
}