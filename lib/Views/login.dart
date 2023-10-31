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
      // backgroundColor: Colors.black, 
      
      body: Container(        
        decoration: const BoxDecoration(
          image: DecorationImage( 
            image: AssetImage("images/bg2.jpg"),  
            // image: AssetImage("images/ikool-app-bg.png"),  
            fit: BoxFit.cover,
          ),
        ),

        child: Center( 
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: [
            
                // Image.asset('images/ikool-apps-logo.png', height: 90,),  
                Image.asset('images/v-kool_logo.png', height: 90,),  
                // const Text('Login', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),  
                         
            
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form( key : _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min, 
                      crossAxisAlignment: CrossAxisAlignment.start,
            
                      children: [ 
                        br(20), 
                        TextFormField(  
                          style: const TextStyle(  fontWeight: FontWeight.normal, color: Colors.white, fontSize: 19    ),
                          onSaved:(newValue) => _email = newValue,
                          validator: (value) {
                            if(value!.isEmpty){
                              // return 'Email is required';
                              return 'Lengkapi Email';
                            }
                            if (GetUtils.isEmail( value ) == false ){                              
                            //  return 'Ivalid email';                        
                             return 'Email tidak valid';
                            }
                            return null;
                          },
                           decoration:  InputDecoration(   
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 0, strokeAlign: 0, style: BorderStyle.none),
                              borderRadius: BorderRadius.all(Radius.circular(20)),  
                            ),
                            errorBorder: Css.roundInput20, 
                            focusedBorder: Css.roundInput20, 
                            border: Css.roundInput20, 
                            prefixIcon: const Icon(Icons.email, color: Colors.black),
                            labelStyle: Css.labelLoginStyle,
                            labelText: 'Email',
                            hintText: 'Email anda', 
                            filled: true,
                            fillColor: Colors.white54,
                           ),  
                        ),
                        br(20),
                        
                        TextFormField( 
                          style: const TextStyle(  fontWeight: FontWeight.normal, color: Colors.white, fontSize: 19    ),
                          onSaved:(newValue) => _passwd = newValue,
                          validator: (value) {
                            if(value!.isEmpty){
                              // return 'Password is required';
                              return 'Lengkapi kata sandi';
                            }
                            return null;
                          },
                          obscureText: (visiblePass ==  false) ? true : false,
                           decoration:  InputDecoration(    
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 0, strokeAlign: 0, style: BorderStyle.none),
                              borderRadius: BorderRadius.all(Radius.circular(20)),  
                            ),
                            errorBorder: Css.roundInput20, 
                            focusedBorder: Css.roundInput20, 
                            labelStyle: Css.labelLoginStyle,
                            labelText: 'Kata Sandi',   
                            border: Css.roundInput20, 
                            prefixIcon: const Icon(Icons.lock_open, color: Colors.black),
                            hintText: 'Kata sandi',  
                            filled: true,
                            fillColor: Colors.white54,
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
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: ()=> Get.to(const Forgot()), 
                            child: const Text('Lupa Kata sandi ?', style: TextStyle(color: Colors.white),)
                          ), 
                        ), 
                                    
                        Container(
                          // color: Colors.yellow,
                            decoration: const BoxDecoration(
                              color: Colors.amber, 
                              // color: Colors.black, 
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
                                      ? const CircularProgressIndicator(color: Colors.orange, strokeWidth: 2, ) 
                                      : const Text('Login', style: TextStyle(fontSize: 18, color: Colors.white),)
                                      // : const Icon(Icons.send)
                                  ),
                                ),
                            )
                          ),  
                           
                    ],),
                  ),
                ),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      TextButton(
                        onPressed: ()=> Get.to(const Daftar()), 
                        child: const Text('Belum punya akun? Registrasi', style: TextStyle(color: Colors.white),)
                      ),  
                  ],
                ) 
              ],
            ),
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

    apiLogin.login( headers, jsonEncode(data) ).then((v) {
        bool? status = v!.status;
        String? msg = v.message;
        if(status == false){
          // snackAlert('Error',  '$msg');
          defaultDialogErr('$msg');
          setState(() { isLoad = false; }); 
          return;
        }
        var data = v.data!; 
        Sess sess = Sess();
        // sess.setSess('status_app', 'login');
        // sess.setSess('serial', '${data.serial}');
        // sess.setSess('namaLengkap', '${data.firstName}');  
        // sess.setSess('email', '${data.email}');
        // sess.setSess('phone', '${data.phone}');
        // sess.setSess('ktp', '${data.noKtp}');
        // sess.setSess('prov', '${data.prov}'); 
        // sess.setSess('address', '${data.address}');
        // sess.setSess('kelengkapan', '${data.kelengkapan}');
        
        sess.setSess('status_app', 'login');
        sess.setSess('serial', '${data.serial}');
        sess.setSess('namaLengkap', '${data.firstName}');  
        sess.setSess('email', '${data.email}');
        sess.setSess('phone', '${data.phone}');
        sess.setSess('noktp', '${data.noKtp}');
        sess.setSess('prov', '${data.prov}'); 
        sess.setSess('address', '${data.address}');
        sess.setSess('kelengkapan', '${data.kelengkapan}');
        sess.setSess('pic', '${data.pic}');
        sess.setSess('img_ktp', '${data.imgKtp}'); 
        Get.offAll(  MyHomePage(serial:'${data.serial}',namaLengkap: '${data.firstName}', kelengkapan: '${data.kelengkapan}' ) ); 
    });  
  }
  
}