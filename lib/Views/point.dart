// ignore_for_file: library_private_types_in_public_api, avoid_print  
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
// import 'package:sales_point/dondrawer.dart';

import 'package:flutter/material.dart';
import '../Cfg/css.dart';  

class Point extends StatefulWidget{
  const Point({super.key});
  @override
  _Point createState() => _Point();
  
} 

class _Point extends State<Point>{
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        // backgroundColor: Colors.black87,
        backgroundColor: Colors.black,
        toolbarHeight: 200,
        shape: Css.roundBottomAppbar, 
        // title: const Text('Point', style: TextStyle(color: Colors.yellow),),
        title: Column(
          children: const [
            // Text('Point', style: TextStyle(color: Colors.yellow),),
            Icon(Icons.diamond_outlined, color: Colors.white, size: 120,),
            // Text('Point', style: TextStyle(color: Color.fromARGB(255, 161, 126, 18)),),
            Text('Point', style: TextStyle(color: Colors.amber)),
          ],
        ),
        centerTitle: true,
        // flexibleSpace: Container(height: 200, color: Colors.black,),
      ),
      body: const Center(child: Text('Point'))
    );
  }

}