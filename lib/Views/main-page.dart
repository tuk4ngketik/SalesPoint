

// ignore_for_file: avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
import 'package:sales_point/Views/harga.dart';
import 'package:sales_point/Views/home.dart';
import 'package:sales_point/Views/katalog.dart';
import 'package:sales_point/Views/point.dart';
import 'package:sales_point/Views/profil.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
   
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  int _selectedIndex = 0;

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print ('_selectedIndex $_selectedIndex');
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      // appBar: AppBar(
      //   backgroundColor: Colors.black87,
      //   toolbarHeight: 200,
      //   shape: Css.roundBottomAppbar, 
      //   title: const Text('Home', style: TextStyle(color: Colors.yellow),),
      //   centerTitle: true,
      //   // flexibleSpace: Container(height: 200, color: Colors.black,),
      // ),
      // drawer: const DonDrawer(),

      backgroundColor: Colors.grey, 
      // extendBody: true,

      bottomNavigationBar: ResponsiveNavigationBar( 
          // activeIconColor: Colors.black,
          // activeIconColor: Colors.yellow,  
          activeIconColor: Colors.white,  
          inactiveIconColor: Colors.white70,
          // backgroundColor: Colors.black,
          // backgroundColor: Colors.white,
          // backgroundOpacity: 1,
          backgroundOpacity: 0,
          outerPadding: const EdgeInsets.fromLTRB(10, 0, 10, 5), 
          // outerPadding: const EdgeInsets.fromLTRB(8, 0, 8, 5), 
          // borderRadius: 0,
          selectedIndex: _selectedIndex,
          onTabChange: changeTab,
          // showActiveButtonText: false,
          fontSize: 17,  
          textStyle: const TextStyle( 
            // color: Colors.amber, 
            color: Colors.black,
            fontWeight: FontWeight.w900,   
          ),
          navigationBarButtons:   <NavigationBarButton>[
             botNavbar('Beranda', Icons.home ),
             botNavbar('Katalog', Icons.shopify_sharp),
             botNavbar('Harga', Icons.monetization_on),
             botNavbar('Poin', Icons.diamond), 
             botNavbar('Profil', Icons.person_sharp), 
            // NavigationBarButton(
            //   text: 'Tab 3',
            //   icon: Icons.settings,
            //   backgroundGradient: LinearGradient(
            //     colors: [Colors.green, Colors.yellow],
            //   ),
            // ), 
          ],
           
        ), 
      body: contentWidget[_selectedIndex],
      // body: Center(  child: Text('_selectedIndex $_selectedIndex'), ),    
    );
  }
 
  NavigationBarButton botNavbar(String label, IconData icn){
    return NavigationBarButton(
              text:  label,
              icon: icn, 
              backgroundGradient: 
              const LinearGradient(
                colors: [    
                // Colors.white,  
                Colors.black,  
                // Colors.black,  
                // Colors.black,  
                // Colors.black,  
                // Colors.black87, 
                // Colors.black54,      
                // Colors.black26,
                // Colors.black12,      
                Colors.grey,    
                // Colors.grey,    
                // Colors.white, 
                Colors.white,   
                ],
              ),
            );
  }

  List<Widget> contentWidget = [
    const Home(),
    const Katalog(),
    const Harga(),
    const Point(),
    const Profil()
  ];

}
