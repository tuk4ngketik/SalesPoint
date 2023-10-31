// ignore_for_file: library_private_types_in_public_api, avoid_print, annotate_overrides, unused_field, non_constant_identifier_names, unused_element

// import 'dart:convert';

import 'dart:convert'; 
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:package_info_plus/package_info_plus.dart'; 
  import 'package:sales_point/Apis/a_login.dart';
  import 'package:sales_point/Cfg/sess.dart';
  import 'package:sales_point/Helper/rgx.dart';
  import 'package:sales_point/Helper/tanggal.dart';
  import 'package:sales_point/Views/verifikasi.dart';
  import 'package:sales_point/Views/login.dart';  
  import '../Cfg/css.dart';
  import '../Helper/wg.dart';

class Daftar extends StatefulWidget{
  const Daftar({super.key}); 
  _Daftar createState() => _Daftar(); 
} 

class _Daftar extends State<Daftar>{
  
  Sess sess = Sess();
  final now = DateTime.now(); 
  Tanggal tgl = Tanggal(); 
  ApiLogin apiLogin = ApiLogin();
  String? msgAPiDealerpartisipasi;

  bool visiblePass =  false;
  bool isLoad =  false; 
  final _formKey = GlobalKey<FormState>();
  String? _email, _passwd, _passwdKonfirm, nama_lengkap,  no_hp ;
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
    // _getDealer(); 
  }
  
  void initState() { 
      super.initState();
      // sess.destroy(); // clear session
      _initPackageInfo(); 
  }
 
  void dispose() {
    super.dispose();  
    passwd_.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      // backgroundColor: Colors.black,
      // drawer: const DonDrawer(),
      
      body: Container(        
        decoration: const BoxDecoration(
          image: DecorationImage( 
            image: AssetImage("images/bg3.jpg"), 
            // image: AssetImage("images/ikool-app-bg.png"),  
            fit: BoxFit.cover,
          ),
        ),

        child: Center( 
          child: 
          // (msgAPiDealerpartisipasi == null) ? const CircularProgressIndicator() : 
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form( key : _formKey,
              child: SingleChildScrollView(
                child: Opacity(opacity: 0.75,
                  child: Card(
                    shape:  Css.round20,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           
                          const Text('Registrasi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber),),  
                          const Divider(color: Colors.amber,),
                          br(20), 
                          
                          // NAma LEngkap 
                          TextFormField( 
                            style: const TextStyle(  fontWeight: FontWeight.bold),
                            // initialValue: 'Nama Saya',
                             decoration:  InputDecoration(       
                              labelText: 'Nama Lengkap',     
                              hintText: 'Nama Lengkap',
                              border: Css.roundInput20, 
                              enabledBorder:  Css.roundInput20,     
                              prefixIcon: const Icon(Icons.person, color: Colors.black),
                              labelStyle: Css.labelStyle,
                              filled: true,
                              fillColor: Colors.black12,
                             ), 
                            onSaved:(newValue) => nama_lengkap = newValue,
                            validator: (value) { 
                              if(value!.isEmpty){
                                return 'Lengkapi Nama Lengkap';
                              }
                              if(value.length < 3){
                                return 'Min 3 karakter';
                              }
                              if( namaLengkap(value) == false){
                                return 'Karakter tidak valid ';
                              }
                              return null;
                            },
                          ), 
                          br(12),
                              
                          // No KTP
                          // TextFormField( 
                            //    decoration:  InputDecoration(       
                            //     labelText: 'Identity Number',
                            //     hintText: 'ID / KTP',    
                            //     border: Css.roundInput20,   
                            //     enabledBorder:  Css.roundInput20,    
                            //     prefixIcon: const Icon(Icons.tag, color: Colors.black),
                            //     labelStyle: Css.labelStyle,
                            //     filled: true,
                            //     fillColor: Colors.black12,,
                            //    ), 
                            //   onSaved:(newValue) => no_ktp = newValue,
                            //   validator: (value) { 
                            //     if(value!.isEmpty){
                            //       return 'Indentity Lengkapi';
                            //     }
                            //     if( numberOnly(value) == false){
                            //       return 'Number only';
                            //     }
                            //     if(  value.length < 16  || value.length > 16 )  {
                            //       return '16 Digit Characters';
                            //     }
                            //     return null;
                            //   },
                          // ),
                          // br(12),
                              
                          // No Handphone
                          TextFormField( 
                            style: const TextStyle(  fontWeight: FontWeight.bold),
                            // initialValue: '087784509065',
                             decoration:  InputDecoration(       
                              labelText: 'No. HP / Whatsapp',
                              hintText: 'No.Hp / Whatsapp',    
                              border: Css.round20,      
                              enabledBorder:  Css.roundInput20, 
                              prefixIcon: const Icon(Icons.phone, color: Colors.black),
                              labelStyle: Css.labelStyle,
                              filled: true,
                              fillColor: Colors.black12,
                             ), 
                            onSaved:(newValue) => no_hp = newValue,
                            validator: (value) { 
                              if(  value!.isEmpty )  {
                                return 'Lengkapi No. HP';
                              } 
                              if( numberOnly(value) == false){
                                return 'Harus angka';
                              }
                              if(  value.length < 10  || value.length > 15 || kosongLapan(value) == false )  {
                                return 'No. HP tidak valid';
                              } 
                              return null;
                            },
                          ),
                          br(12),
                              
                          // Email 
                          TextFormField( 
                            style: const TextStyle(  fontWeight: FontWeight.bold),
                            // initialValue: 'tuk4ng.ketik@gmail.com',
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
                              enabledBorder:  Css.roundInput20,   
                              prefixIcon: const Icon(Icons.email, color: Colors.black),
                              labelStyle: Css.labelStyle,
                              labelText: 'Email',
                              hintText: 'your@mail.com',
                              filled: true,
                              fillColor: Colors.black12,
                             ), 
                          ),
                          br(12),
                              
                          // Password 
                          TextFormField( 
                            style: const TextStyle(  fontWeight: FontWeight.bold),  
                            // initialValue: 'qqqqqq',
                            onSaved:(newValue) => _passwd = newValue,
                            controller: passwd_,
                            validator: (value) {
                              if(value!.isEmpty  ){
                                return 'Lengkapi Kata Sandi';
                              }
                              if( value.length < 6 || value.length > 15){
                                return 'Kata Sandi min 6 s/d  15 karakter';
                              }
                              return null;
                            },
                            obscureText: (visiblePass ==  false) ? true : false,
                            decoration:  InputDecoration(        
                              labelStyle: Css.labelStyle,
                              labelText: 'Kata Sandi',   
                              border: Css.round20, 
                              enabledBorder:  Css.roundInput20, 
                              prefixIcon: const Icon(Icons.lock_open, color: Colors.black),
                              hintText: ' - - - - -',  
                              filled: true,
                              fillColor: Colors.black12,
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
                          br(10),
                              
                          // Password Konfirm
                          TextFormField( 
                            // initialValue: 'qqqqqq',
                            style: const TextStyle(  fontWeight: FontWeight.bold),  
                            obscureText: (visiblePass ==  false) ? true : false,
                            decoration:  InputDecoration(        
                              labelStyle: Css.labelStyle,
                              labelText: 'Konfirmasi Kata Sandi',   
                              border: Css.round20, 
                              enabledBorder:  Css.roundInput20, 
                              prefixIcon: const Icon(Icons.password, color: Colors.black),
                              hintText: ' - - - - -',  
                              filled: true,
                              fillColor: Colors.black12,
                            ),
                            onSaved:(newValue) => _passwdKonfirm = newValue,
                            validator: (value) {
                              if(value!.isEmpty){
                                return 'Lengkapi Konfirmasi Kata Sandi'; 
                              }
                              if(value != passwd_.text ){
                                return 'Kata Sandi & Konfirmasi tidak sama';  
                              }
                              return null;
                            },
                          ),
                               
                          br(20), 
                          Container(
                            // color: Colors.yellow,
                              decoration: const BoxDecoration(
                                color: Colors.amber,   
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
                                        : const Text('Register', style: TextStyle(fontSize: 18, color: Colors.black),)
                                        // : const Icon(Icons.send)
                                    ),
                                  ),
                              )
                          ),
                          br(10), 

                          Center(
                            child: TextButton.icon(
                              onPressed: ()=>Get.to(const Login()), 
                              icon: const Icon(Icons.login, color: Colors.red,), 
                              label: const Text('Login', style: TextStyle(fontSize: 18, color: Colors.red),) 
                            ),
                          )
                          
                      ],),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  

  Future<void> _daftar() async {     

    setState(() { isLoad = true; }); 
    String pckDate = base64.encode(utf8.encode( tgl.dmy() )); 
    String pckName = base64.encode(utf8.encode( _packageInfo.packageName));   
    print (' _packageInfo.packageName ${ _packageInfo.packageName}');
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
      'nama_lengkap' : nama_lengkap,
      'phone' : no_hp
      // 'company_serial' : company_serial, 
      // 'branch_serial' : branch_serial,
      // 'no_ktp' : no_ktp,
    }; 
    print ('headers $headers');

    apiLogin.daftar( headers, jsonEncode(data) ).then((v) {

        bool? status = v!.status;
        String? msg = v.message;

        if(status == false){
          defaultDialogErr(msg!); 
          setState(() { isLoad = false; }); 
          return;
        }
        
        // sess.setSess('serial', msg!);
        sess.setSess('status_app', 'register');
        sess.setSess('namaLengkap', nama_lengkap!);
        sess.setSess('email',  '$_email');
        sess.setSess('phone',  no_hp!);  
        Get.offAll(() => const Verifikasi());
    });  

  }

  List<String> listBranchname = [];
  Map<String, String> mapBranch = {};
  Map<String, String> mapCompanySerial = {}; // INsert from tb company_branch.cmpany_serial
  Map<String, String> mapBranchSerial  = {};    // INsert from tb company_branch.serial

  // Future<void> _getDealer()async {
    //   String pckDate = base64.encode(utf8.encode( tgl.dmy() )); 
    //   String pckName = base64.encode(utf8.encode( _packageInfo.packageName));       
    //   var headers = {
    //     'pckname': pckName,
    //     'pckdate': pckDate,
    //     'appversion':  _packageInfo.version, 
    //     'targetpath': 'c2lzdGVtZ2FyYW5zaS5jb20vc2l0ZS9hcGk=',
    //     'apikey': 'aUtvb2wtU2FsZXMtUG9pbnQ',  
    //     'Content-Type': 'application/json'
    //   };
    //   apiLogin.dealerPartisipan(headers).then((value){        
    //     bool? stat = value!.status;
    //     if(stat == false){
    //       return;
    //     }
    //     for (var element in value.data!) {
    //       print('element  ${element.branchName}');
    //       setState(() {
    //         listBranchname.add('${element.branchName}');
    //         mapBranch['${element.branchName}'] = '${element.kota}' ;
    //         mapCompanySerial['${element.branchName}'] = '${element.companySerial}';
    //         mapBranchSerial['${element.branchName}'] = '${element.serial}';
    //       });
    //     }
    //     setState(() => msgAPiDealerpartisipasi = value.message );
    //   });
  // }

}