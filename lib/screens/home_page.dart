import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text("Name:"),
                      Text("Person's Name"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.timer),
                          Text('8 days'),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.monetization_on_outlined),
                        ],
                      ),
                      Text('8 days'),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
