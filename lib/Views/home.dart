// ignore_for_file: library_private_types_in_public_api, avoid_print
import 'package:flutter/material.dart'; 

import '../Cfg/css.dart';  

class Home extends StatefulWidget{
  const Home({super.key});
  @override
  _Home createState() => _Home();
  
} 

class _Home extends State<Home>{
  
  @override
  Widget build(BuildContext context){
    return Scaffold( 
      backgroundColor: Colors.grey,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        backgroundColor: Colors.black87,  
        toolbarHeight: 100,
        shape: Css.roundBottomAppbar, 
        title: const Text('Home', style: TextStyle(color: Colors.amber),),
        centerTitle: true, 

      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }

}