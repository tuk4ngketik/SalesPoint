// ignore_for_file: library_private_types_in_public_api, avoid_print

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
// import 'package:responsive_navigation_bar/responsive_navigation_bar.dart'; 

import '../Cfg/css.dart';  

class Katalog extends StatefulWidget{
  const Katalog({super.key});
  @override
  _Katalog createState() => _Katalog();
  
} 

class _Katalog extends State<Katalog>{
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        // backgroundColor: Colors.black87,
        backgroundColor: Colors.amber,
        toolbarHeight: 200,
        shape: Css.roundBottomAppbar, 
        // title: const Text('Katalog', style: TextStyle(color: Colors.yellow),),
        title: Column(
          children: const [
            // Text('Katalog', style: TextStyle(color: Colors.yellow),),
            Icon(Icons.shopping_bag, color: Colors.white, size: 120,),
            // Text('Katalog', style: TextStyle(color: Color.fromARGB(255, 161, 126, 18)),),
            Text('Katalog', style: TextStyle(color: Colors.white)),
          ],
        ),
        centerTitle: true,
        // flexibleSpace: Container(height: 200, color: Colors.black,),
      ),
      body: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(child: Text('Daftar Katalog'), 
            ),
          ),
    );
  }

}