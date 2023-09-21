import 'package:flutter/material.dart';
import 'package:icthub_2/data/models/product_model.dart';

class ProductScreen extends StatelessWidget {
  final ProductData datax;
  const ProductScreen({super.key, required this.datax});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
              datax.image,
              height: 400,
              width: double.infinity,
      ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            datax.name,
            textAlign: TextAlign.center,
            style:  const TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            datax.brand,
            textAlign: TextAlign.center,
            style:  const TextStyle(
              fontSize: 18,

            ),
          ),
          Text(
            datax.detail,
            textAlign: TextAlign.center,
            style:  const TextStyle(
              fontSize: 13,
              color: Colors.purple,
            ),
          ),

          Text(
            'Price:${datax.price.toString()} \$',
            textAlign: TextAlign.center,
            style:  const TextStyle(
              fontSize: 18,
            ),
          ),

        ],
      ),

    );
  }
}
