// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_point/Views/home.dart'; 
import 'package:sales_point/Views/login.dart';

class DonDrawer extends StatelessWidget{
  const DonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
       child: Column(
        children: [
          Container(
            height: 200,
            child: const Text('Header'),
          ),
          const Divider(),
          InkWell(
            onTap: () => Get.to(const Home()),
            child: const Text('Home'),
          ),
          const Divider(),
          InkWell(
            onTap: () => Get.to(const Login()),
            child: const Text('Login'),
          ),
        ],
       ) ,
    );
  }

}