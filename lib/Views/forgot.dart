// ignore_for_file: library_private_types_in_public_api, avoid_print, non_constant_identifier_names, sized_box_for_whitespace, prefer_is_empty, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sales_point/Apis/a_login.dart';
import 'package:sales_point/Helper/tanggal.dart';
import 'package:sales_point/Views/forgot_konfirmasi.dart'; 
import 'package:sales_point/Views/login.dart'; 

import '../Cfg/css.dart';
import '../Helper/wg.dart';

class Forgot extends StatefulWidget{
  const Forgot({super.key});
  @override
  _Forgot createState() => _Forgot();
  
} 

class _Forgot extends State<Forgot>{

  ApiLogin apiLogin = ApiLogin();
  Tanggal tgl = Tanggal();  
  var headers;
  bool visiblePass =  false;
  bool isLoad =  false;
  final idforgot = TextEditingController();
  String tipe_konfirmasi = 'Email';

  @override
  void initState() { 
    super.initState();
    _initPackageInfo();
  }

  @override
  void dispose() { 
    super.dispose();
    idforgot.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.black,
      // drawer: const DonDrawer(),
      
      body: Container(        
        decoration: const BoxDecoration(
          image: DecorationImage( 
            image: AssetImage("images/bg3.jpg"),   
            fit: BoxFit.cover,
          ),
        ),
        child: Center( 
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('images/ikool-apps-logo.png', height: 80,color: Colors.white,),               
                Opacity(
                  opacity: 0.9,
                  child: Card( 
                  // color: Colors.black,
                  shadowColor: Colors.black,
                  elevation: 20,
                  shape: Css.round20,
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column( 
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ 
                        const Icon(Icons.lock_reset, size: 80,), 
                        const Divider(color: Colors.amber,), 
                        const Text('Lupa kata sandi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),  
                        br(10), 
                        DropdownButtonFormField<String>(  
                              // menuMaxHeight: Get.height/2,    
                              decoration:  InputDecoration(    
                              contentPadding: const EdgeInsets.all(17), 
                              border: Css.round20,  
                              labelText: 'Tipe Konfirmasi', 
                            ), 
                            dropdownColor: Colors.white, 
                            style: const TextStyle( 
                              color: Colors.black,  
                              // fontWeight: FontWeight.bold,
                              letterSpacing: 1
                            ), 
                            hint: const Text('Email'),    
                            onChanged: (String? v) {   
                                setState(() {
                                  tipe_konfirmasi = '$v';
                                  idforgot.text = '';
                                });  
                            },  
                              items: ['Email','Whatsapp'].map<DropdownMenuItem<String>>((String value){
                              return DropdownMenuItem<String>( value: value, child: Text(value), ); 
                              }).toList(), 
                        ),
                        br(10), 
                        TextFormField( 
                          decoration:  InputDecoration(           
                            border: Css.round20,      
                            prefixIcon: ( tipe_konfirmasi == 'Email') ? const Icon(Icons.email) : const Icon(Icons.phone),
                            labelStyle: Css.labelStyle,
                            labelText: (  tipe_konfirmasi == 'Email') ? 'Email' : 'No Whatsapp',
                            hintText: (  tipe_konfirmasi == 'Email') ? 'Email anda' : 'No Ponsel',
                          ),
                          controller: idforgot,
                        ),
                        
                        br(10),
                          
                        Container( 
                            decoration: const BoxDecoration(
                              color: Colors.amber, 
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            height: 50,
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
                      ],),
                    ),                          
                  ),
                ), 
              TextButton( 
                onPressed: () => Get.off(()=> const Login()) , 
                child:  const Center(
                  child:  Text('Login', style: TextStyle(fontSize: 18, color: Colors.white),) 
                ), 
              ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
 
  Future<void> _forgot() async {    
    // print('tipe_konfirmasi: $tipe_konfirmasi');
    // print('idforgot.text: ${idforgot.text}');
    String v = idforgot.text;
    if(v.length < 1){
      return;
    }
    var data = {
      'tipe' : tipe_konfirmasi,
      'idforgot' : v 
    };
    print('data $data');
    // setState(() { isLoad = true; });  
    // setState(() { isLoad = false; }); 
    // snackAlert( 'title',   'message'); 
    // snackError( 'title',   'message'); 
    

    String pckDate = base64.encode(utf8.encode( tgl.dmy() )); 
    String pckName = base64.encode(utf8.encode( _packageInfo.packageName)); 
    headers = {
      'pckname': pckName,
      'pckdate': pckDate,
      'appversion':  _packageInfo.version, 
      'targetpath': 'c2lzdGVtZ2FyYW5zaS5jb20vc2l0ZS9hcGk=',
      'apikey': 'aUtvb2wtU2FsZXMtUG9pbnQ',  
      'Content-Type': 'application/json'
    }; 
    setState(() { isLoad = true; });   
    apiLogin.forgot(headers, jsonEncode(data) ).then((v){
      if(v!.status == false){
        defaultDialogErr('${v.message}');
        setState(() { isLoad = false; });   
        return;
      }
        var d = v.data; 
        // defaultDialogErr('${d['first_name']}\n${d['serial']}\n${d['otp']}\n${d['expired_otp']}');
        Get.offAll(()=>   ForgotKonfirmasi( otp: '${d['otp']}', serial: '${d['serial']}', otp_exp: '${d['expired_otp']}',));
        setState(() { isLoad = false; });    
    });
  }
 

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown', packageName: 'Unknown',  version: 'Unknown',
    buildNumber: 'Unknown',  buildSignature: 'Unknown', 
  ); 

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() =>  _packageInfo = info );  
  }   
  
}