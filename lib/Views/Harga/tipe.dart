// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, annotate_overrides
 
import 'dart:convert';

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sales_point/Apis/a_harga.dart';
import 'package:sales_point/Helper/tanggal.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Models/G/PriceController.dart'; 

class CarType extends StatefulWidget{  
  final List<String> listTipe;

  const CarType({super.key, required this.listTipe});  
  @override
  _CarType createState() => _CarType();
  
} 

class _CarType extends State<CarType>{ 
 
  PriceController priceController = Get.put(PriceController());
  ApiHarga apiHarga = ApiHarga();

  Tanggal tgl = Tanggal();  
  var headers, body;  
  // Headers 
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown', packageName: 'Unknown',  version: 'Unknown',
    buildNumber: 'Unknown',  buildSignature: 'Unknown', 
  ); 

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() =>  _packageInfo = info ); 
    _getHeader();
  } 

  _getHeader(){
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
  }
  
  void initState() { 
    super.initState(); 
    _initPackageInfo();
  }

  void dispose(){
    super.dispose();
    _type.dispose();
  }
  
  final _type = TextEditingController();

  List<String> kacaDepan = [];
  List<String> kacaBelakang = [];
  List<String> kacaSamping = [];
  List<String> kacaSunRoof = [];

  @override
  Widget build(BuildContext context){ 

      // return DropdownButtonFormField<String>(  
      //         menuMaxHeight: Get.height/2,    
      //         decoration: const InputDecoration(    
      //         contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
      //         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30) ), 
      //         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white24) ), 
      //         border: OutlineInputBorder( 
      //           borderRadius: BorderRadius.all(Radius.circular(10)),
      //           gapPadding: 0,
      //         ), 
      //       ),
      //       dropdownColor: Colors.blueGrey, 
      //       style: const TextStyle(
      //         color: Colors.white,  
      //         fontWeight: FontWeight.bold,
      //         letterSpacing: 1
      //       ),   
      //     hint: const Text('-- Pilih Tipe -- '),     
      //     onChanged: (String? v) {  
      //           // Clear Harga Kaca
      //           _clearKaca();

      //           // Set tipe
      //             priceController.setTipe('$v');
      //             print('Brand : ${priceController.brand} :: Tipe :  $v');   

      //           // Set List Harga
      //             _hargaByPosisi( 'Depan' );
      //             _hargaByPosisi( 'Belakang' );
      //             _hargaByPosisi( 'Samping' ); 
      //             _hargaByPosisi( 'Sun Roof' );
      //     }, 
      //     items: widget.listTipe.map<DropdownMenuItem<String>>((String value){
      //       return DropdownMenuItem<String>( value: value, child: Text(value), ); 
      //     }).toList(), 
      // ); 
      return EasyAutocomplete(  
            controller: _type,
            decoration:   InputDecoration(   
              suffixIcon:  ( _type.text.isNotEmpty)  ? IconButton(
                onPressed: (){ 
                  _clearKaca();
                  _type.clear();  
                },
                icon: const Icon(Icons.close),
              ) : null,   
              contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
              border: const OutlineInputBorder( 
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gapPadding: 0,
              ), 
            ),
            suggestions:  widget.listTipe,
            onChanged: (value)  {
              _clearKaca() ; 
            },  
            onSubmitted: (v){    
                _clearKaca();
                // Set tipe
                priceController.setTipe(v);
                print('Brand : ${priceController.brand} :: Tipe :  $v');   

                // Set List Harga
                _hargaByPosisi( 'Depan' );
                _hargaByPosisi( 'Belakang' );
                _hargaByPosisi( 'Samping' ); 
                _hargaByPosisi( 'Sun Roof' );
                _type.text = v;
            }, 
          );

  }  

  _hargaByPosisi(String posisi ){
    // setState(() {
    //   jenisKaca = [];
    // });
    var body = {  
        "car_brand" : "${priceController.brand}",
        "car_type" : "${priceController.tipe}",
        "posisi" : posisi 
    }; 
    apiHarga.harga(headers, jsonEncode(body) ).then((v){
      if(v!.status == false){
        snackAlert('Error',  '${v.message}'); 
        return; 
      }
      if(v.data!.isEmpty){
        return;
      }
      var data = v.data; 
      
      if(posisi == 'Depan') {
        priceController.set_kacaDepan( data ); 
      }
      if(posisi == 'Samping') {
        priceController.set_kacaSamping( data ); 
      }
      if( posisi ==  'Belakang'){ 
        priceController.set_kacaBelakang( data ); 
      }
      if( posisi ==  'Sun Roof'){ 
        priceController.set_kacaSunroof( data ); 
      }

      // v.data!.forEach((element) {
      //   jenisKaca.add('${element.hargaJual}'); 
      // });

      // print('posisi $posisi $jenisKaca'); 

    }); 
  }
  
  void _clearKaca(){ 
    priceController.set_kacaDepan([]);
    priceController.set_kacaBelakang([]);
    priceController.set_kacaSamping([]);
    priceController.set_kacaSunroof([]); 
    priceController.clear_subTotal();
  }

}//End