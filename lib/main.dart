import 'package:flutter/material.dart';

import 'widgets/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Epoch Readable',
      // theme: ThemeData(
      //   primarySwatch: Colors.green,
      // ),
      home: MyHomePage(title: 'Epoch Readable'),
    );
  }
}
