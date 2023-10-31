// ignore_for_file: library_private_types_in_public_api, avoid_print, annotate_overrides, unused_field, non_constant_identifier_names, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, sized_box_for_whitespace, file_names

// import 'dart:convert';

import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:image_picker/image_picker.dart'; 
import 'package:sales_point/Apis/a_dealer.dart';
import 'package:sales_point/Apis/a_login.dart';  
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Helper/myapp-attr.dart'; 
import 'package:sales_point/Views/Profil/edit-profil-akun.dart';
import 'package:sales_point/Views/Profil/edit-profil-data-pribadi.dart'; 
  import '../../Helper/wg.dart';

class ProfilEdit extends StatefulWidget{
  final serial, namaLengkap, email, telp, noKtp, alamat, pic, imgKtp; 
  const ProfilEdit({super.key, required this.serial, required this.namaLengkap, required this.email, required this.telp, required this.noKtp, required this.alamat, required this.pic, this.imgKtp}); 
  _ProfilEdit createState() => _ProfilEdit(); 
} 

class _ProfilEdit extends State<ProfilEdit> with TickerProviderStateMixin{
  
  MyappAttr myappAttr = MyappAttr(); // Headers 
  ApiDealer apiDealer = ApiDealer(); // get dealer
  ApiLogin apiLogin = ApiLogin();    // send ProfilEdit data 
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
  List<Widget> tabs = [
    Container(width: Get.width / 2, child: const Center(child: Text('Akun'))),
    Container(width: Get.width / 2,child: const Center(child: Text('Data Pribadi'))),
  ];
  
  late TabController tabController; 
  void initState() { 
      super.initState(); 
      sess.getSess('serial').then((value) => setState(() => serial = value ) ); 
      myappAttr.retHeader().then((value)  { 
        setState(() => headers = value );  // headers 
        _getDealer(value);
      });  
      
    tabController = TabController(length: tabs.length, vsync: this);
  }
 
  void dispose() {
    super.dispose();   
    _branchName.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      // backgroundColor: Colors.white70,
      appBar: AppBar( 
        backgroundColor: Colors.black,
        title: const Text('Edit Profil'), 
        bottom: TabBar( 
          indicatorColor: Colors.orange,
          labelStyle: const TextStyle(fontSize: 17, ),
          labelPadding: const EdgeInsets.all(10),
          isScrollable: true,
          tabs: tabs,
          controller: tabController, 
        )
      ), 

      body:   TabBarView( 
          controller: tabController,  
          children: <Widget>[  
            // page edit akun
            EditAkun( headers: headers , serial: widget.serial, namaLengkap: '${widget.namaLengkap}', email: '${widget.email}', telp: '${widget.telp}'),
            
            // page edit data pribadi
            EditDataPribadi(namaLengkap: widget.namaLengkap, noKtp: widget.noKtp, address: widget.alamat,  pic: widget.pic, img_ktp: widget.imgKtp)
          ],
      )
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
 
  _sendProfilEdit(){ 

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
    // setState(() =>  isLoad = true ); 
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