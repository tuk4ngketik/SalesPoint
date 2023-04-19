import 'package:flutter/material.dart';

class Css {

  // Title 
  static TextStyle titlePage  = const TextStyle(color: Colors.black, fontSize: 20);


  // Formc 
  static OutlineInputBorder roundInput20 = const OutlineInputBorder(
                      borderSide: BorderSide(width:0, strokeAlign: 0, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20)),  
                    ); 

  static OutlineInputBorder round20 = const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.1, strokeAlign: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(20)),  
                    ); 

   

  static TextStyle labelStyle = const TextStyle(color: Colors.black, fontSize: 18);

  static TextStyle profilText = const TextStyle(color: Colors.black, fontSize: 17);

  // Harga
  static TextStyle labelHarga = const TextStyle(color: Colors.black, fontSize: 17); 

  static TextStyle labelTarif= const  TextStyle( color: Colors.black,   fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 18,   );
  
  static TextStyle textTotal = const TextStyle(color: Colors.white, fontSize: 18); 

  // Bottom Bar
  static OutlineInputBorder roundBottomAppbar = const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.1, strokeAlign: 0.5),
                      // borderRadius: BorderRadius.all(Radius.circular(20))
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      )
                    ); 

}