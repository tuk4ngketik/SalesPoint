// ignore_for_file: library_private_types_in_public_api, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:sales_point/Views/login.dart';
import 'package:sales_point/dondrawer.dart'; 

import '../Cfg/css.dart';
import '../Helper/wg.dart';

class DaftarSukses extends StatefulWidget{
  const DaftarSukses({super.key});
  @override
  _DaftarSukses createState() => _DaftarSukses();
  
} 

class _DaftarSukses extends State<DaftarSukses>{

  bool visiblePass =  false;
  bool isLoad =  false;

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.black,
      drawer: const DonDrawer(),
      
      body: Container(        
        decoration: const BoxDecoration(
          image: DecorationImage( 
            image: AssetImage("images/bg3.jpg"), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center( 
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('images/v-kool_logo.png', height: 80,), 
              Opacity(opacity: 0.9,
                child: Card( 
                // color: Colors.black,
                shadowColor: Colors.black,
                elevation: 20,
                shape: Css.round20,
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      br(20),
                      const Icon(Icons.check_circle_outline, size: 80,),
                      const Text('Terima kasih telah mendaftar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
                      // Image.asset('images/vkool_paint.png', height: 80,), 
                      // const Divider(),
                      br(20),
                      
                      
                      br(12),
                        
                      Container(
                        // color: Colors.yellow,
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            // border: Border.all(width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          height: 55,
                          child:  Center(
                            child: TextButton( 
                                onPressed: () => Get.off(()=> const Login()) , 
                                child:  const Center(
                                  child:  Text('Silahkan Login', style: TextStyle(fontSize: 18, color: Colors.black),)
                                    // : const Icon(Icons.send)
                                ),
                              ),
                          )
                        ), 
                        br(20),
                        
                         
                  ],),
                ),
                          
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
  
  
}