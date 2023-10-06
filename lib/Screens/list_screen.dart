
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icthub_2/Screens/Login_Screen.dart';
import 'package:icthub_2/Screens/product_screens.dart';

import '../data/data_source/Product-data_source.dart';

class ListScreen extends StatefulWidget {
  ListScreen({super.key});

  @override

  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {



  @override
  void initState() {
    super.initState();
    if(DataSource.myList.isEmpty){
      Future.delayed(
        Duration.zero,
            () async {
          var data = await DataSource;
          setState(() {
            DataSource.myList = data;
            isLoading = false;
          });
        },
      );
    }

  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('New Products'),
        leading: InkWell(
          onTap: ()async{
            await FirebaseAuth.instance.signOut().whenComplete(() => Navigator.pushReplacement(context,
              MaterialPageRoute(builder:  (context) => const LoginScreen(),))
            );
          },
          child: const Icon(
            Icons.logout_rounded,
          ),
        ),
        actions: [
          IconButton(onPressed: (){},
              icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SafeArea(
        child: GridView.builder(
          itemCount: DataSource.myList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        ProductScreen(
                          datax: DataSource.myList[index],
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
                          DataSource.myList[index].image,
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
                            DataSource.myList[index].name,
                          ),
                        ),
                        Text(
                          DataSource.myList[index].brand,
                        ),
                        Text(
                          '${DataSource.myList[index].price.toString()}\$',
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
