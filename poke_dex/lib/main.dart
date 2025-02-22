
import 'package:flutter/material.dart';
import 'package:poke_dex/pages/Splash_page.dart';

void main() {
 runApp(MyApp());
}


class MyApp extends StatelessWidget{

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title:'Pokedex',
     debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashPage(),
    );
  }
  
}
