// ignore_for_file: library_private_types_in_public_api, avoid_print, annotate_overrides, unused_field, non_constant_identifier_names, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables

// import 'dart:convert';

import 'dart:io';

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart'; 
import 'package:image_picker/image_picker.dart'; 
import 'package:sales_point/Apis/a_dealer.dart';
import 'package:sales_point/Apis/a_login.dart';  
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Helper/myapp-attr.dart';
  import 'package:sales_point/Helper/rgx.dart';
import 'package:sales_point/Views/main-page.dart'; 
  import '../Cfg/css.dart';
  import '../Helper/wg.dart';

class Kelengkapan extends StatefulWidget{
  const Kelengkapan({super.key}); 
  _Kelengkapan createState() => _Kelengkapan(); 
} 

class _Kelengkapan extends State<Kelengkapan>{
  
  MyappAttr myappAttr = MyappAttr(); // Headers 
  ApiDealer apiDealer = ApiDealer(); // get dealer
  ApiLogin apiLogin = ApiLogin();    // send kelengkapan data 
  Sess sess = Sess();
  
  List<String> listBranchname = []; 
  Map<String, String> mapBranchSerial = {};    

  String? msgAPiDealerpartisipasi;
  var headers;

  final ImagePicker imagePicker = ImagePicker();
  XFile? image ;  
  String? pathFoto, pathKtp ; 
  final ImagePicker picker = ImagePicker(); 
  
  bool visiblePass =  false;
  bool isLoad =  false; 
  final _formKey = GlobalKey<FormState>();
  String?  serial, company_serial, branch_serial, no_ktp, alamat; 

  final _branchName = TextEditingController(); 
  
  void initState() { 
      super.initState(); 
      sess.getSess('serial').then((value) => setState(() => serial = value ) ); 
      myappAttr.retHeader().then((value)  { 
        setState(() => headers = value );  // headers 
        _getDealer(value);
      });  
  }
 
  void dispose() {
    super.dispose();   
    _branchName.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Kelengkapan Data'),
      ),
      body: Center(
        child : Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),  
                  children: [ 
                      
                    InkWell(
                      onTap: () => _getCapture('pic'),
                      child: Center(
                        child: (pathFoto != null ) ? imgCapture(  pathFoto! ) 
                        : Container( 
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: const Center(child: Text('Foto'))
                        ),
                      ),
                    ), 
                
                    labelFormWhite('Dealer'), 
                    EasyAutocomplete( 
                      suggestionBackgroundColor: Colors.black87, 
                      suggestions:  listBranchname ,  
                      controller: _branchName, 
                      suggestionTextStyle: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white
                      ),
                      onChanged: (v) {
                        _branchName.text = v;
                        print('onChanged ${_branchName.text}');
                        setState(() => branch_serial = mapBranchSerial[v] ); 
                        print('branch_serial $branch_serial}');
                      },
                      decoration:  InputDecoration(        
                        hintText: 'Pilih Dealer',    
                        border: Css.roundInput20,   
                        enabledBorder:  Css.roundInput20,    
                        prefixIcon: const Icon(Icons.work_history , color: Colors.black),
                        labelStyle: Css.labelStyle,
                        filled: true,
                        fillColor: Colors.white, 
                        suffixIcon:  (   branch_serial == null) ? null :  IconButton(
                          onPressed: (){  
                            setState(() =>  branch_serial = null );
                            _branchName.clear(); 
                          },
                          icon: const Icon(Icons.close),
                        ),    
                      ), 
                      validator: (value) {  
                        if(value!.isEmpty){
                          return 'Lengkapi Dealer';
                        } 
                        return null;
                      },
                    ),
                    br(10),
                        
                    // No KTP
                      labelFormWhite('No. KTP'),
                      TextFormField( 
                        decoration:  InputDecoration(       
                          // labelText: 'No. KTP',
                          hintText: 'ID / KTP',    
                          border: Css.roundInput20,   
                          enabledBorder:  Css.roundInput20,    
                          prefixIcon: const Icon(Icons.person_pin_outlined, color: Colors.black),
                          // labelStyle: Css.labelKelengkapan,
                          filled: true,
                          fillColor: Colors.white,
                        ),  
                        onSaved: (v) => no_ktp = v,
                        validator: (value) { 
                          value =  value!.trim();
                          if(value.isEmpty){
                            return 'Lengkapi KTP';
                          }
                          if( numberOnly(value) == false){
                            return 'KTP harus angka';
                          }
                          if(  value.length < 16  || value.length > 16 )  {
                            return 'KTP harus 16 karakter';
                          } return null;
                        },
                      ),br(10),
                    //
                
                    // Alamat
                    labelFormWhite('Alamat'),
                    TextFormField( 
                        maxLines: 2,
                        decoration:  InputDecoration(     
                          // labelText: 'Alamat',
                          hintText: 'Alamat lengkap',    
                          border: Css.roundInput20,   
                          enabledBorder:  Css.roundInput20,    
                          prefixIcon: const Icon(Icons.streetview_rounded, color: Colors.black),
                          labelStyle: Css.labelStyle,
                          filled: true,
                          fillColor: Colors.white,
                         ), 
                        onSaved:(newValue) => alamat = newValue,
                        validator: (value) { 
                          value =  value!.trim();
                          if(value.isEmpty){
                            return 'Lengkapi Alamat';
                          } 
                          if(  value.length < 20  || value.length > 200 )  {
                            return 'Kolom alamat  mon 20 karakter';
                          }
                          return null;
                        },
                    ), br(10),
                    // 
                    // Img KTP
                    Container(
                      height: 50,   
                      // child: (pathKtp == null) ? const Center(child: Text('Belum ada foto KTP')) : const Icon(Icons.image, color: Colors.green,),
                      decoration:   const BoxDecoration(
                          color: Colors.white,   
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      child: Row(children: [
                        Expanded(
                          flex: 8,
                          child: Center(
                            child: (pathKtp == null) ? const Text('Belum ada KTP') 
                                 :  InkWell(
                                    onTap: () => openImage(pathKtp!),
                                    child: const Text('KTP',style: TextStyle(fontWeight: FontWeight.bold), )
                                  )
                          )
                        ),  
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: IconButton( 
                              color: Colors.grey, icon: const Icon(Icons.image), 
                              onPressed: () => _getCapture('pic_ktp'),
                            ),  
                          )
                        ),  
                      ],),
                    ),
                    br(10), 
                  ],
                ),
              ), 
              
              // Buttun Kirim
              Padding(padding: const EdgeInsets.all(20),
                child: Container(
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
                            _sendKelengkapan();
                          },
                          child:  Center(
                            child: ( isLoad == true ) 
                              ? const CircularProgressIndicator(color: Colors.orange,)
                              : const Text('Kirim', style: TextStyle(fontSize: 18, color: Colors.black),)
                              // : const Icon(Icons.send)
                          ),
                        ),
                    )
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
  
  _getDealer(var headers)  { // OK    
      apiDealer.dealerPartisipan( headers ).then((v){ 
        var d = v!.data;  
        d!.forEach((element) {
          setState(() {
            listBranchname.add('${element.branchName}');
            mapBranchSerial['${element.branchName}'] = '${element.serial}';
          });
        });
      });  
  }

  _getCapture(String pic_or_ktp) async { 
    // Capture a photo.
    // final XFile? photo = await picker.pickImage(source: ImageSource.camera);  
    image  = await picker.pickImage(source: ImageSource.camera); 
    setState(() {
      // pathFoto = photo!.path;
      (pic_or_ktp == 'pic') ? pathFoto = image!.path : pathKtp = image!.path ;  
    }); 
  } 
 
  _sendKelengkapan(){ 

    Map<String, String> dataBody = {
      'serial': '$serial',
      'branch_serial': '$branch_serial',
      'no_ktp': '$no_ktp',
      'alamat': '$alamat',
      'pic' : '$pathFoto',
      'img_ktp' : '$pathKtp',  
    };

    print('headers $headers'); 
    print('dataBody $dataBody'); 
    if(pathFoto == null){
      defaultDialogErr('Belum ada foto diri anda');
      return;
    }
    if(pathKtp == null){
      defaultDialogErr('Belum ada foto KTP');
      return;
    }
    setState(() =>  isLoad = true );
    apiLogin.kelengkapanData(headers, dataBody, pathFoto!, pathKtp!).then((v) {
      
        bool? status = v!.status;
        String? msg = v.message;
        if(status == false){
          snackAlert('Error',  '$msg');
          setState(() { isLoad = false; }); 
          return;
        }
        
        var data = v.data!; 
        Sess sess = Sess();
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

        // Back to Home n New Session
        defaultDialogSukses('Terima kasih telah melengkapi data',  MyHomePage(serial:'${data.serial}',namaLengkap: '${data.firstName}', kelengkapan: '${data.kelengkapan}' ) );
        // defaultDialogSukses('Terima kasih telah melengkapi data',const MyHomePage());
         
    });
    
  }


 Widget imgCapture(String path){
    return CircleAvatar(
      backgroundColor: Colors.white,
            radius: 100, 
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),  
              child:   Image.file( File(path) , 
                                   height: 195,
                                   width: 195,
                                  fit: BoxFit.cover,                                   // fit: BoxFit.contain, 
                                  // fit: BoxFit.fill, 
                                  // filterQuality: FilterQuality.low,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) { 
                                    return const Center(child: Text('😢 Image Not Found  😢'));
                                  },   
                    ),
            ),
    );
 }


}