import 'package:flutter/material.dart';
import 'package:laravel_instagram/screens/loading.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Loading(),
      
    );
  }
}