// ignore_for_file: library_private_types_in_public_api, avoid_print, file_names, prefer_typing_uninitialized_variables, unnecessary_string_interpolations, non_constant_identifier_names, avoid_returning_null_for_void, unused_field, unused_element
 

import 'dart:convert';

import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sales_point/Apis/a_login.dart';
import 'package:sales_point/Cfg/css.dart';
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Helper/tanggal.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Views/daftar.dart'; 
import 'package:sales_point/Views/login.dart'; 

class Verifikasi extends StatefulWidget{ 
  const Verifikasi({super.key, });
  @override
  _Verifikasi createState() => _Verifikasi(); 
} 

class _Verifikasi extends State<Verifikasi>{

  ApiLogin apiLogin = ApiLogin();
  bool visiblePass =  false;
  bool isLoad =  false;
  Sess sess = Sess();
  String? status_app, phone, email; 
  String otp = '';
  var headers; 
  final _otp = TextEditingController();
  final now = DateTime.now(); 
  Tanggal tgl = Tanggal(); 
 
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() =>  _packageInfo = info );  
  }  

  @override
  void initState() { 
    super.initState(); 
    sess.getSess('status_app').then((value) => setState(()=> status_app = value  )); 
    sess.getSess('email').then((value) => setState(()=> email = value )); 
    sess.getSess('phone').then((value) => setState(()=> phone = value ));  
    _initPackageInfo();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      // backgroundColor: Colors.black,
      // drawer: const DonDrawer(),
      appBar: AppBar(
        title: const Text('i-Kool Club'),
        centerTitle: true,
      ),
      
      body: Center( 
        child: (email == null  ) ? const CircularProgressIndicator() : Column(
          mainAxisSize: MainAxisSize.min,
          children: [ 
            // Image.asset('images/ikool-apps-logo.png', height: 100,),
            const Text('Cek Email / Whatsapp anda'),
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
                    const Icon(Icons.screen_lock_portrait_outlined, size: 80, color: Colors.blueGrey,),
                    const Text('Masukkan kode OTP', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
                    // Image.asset('images/vkool_paint.png', height: 80,), 
                    // const Divider(),
                    const Divider(), 
                    
                    TextFormField(  
                      
                      controller: _otp,
                      onChanged: (value) => _otpChange(), 
                      maxLength: 5,
                      autofocus: true,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center, 
                      style: const TextStyle(  
                        color: Colors.red,
                        fontSize: 30,
                        letterSpacing: 10, 
                        fontWeight: FontWeight.bold 
                      ),
                       decoration:  const InputDecoration(     
                        border: InputBorder.none, 
                        hintText: '_____', 
                        counterText: ''
                       ),
                    ), 
                    br(12),
                      
                    (otp.length < 5) 
                    ? Container( 
                        decoration: const BoxDecoration(
                          color:    Colors.grey,   borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        height: 55,
                        child:  Center(
                          child: TextButton( 
                              onPressed: () => null  , 
                              child:   const Center(
                                child:  Text('Kirim ', style: TextStyle(fontSize: 18, color: Colors.black),) 
                              ),
                            ),
                        )
                      ) 
                    : Container( 
                        decoration: const BoxDecoration(
                          color:    Colors.amber, 
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        height: 55,
                        child:  Center(
                          child: TextButton( 
                              onPressed: () =>  _verifikasi()  , 
                              child:   Center(
                                child: (isLoad == true)  
                                          ? const CircularProgressIndicator()  
                                          : const Text('Kirim ', style: TextStyle(fontSize: 18, color: Colors.black),)
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
             
            OutlinedButton( 
               child: const Text('Minta ulang kode OTP'),
               onPressed: () => _mintaKodeUlang(),
            ),
            
            // TextButton( 
            //   onPressed: () => Get.off(()=> const Login()) , 
            //   child:  const Center(
            //     child:  Text('<< back', style: TextStyle(fontSize: 18, color: Colors.black),) 
            //   ), 
            // ),

          ],
        ),
      ),
    );
  }
  
  _verifikasi(){
    String pckDate = base64.encode(utf8.encode( tgl.dmy() )); 
    String pckName = base64.encode(utf8.encode( _packageInfo.packageName));  
    var headers = {
      'pckname': pckName,
      'pckdate': pckDate,
      'appversion':  _packageInfo.version, 
      'targetpath': 'c2lzdGVtZ2FyYW5zaS5jb20vc2l0ZS9hcGk=',
      'apikey': 'aUtvb2wtU2FsZXMtUG9pbnQ' 
    }; 

    var data = {
      "email": '$email',  
      "phone" : '$phone', 
      "otp":  '$otp'
    };   

    setState(() =>   isLoad = true );
    apiLogin.verifikasi(headers,  jsonEncode(data) ).then((v){ 
      bool status = v!.status;
      String msg = v.message;

      if(status == false){
        customDialogErr(msg); 
        setState(() =>   isLoad = false );
        return;
      } 
      
        // sess.setSess('status_app', 'Login');
        // Get.offAll( ()=> const MyHomePage() );
        sess.destroy(); 
        Get.offAll( ()=> const Login() );
      
    });
  }

  _mintaKodeUlang(){
     print('Sess $status_app :  $email : $phone ');
     print('url Verifikasi https://sistemgaransi.com/site/api/verifikasi.php');
  }

  _otpChange(){ 
    setState(() =>  otp = _otp.text );
  }


 customDialogErr(String msg){ 
          Get.defaultDialog(
            title: '',
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all( 20),
            content: Column(children:   [
              const Icon(Icons.error, color: Colors.red, size: 40,), 
              br(20),
              Text(msg, style: const TextStyle(color: Colors.black, fontSize: 18),),
              // br(20), 
              const Divider(),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    // width: Get.width,
                    child: OutlinedButton( 
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.amber[300],  
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),  
                      ),
                      onPressed: () =>  Get.to(() => const Daftar()), 
                      child: const Text('Registrasi ulang', style: TextStyle(color: Colors.black),)
                    ),
                  ),
                  // Flexible(flex: 2, child: Text('')),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: Get.width,
                      child: TextButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black26,  
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),  
                      ), 
                        onPressed: () =>  Get.back(), 
                        child: const Text('Tutup', style: TextStyle(color: Colors.black),)
                      ),
                    ),
                  )
                ],
              )

            ],),
            // textCancel: 'Tutup',
            cancelTextColor: Colors.black 
          );
 }

}