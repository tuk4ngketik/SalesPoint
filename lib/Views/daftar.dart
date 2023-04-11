// ignore_for_file: library_private_types_in_public_api, avoid_print, annotate_overrides, unused_field, non_constant_identifier_names, unused_element

// import 'dart:convert';

import 'dart:convert';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart'; 
import 'package:sales_point/Apis/a_login.dart';
import 'package:sales_point/Helper/rgx.dart';
import 'package:sales_point/Helper/tanggal.dart';
import 'package:sales_point/Views/daftar-sukses.dart'; 
import 'package:sales_point/dondrawer.dart'; 
import '../Cfg/css.dart';
import '../Helper/wg.dart';

class Daftar extends StatefulWidget{
  const Daftar({super.key}); 
  _Daftar createState() => _Daftar(); 
} 

class _Daftar extends State<Daftar>{

  final now = DateTime.now(); 
  Tanggal tgl = Tanggal();

  ApiLogin apiLogin = ApiLogin();
  String? msgAPiDealerpartisipasi;

  bool visiblePass =  false;
  bool isLoad =  false; 
  final _formKey = GlobalKey<FormState>();
  String? _email, _passwd, _passwdKonfirm, 
          nama_depan, nama_belakang, no_ktp, no_hp;
  final passwd_ = TextEditingController();
  
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() =>  _packageInfo = info ); 
    _getDealer();
  }
  
  void initState() { 
    super.initState();
    _initPackageInfo(); 
    // _getDealer();
  }
 
  void dispose() {
    super.dispose();  
    passwd_.dispose();
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
          child: (msgAPiDealerpartisipasi == null) ? const CircularProgressIndicator() : ListView( 
            children: [

              // Image.asset('images/v-kool_logo.png', height: 60,), 

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
                        const Text('Daftar', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),  
                        br(20),

                        //Dealer
                        EasyAutocomplete(    
                          decoration:   const InputDecoration(   
                            labelText: 'Dealer', 
                            contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30) ), 
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white24) ), 
                            border: OutlineInputBorder( 
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              gapPadding: 0,
                            ), 
                          ),
                          suggestions:  listBranchname,
                          suggestionBuilder: (data) {
                            return ListTile(
                              title: Text(data),
                              subtitle: Text('${mapBranch[data]}'),
                            );
                          },
                          onChanged: (value)  => print('onchange $value'),
                          onSubmitted: (v){   
                              print('onSubmitted :  $v');    
                            }, 
                        ),
                        br(12),
                        // NAma Depan
                        TextFormField( 
                           decoration:  InputDecoration(       
                            labelText: 'Nama depan',
                            // hintText: 'Nama Depan',    
                            border: Css.round20,      
                            prefixIcon: const Icon(Icons.person, color: Colors.black),
                            labelStyle: Css.labelStyle,
                           ), 
                          onSaved:(newValue) => nama_depan = newValue,
                          validator: (value) { 
                            if(value!.isEmpty){
                              return 'Lengkapi Nama depan';
                            }
                            if( alphabetOnly(value) == false){
                              return 'Nama depan harus Alfabet';
                            }
                            return null;
                          },
                        ),
                        br(12),
                        // Nama Belakang
                        TextFormField( 
                           decoration:  InputDecoration(       
                            labelText: 'Nama belakang',
                            // hintText: 'Nama Depan',    
                            border: Css.round20,      
                            // prefixIcon: const Icon(Icons.person, color: Colors.black),
                            labelStyle: Css.labelStyle,
                           ), 
                          onSaved:(newValue) => nama_belakang = newValue,
                          validator: (value) { 
                            if( alphabetOnly(value) == false){
                              return 'Nama belakang harus Alfabet';
                            }
                            return null;
                          },
                        ),
                        br(12),
                        // No KTP
                        TextFormField( 
                           decoration:  InputDecoration(       
                            labelText: 'No KTP',
                            // hintText: 'Nama Depan',    
                            border: Css.round20,      
                            prefixIcon: const Icon(Icons.tag, color: Colors.black),
                            labelStyle: Css.labelStyle,
                           ), 
                          onSaved:(newValue) => no_ktp = newValue,
                          validator: (value) { 
                            if( numberOnly(value) == false){
                              return 'No. KTP harus angka';
                            }
                            if(  value!.length < 16  || value.length > 16 )  {
                              return 'No. KTP tidak valid';
                            }
                            return null;
                          },
                        ),
                        br(12),
                        // No Handphone
                        TextFormField( 
                           decoration:  InputDecoration(       
                            labelText: 'No. Hp',
                            // hintText: 'Nama Depan',    
                            border: Css.round20,      
                            prefixIcon: const Icon(Icons.phone, color: Colors.black),
                            labelStyle: Css.labelStyle,
                           ), 
                          onSaved:(newValue) => no_hp = newValue,
                          validator: (value) { 
                            if( numberOnly(value) == false){
                              return 'No. Hp harus angka';
                            }
                            if(  value!.length < 10  || value.length > 15 || kosongLapan(value) == false )  {
                              return 'No. Hp tidak valid';
                            } 
                            return null;
                          },
                        ),
                        br(12),
                        // Email 
                        TextFormField( 
                          onSaved:(newValue) => _email = newValue,
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Lengkapi Email';
                            }
                            if (GetUtils.isEmail( value ) == false ){                              
                             return 'Email tidak valid';
                            }
                            return null;
                          },
                           decoration:  InputDecoration(           
                            border: Css.round20,      
                            prefixIcon: const Icon(Icons.email, color: Colors.black),
                            labelStyle: Css.labelStyle,
                            labelText: 'Email',
                            hintText: 'Alamat Email',
                           ), 
                        ),
                        br(12),
                        // Password 
                        TextFormField( 
                          onSaved:(newValue) => _passwd = newValue,
                          controller: passwd_,
                          validator: (value) {
                            if(value!.isEmpty  ){
                              return 'Lengkapi password';
                            }
                            if( value.length < 6 || value.length > 15){
                              return 'Password min 6 s/d  15 karakter';
                            }
                            return null;
                          },
                          obscureText: (visiblePass ==  false) ? true : false,
                           decoration:  InputDecoration(        
                            labelStyle: Css.labelStyle,
                            labelText: 'Password',   
                            border: Css.round20, 
                            prefixIcon: const Icon(Icons.lock_open, color: Colors.black),
                            hintText: ' - - -',  
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
                        br(12),
                        // Password Konfirm
                        TextFormField( 
                          onSaved:(newValue) => _passwdKonfirm = newValue,
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Lengkapi Password konfirmasi'; 
                            }
                            if(value != passwd_.text ){
                              return 'Password konfirmasi harus sesuai';  
                            }
                            return null;
                          },
                          obscureText: (visiblePass ==  false) ? true : false,
                           decoration:  InputDecoration(        
                            labelStyle: Css.labelStyle,
                            labelText: 'Konfirmasi Password',   
                            border: Css.round20, 
                            prefixIcon: const Icon(Icons.password, color: Colors.black),
                            hintText: ' - - -',  
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
                                    _daftar();
                                 },
                                  child:  Center(
                                    child: ( isLoad == true ) 
                                      ? const CircularProgressIndicator(color: Colors.orange,)
                                      : const Text('Daftar', style: TextStyle(fontSize: 18, color: Colors.black),)
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

            ],
          ),
        ),
      ),
    );
  }
  

  Future<void> _daftar() async {      
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
      'passwd' : _passwd,
      'first_name' : nama_depan,
      'last_name' : nama_belakang,
      'no_ktp' : no_ktp,
      'phone' : no_hp 
    }; 
    // print ('headers $headers');
    print ('data $data');

    apiLogin.daftar( headers, jsonEncode(data) ).then((v) {

        bool? status = v!.status;
        String? msg = v.message;

        if(status == false){
          snackAlert('Error',  '$msg');
          setState(() { isLoad = false; }); 
          return;
        }
         
        if(msg != 'sukses'){
          // error is_unique
          defaultDialogErr(msg!);
          setState(() { isLoad = false; }); 
          return;
        }          
          print('Next Ok');
          Get.off(() => const DaftarSukses());

    });  
  }

  List<String> listBranchname = [];
  Map<String, String> mapBranch = {};

  Future<void> _getDealer()async {
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

    apiLogin.dealerPartisipan(headers).then((value){
      
      bool? stat = value!.status;
      if(stat == false){
        return;
      } 


      for (var element in value.data!) {
        print('element  ${element.branchName}');
        setState(() {
          listBranchname.add('${element.branchName}');
          mapBranch['${element.branchName}'] = '${element.kota}' ;
        });
      }

      setState(() => msgAPiDealerpartisipasi = value.message );

    });

  }

}