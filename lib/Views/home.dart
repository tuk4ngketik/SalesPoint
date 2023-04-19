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
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        // backgroundColor: Colors.black87,  
        toolbarHeight: 200,
        shape: Css.roundBottomAppbar, 
        centerTitle: true, 
        title: Column(
          children: const [
            // Text('Katalog', style: TextStyle(color: Colors.yellow),),
            Icon(Icons.home_rounded, color: Colors.white, size: 120,),
            // Text('Katalog', style: TextStyle(color: Color.fromARGB(255, 161, 126, 18)),),
            Text('Home', style: TextStyle(color: Colors.white)),
          ],
        ),
        // flexibleSpace: Image.asset('images/ikool-apps-logo.png'),

      // ),
      // appBar: AppBar( 
      //   backgroundColor: Colors.transparent,
      //   toolbarHeight: 100,
      //   title: const Text('Home', style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 28
      //   ),) ,
      //   centerTitle: true,
      //   flexibleSpace: Container(  
      //     decoration: const BoxDecoration(
      //         image: DecorationImage(
      //             image: AssetImage('images/bg-top-2.png'),
      //             fit: BoxFit.fitWidth
      //         ),
      //           borderRadius: BorderRadius.only(
      //               bottomLeft: Radius.circular(50.0),
      //               bottomRight: Radius.circular(20.0)),
      //     ),
      //   ),

      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }

}