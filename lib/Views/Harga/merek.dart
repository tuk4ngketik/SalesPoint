// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, non_constant_identifier_names
 
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sales_point/Apis/a_harga.dart';
import 'package:sales_point/Cfg/css.dart';
// import 'package:sales_point/Apis/a_harga.dart';
import 'package:sales_point/Helper/tanggal.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Models/G/PriceController.dart';
import 'package:sales_point/Views/Harga/tipe.dart'; 

class Merek extends StatefulWidget{  
  final List<String> listMerek; 
  const Merek({super.key,  required this.listMerek});
  @override
  _Merek createState() => _Merek();
  
} 

class _Merek extends State<Merek>{ 

  PriceController priceController = Get.put(PriceController());
  ApiHarga apiHarga = ApiHarga();
 
  Tanggal tgl = Tanggal();  
  var headers, body;
  String? car_brand;
  List<String> carTypes = [];

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
  
  @override
  void initState() { 
    super.initState(); 
    _initPackageInfo();
  }

  _getTipe(String car_brand){  
    body ={
      'car_brand' : car_brand
    };
    apiHarga.tipe(headers, jsonEncode(body) ).then((value){
       
      if(value!.status == false){
        snackAlert('Error',  '${value.message}'); 
        return;
      }
      var data = value.data;
      // print('Data $data');
      data!.forEach((element) {
        // print('element ${element.carBrand} : ${element.carType}');
        setState(() {
          carTypes.add('${element.carType}');
        });
      });

    });
  }

  @override
  Widget build(BuildContext context){ 
    
    return Column(
      children: [
 
        ListTile(
          contentPadding: const EdgeInsets.only(left: 0, right: 0),
          title: Text('Merek', style: Css.labelHarga,),
            subtitle :  DropdownButtonFormField<String>(
              menuMaxHeight: Get.height/2,    
              decoration: const InputDecoration(    
              contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30) ), 
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white24) ), 
              border: OutlineInputBorder( 
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gapPadding: 0,
              ), 
            ),
            dropdownColor: Colors.blueGrey, 
            style: const TextStyle(
              color: Colors.white,  
              fontWeight: FontWeight.bold,
              letterSpacing: 1
            ),   
              hint: const Text('-- Pilih Merek -- '),   
              onChanged: (String? v) {   
                setState(() =>  carTypes = [] );
                print('Merek :  $v');   
                priceController.setBrand('$v');
                priceController.set_kacaDepan([]);
                priceController.set_kacaBelakang([]);
                priceController.set_kacaSamping([]);
                priceController.set_kacaSunroof([]);
                _getTipe(v!);
              }, 
              items: widget.listMerek.map<DropdownMenuItem<String>>((String value){
                return DropdownMenuItem<String>( value: value, child: Text(value), ); 
              }).toList(), 
          ),             
        ), 

        ListTile(
          contentPadding: const EdgeInsets.only(left: 0, right: 0),
          title: Text('Tipe', style: Css.labelHarga,),
          subtitle: (carTypes.isEmpty) ? const Text(' -- Pilih Tipe --  ')  : CarType(listTipe: carTypes) ,
        ),
 

      ],
    );

  } 
}//End