// ignore_for_file: library_private_types_in_public_api, avoid_print, annotate_overrides, unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sales_point/Apis/a_login.dart';
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Helper/tanggal.dart'; 
import 'package:sales_point/Views/daftar.dart';
import 'package:sales_point/Views/forgot.dart'; 
import 'package:sales_point/Views/main-page.dart';
import 'package:sales_point/dondrawer.dart'; 

import '../Cfg/css.dart';
import '../Helper/wg.dart';

class Login extends StatefulWidget{
  const Login({super.key}); 
  _Login createState() => _Login(); 
} 

class _Login extends State<Login>{

  final now = DateTime.now(); 
  Tanggal tgl = Tanggal();
  ApiLogin apiLogin = ApiLogin();
  bool visiblePass =  false;
  bool isLoad =  false; 
  final _formKey = GlobalKey<FormState>();
  String? appVersion, _email, _passwd;
  
  // ignore: prefer_final_fields
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown', 
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() =>  _packageInfo = info ); 
  }
  
  void initState() { 
    super.initState();
    _initPackageInfo(); 
    setState(() {
      appVersion =  _packageInfo.version;
    });
  }
 
  void dispose() {
    super.dispose();  
  }

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

              Image.asset('images/v-kool_logo.png', height: 60,), 

              Opacity(opacity: 0.9,
                child: Card( 
                // color: Colors.black,
                shadowColor: Colors.black,
                elevation: 20,
                shape: Css.round20,
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form( key : _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        br(20),
                        const Text('Login', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),  
                        br(20),
                        
                        TextFormField( 
                          onSaved:(newValue) => _email = newValue,
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Email is required';
                            }
                            if (GetUtils.isEmail( value ) == false ){                              
                             return 'Ivalid email';
                            }
                            return null;
                          },
                           decoration:  InputDecoration(           
                            border: Css.round20,      
                            prefixIcon: const Icon(Icons.email, color: Colors.black),
                            labelStyle: Css.labelStyle,
                            labelText: 'Email',
                            hintText: 'Your Email',
                           ), 
                        ),
                        br(12),
                        
                        TextFormField( 
                          onSaved:(newValue) => _passwd = newValue,
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Password is required';
                            }
                            return null;
                          },
                          obscureText: (visiblePass ==  false) ? true : false,
                           decoration:  InputDecoration(        
                            labelStyle: Css.labelStyle,
                            labelText: 'Password',   
                            border: Css.round20, 
                            prefixIcon: const Icon(Icons.lock_open, color: Colors.black),
                            hintText: 'Password',  
                            suffixIcon: IconButton(
                              onPressed: (){ 
                                setState(() {
                                  visiblePass =  !visiblePass;
                                  print('visiblePass $visiblePass' );
                                });
                              }, 
                              icon: (visiblePass ==  false) ? const Icon(Icons.visibility_off_sharp, color: Colors.black) : const Icon(Icons.visibility, color: Colors.black,)
                            )
                           ),
                        ),
                        br(20),
                                  
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
                                  onPressed: (){    
                                    if (_formKey.currentState!.validate() == false) { return; }
                                    _formKey.currentState!.save();
                                    _login();
                                 },
                                  child:  Center(
                                    child: ( isLoad == true ) 
                                      ? const CircularProgressIndicator(color: Colors.orange,)
                                      : const Text('Login', style: TextStyle(fontSize: 18, color: Colors.black),)
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
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    TextButton(
                      onPressed: ()=> Get.to(const Daftar()), 
                      child: const Text('Daftar', style: TextStyle(color: Colors.yellow),)
                    ),
                    // const Text(' | ', style: TextStyle(color: Colors.grey),),
                    TextButton(
                      onPressed: ()=> Get.to(const Forgot()), 
                      child: const Text('Lupa Password ?', style: TextStyle(color: Colors.grey),)
                    ),  
                ],
              ) 
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {      
    setState(() { isLoad = true; }); 
    String pckDate = base64.encode(utf8.encode( tgl.dmy() )); 
    String pckName = base64.encode(utf8.encode( _packageInfo.packageName));   
    
    var headers = {
      'pckname': pckName,
      'pckdate': pckDate,
      'appversion':  _packageInfo.version, 
      'targetpath': 'c2lzdGVtZ2FyYW5zaS5jb20vc2l0ZS9hcGk=',
      'apikey': 'aUtvb2wtU2FsZXMtUG9pbnQ',  
      'Content-Type': 'application/json'
    };
 
    var data = {
      'email' : _email,
      'passwd' : _passwd
    }; 
    // print ('headers $headers');
    // print ('data $data');

    apiLogin.login( headers, jsonEncode(data) ).then((v) {
        bool? status = v!.status;
        String? msg = v.message;
        if(status == false){
          snackAlert('Error',  '$msg');
          setState(() { isLoad = false; }); 
          return;
        }
        var data = v.data; 
        Sess sess = Sess();
        sess.setSess('first_name', '${data!.firstName}');
        sess.setSess('last_name', '${data.lastName}');
        sess.setSess('email', '${data.email}');
        sess.setSess('phone', '${data.phone}');
        sess.setSess('prov', '${data.prov}'); 
        sess.setSess('address', '${data.address}');
        Get.off(const MyHomePage()); 
    });  
  }
  
}