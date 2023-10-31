// ignore_for_file: library_private_types_in_public_api, avoid_print, file_names, prefer_typing_uninitialized_variables, unnecessary_string_interpolations, non_constant_identifier_names, avoid_returning_null_for_void, unused_field, unused_element, unused_local_variable, prefer_is_empty
 

import 'dart:convert';

import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sales_point/Apis/a_login.dart';
import 'package:sales_point/Cfg/css.dart';
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Helper/tanggal.dart';
import 'package:sales_point/Helper/wg.dart'; 
import 'package:sales_point/Views/login.dart'; 

class ForgotKonfirmasi extends StatefulWidget{ 
  final otp, serial, otp_exp;
  const ForgotKonfirmasi({super.key, this.otp, this.serial, this.otp_exp, });
  @override
  _ForgotKonfirmasi createState() => _ForgotKonfirmasi(); 
} 

class _ForgotKonfirmasi extends State<ForgotKonfirmasi>{

  ApiLogin apiLogin = ApiLogin();
  bool visiblePass =  false;
  bool isLoad =  false;
  Sess sess = Sess(); 
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

  String? status_app; //, phone, email; 
  String otp = '';
  var headers; 
  final _otp = TextEditingController();
  final _passwd = TextEditingController();
  final _passwdKonfirmasi = TextEditingController();

  @override
  void initState() { 
    super.initState(); 
    // sess.getSess('status_app').then((value) => setState(()=> status_app = value  )); 
    // sess.getSess('email').then((value) => setState(()=> email = value )); 
    // sess.getSess('phone').then((value) => setState(()=> phone = value ));  
    _initPackageInfo();
  }
  
  @override
  void dispose() { 
    super.dispose();
    _passwd.dispose();
    _otp.dispose();
    _passwdKonfirmasi.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: const Text('i-Kool Club'),
        centerTitle: true,
      ),
      
      body: Center( 
        // child: (email == null  ) ? const CircularProgressIndicator() : Column(
        child:  SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [  
              Text('Kode otp berakhir  ${tgl.convertJam( widget.otp_exp )}'),
              Opacity(opacity: 0.9,
                child: Card( 
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
                      const Icon(Icons.screen_lock_portrait_outlined, size: 40, color: Colors.blueGrey,),
                      const Text('Masukkan kode OTP', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                      br(10),
                      
                      TextFormField( 
                        controller: _passwd,
                        obscureText: true,
                        decoration:  InputDecoration(       
                          border: Css.round20,      
                          prefixIcon:  const Icon(Icons.key),
                          labelStyle: Css.labelStyle,
                          labelText: 'Kata sandi baru',
                          hintText:  'Kata sandi ',
                        ), 
                      ),
                      br(10),
                      
                      TextFormField( 
                        obscureText: true,
                        controller: _passwdKonfirmasi,
                        decoration:  InputDecoration(           
                          border: Css.round20,      
                          prefixIcon:  const Icon(Icons.password),
                          labelStyle: Css.labelStyle,
                          labelText: 'Konfirmasi kata sandi',
                          hintText:  'Ulangi kata sandi',
                        ), 
                      ),
                      br(10),
                         
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
                                onPressed: () =>  _forgotKonfirmasi()  , 
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
              TextButton( 
                onPressed: () => Get.off(()=> const Login()) , 
                child:  const Center(
                  child:  Text('Login', style: TextStyle(fontSize: 18, color: Colors.black),) 
                ), 
              ),
        
            ],
          ),
        ),
      ),
    );
  }
  
  _forgotKonfirmasi(){
    print('widget.otp ${widget.otp} widget.otp_exp ${widget.otp_exp}');
    String passwd = _passwd.text;
    String passwdKonfirmasi = _passwdKonfirmasi.text;
    
    if(passwd.length < 1 ||  passwd.length < 1){
      return defaultDialogErr('Lengkapi Kata sandi dan Konfirmasi');
    } 
    if( passwd.length < 6 ||  passwd.length > 15 ){
      return defaultDialogErr('Max Kata sandi 6 s/d 15 karakter');
    } 
    if(passwd != passwdKonfirmasi){
      return defaultDialogErr('Kata sandi dan Konfirmasi tidak sama');
    }

    if( otp !=  widget.otp  ){
      return defaultDialogErr('Kode OTP tidak sesuai');
    }
    setState(() => isLoad = true );

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
      "serial" : widget.serial,
      "otp":  '$otp',
      "passwd" : passwd
    };   
    print('data $data');
    apiLogin.forgotKonfirmasi(headers, jsonEncode(data) ).then((v) {
        if(v!.status == false){
          defaultDialogErr('${v.message}');
          setState(() =>  isLoad = false );
          return ;
        }
        setState(() =>  isLoad = false );
        defaultDialogSukses('Kata sandi berhasil di perbaharui', const Login());
    }); 

  }

  _otpChange(){ 
    setState(() =>  otp = _otp.text ); 
  }

 

}