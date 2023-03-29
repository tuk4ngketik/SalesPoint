// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Views/login.dart'; 
import 'package:sales_point/Views/main-page.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp()); 
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyApp createState()=> _MyApp();
}

class _MyApp extends State<MyApp> {

  Sess sess = Sess();
  String? email;
   
  @override
  void initState() { 
    super.initState();
    sess.getSess('email').then((value) => setState(() => email = value,));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
      return GetMaterialApp(
      title: 'Reseller/ Sales Point',
      theme: ThemeData( 
        primarySwatch: Colors.yellow,
      ),
      home: (email == null) ? const Login() : const MyHomePage(), 
    );
  }

} 