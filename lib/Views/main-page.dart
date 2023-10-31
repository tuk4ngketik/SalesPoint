

// ignore_for_file: avoid_print, file_names, annotate_overrides, non_constant_identifier_names, unused_field, prefer_final_fields

import 'package:flutter/material.dart'; 
import 'package:sales_point/Cfg/sess.dart'; 
import 'package:sales_point/Helper/wg.dart'; 
import 'package:sales_point/Views/harga.dart';
import 'package:sales_point/Views/home.dart';
import 'package:sales_point/Views/katalog.dart';
import 'package:sales_point/Views/kelengkapan.dart'; 
import 'package:sales_point/Views/point.dart';
import 'package:sales_point/Views/profil.dart';

import 'package:firebase_messaging/firebase_messaging.dart'; 

class MyHomePage extends StatefulWidget {
  final String serial, namaLengkap, kelengkapan;
  const MyHomePage({super.key, required this.serial, required this.namaLengkap, required this.kelengkapan});  
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  Sess sess = Sess();
  String? status_app, serial, namaLengkap, mail, kelengkapan;
  
  // FCM
  String? _token;
  String? initialMessage;
  bool _resolved = false;

  @override
  void initState() { 
    super.initState();
    setState(() {
      serial = widget.serial;
      namaLengkap =  widget.namaLengkap;
      kelengkapan = widget.kelengkapan;
      _startScubscribe(serial!) ;
    });
    // sess.getSess('serial').then((value) =>  _startScubscribe(value!)  );  
    // sess.getSess('kelengkapan').then((value) =>  setState(() => kelengkapan = value )  );  
  }
    
 
  Future<void> _startScubscribe(String serial)async {
          await FirebaseMessaging.instance.subscribeToTopic(serial);
          print(  'FlutterFire Messaging Example: Subscribing to $serial "$serial" successful.', );
  }


  int _selectedIndex = 0;

  void changeTab(int index) {
    print('kelengkapan: $kelengkapan');
    if(kelengkapan == 'N') {
      bottomSheetAlertKelengkapan(const Kelengkapan());
      return;
    }
    setState(() => _selectedIndex = index );
    print ('_selectedIndex $_selectedIndex'); 
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
      body: (kelengkapan == null ) ? const Center(child: CircularProgressIndicator()) : contentWidget[_selectedIndex],
      // body:   contentWidget[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(   
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white, 
        // backgroundColor: Colors.black87,  
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // icon: Icon(Icons.home, size: 30,), 
            icon: Image.asset('images/menu/home_.png', height: 22, color: (_selectedIndex == 0) ? Colors.white  : null  ), 
            label: 'Beranda',
            backgroundColor: Colors.black87
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.shopping_bag, ),
            // icon: Image.asset('images/menu/katalog.png', height: 22, color: (_selectedIndex == 1) ? Colors.white  : Colors.grey,  ),
            icon: Image.asset('images/menu/katalog_.png', height: 22, color: (_selectedIndex == 1) ? Colors.white  : null,  ),
            label: 'Katalog',
            backgroundColor: Colors.black87
          ), 
          BottomNavigationBarItem(
            // icon: Icon(Icons.diamond, ),
            // icon: Image.asset('images/menu/poin.png', height: 22, color:(_selectedIndex == 2) ? Colors.white  : Colors.grey,   ),
            icon: Image.asset('images/menu/poin_.png', height: 22, color:(_selectedIndex == 2) ? Colors.white  : null,   ),
            label: 'Poin',
            backgroundColor: Colors.black87
          ), 
          BottomNavigationBarItem(
            // icon: Icon(Icons.shopify_sharp, ),
            // icon: Image.asset('images/menu/harga.png', height: 22,  color:(_selectedIndex == 3) ? Colors.white  : Colors.grey,  ),
            icon: Image.asset('images/menu/harga_.png', height: 22,  color:(_selectedIndex == 3) ? Colors.white  :null,  ),
            label: 'Harga',
            backgroundColor: Colors.black87
          ), 
          BottomNavigationBarItem(
            // icon: Icon(Icons.account_box_sharp, ),
            // icon: Image.asset('images/menu/profil.png', height: 22, color: (_selectedIndex == 4) ? Colors.white  : Colors.grey,  ),
            icon: Image.asset('images/menu/profil_.png', height: 22, color: (_selectedIndex == 4) ? Colors.white  : null,  ),
            label: 'Profil',
            backgroundColor: Colors.black87
          ), 
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Color.fromARGB(228, 0, 20, 72),
        // selectedItemColor: Colors.indigo[800], 
        onTap: changeTab,
      ),
    );
  }
 
  // NavigationBarButton botNavbar(String label, IconData icn){
  //   return NavigationBarButton(
  //             text:  label,
  //             icon: icn, 
  //             backgroundGradient: 
  //             const LinearGradient(
  //               colors: [     
  //               Colors.black,    
  //               Colors.grey,    
  //               Colors.white,   
  //               ],
  //             ),
  //           );
  // }

  List<Widget> contentWidget = [ 
    const Home(),
    // const Karousel(),
    const Katalog(),
    const Point(),
    const Harga(),
    const Profil()
  ];


}
