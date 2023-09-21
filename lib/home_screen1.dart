import 'package:flutter/material.dart';
import 'package:icthub_2/screen_2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'counter :$counter',
              style: const TextStyle(fontSize: 25, color: Colors.green),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  counter++;
                });
              },
              child: Container(
                width: double.infinity,
                height: 100,
                color: Colors.deepPurple,
                alignment: Alignment.center,
                child: const Text(
                  'add',
                ),
              ),
            ),
            ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const screen2(),
                        ),
                    );
                  },
                child:const Text(
                  'click here',
                ),
            )
          ],
        ),
      ),
    );
  }
}

