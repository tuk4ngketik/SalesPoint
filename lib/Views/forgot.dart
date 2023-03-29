// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:sales_point/Views/login.dart';
import 'package:sales_point/dondrawer.dart'; 

import '../Cfg/css.dart';
import '../Helper/wg.dart';

class Forgot extends StatefulWidget{
  const Forgot({super.key});
  @override
  _Forgot createState() => _Forgot();
  
} 

class _Forgot extends State<Forgot>{

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
                      const Icon(Icons.lock_reset, size: 80,),
                      const Text('Lupa Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
                      // Image.asset('images/vkool_paint.png', height: 80,), 
                      // const Divider(),
                      br(20),
                      
                      TextFormField( 
                         decoration:  InputDecoration(           
                          border: Css.round20,      
                          prefixIcon: const Icon(Icons.email),
                          labelStyle: Css.labelStyle,
                          labelText: 'Email',
                          hintText: 'Your Email',
                         ),
                      ),
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
                                onPressed: () => _forgot(), 
                                child:  Center(
                                  child: ( isLoad == true ) 
                                    ? const CircularProgressIndicator()
                                    : const Text('Kirim', style: TextStyle(fontSize: 18, color: Colors.black),)
                                    // : const Icon(Icons.send)
                                ),
                              ),
                          )
                        ), 
                        br(20),
                        // TextButton(
                        //   onPressed: ()=> print('Ling reset password') , 
                        //   child: const Text('Lupa Password ?')
                        // ),
                         
                  ],),
                ),
                          
                ),
              ),
                      TextButton(
                        onPressed: ()=>Get.to(const Login()), 
                        child: const Text('Login', style: TextStyle(color: Colors.grey),)
                      ) 
            ],
          ),
        ),
      ),
    );
  }
 
  Future<void> _forgot() async {    
    setState(() { isLoad = true; }); 
    await Future.delayed(const Duration(seconds: 1)); 
    snackAlert( 'title',   'message'); 
    setState(() { isLoad = false; }); 
    snackError( 'title',   'message'); 
  }
  
  
}