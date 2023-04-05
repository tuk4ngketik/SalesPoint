// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:convert';
 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sales_point/Apis/a_harga.dart';
import 'package:sales_point/Helper/get_key.dart'; 
import 'package:sales_point/Helper/tanggal.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Models/G/PriceController.dart';
import 'package:sales_point/Views/Harga/kaca_belakang.dart';
import 'package:sales_point/Views/Harga/kaca_depan.dart';
import 'package:sales_point/Views/Harga/kaca_samping.dart';
import 'package:sales_point/Views/Harga/kaca_sunroof.dart';

import '../Cfg/css.dart';
import 'Harga/merek.dart';  

class Harga extends StatefulWidget{
  const Harga({super.key});
  @override
  _Harga createState() => _Harga(); 
} 

class _Harga extends State<Harga>{

  PriceController priceController = Get.put(PriceController());
  ApiHarga apiHarga = ApiHarga();
  
   Tanggal tgl = Tanggal();  
   var headers ;
   List<String> mereks = [];

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
    _getMerek();
  }
   
  _getMerek(){
    apiHarga.merek(headers).then((v){
      bool? status = v!.status;
      if(status == false){
          snackAlert('Error',  '${v.message}'); 
          return; 
      }
       v.data!.forEach((element) { 
        setState(()=>  mereks.add('${element.carBrand}') );
      });
    }); 
  }

  @override
  void initState() { 
    super.initState();
    _initPackageInfo();  
    total = 0;
    // Clear Harga Kaca
      priceController.set_kacaDepan([]);
      priceController.set_kacaBelakang([]);
      priceController.set_kacaSamping([]);
      priceController.set_kacaSunroof([]);
      priceController.clear_subTotal();
  } 
  int diskon = 0; 
  @override
  Widget build(BuildContext context){
    
    _total(  diskon.toInt(),  priceController.subtotal.toInt() );
    
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        // backgroundColor: Colors.black87,
        backgroundColor: Colors.black,
        toolbarHeight: 120,
        shape: Css.roundBottomAppbar,  
        title: Column(
          children: const [ 
            Icon(Icons.monetization_on_outlined, color: Colors.white, size: 80,), 
            Text('Harga', style: TextStyle(color: Colors.amber)),
          ],
        ),
        centerTitle: true, 
      ),
      body: (mereks.isEmpty) ? const Center(child: CircularProgressIndicator(),) :  Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              padding: const EdgeInsets.all (20),
              children : [        
                
                // Merek n Tipe
                Merek(listMerek: mereks), 
                
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 0, right: 0),
                  title:  Text('Kaca Depan', style: Css.labelHarga,), 
                  subtitle: Obx(() => ( priceController.kacaDepan.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaDepan()),
                ),
            
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 0, right: 0),
                  title:   Text('Samping', style: Css.labelHarga,), 
                  subtitle: Obx(() => ( priceController.kacaSamping.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaSamping()),                
                ),  
            
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 0, right: 0),
                  title:   Text('Belakang', style: Css.labelHarga,),
                  subtitle: Obx(() => ( priceController.kacaBelakang.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaBelakang() ),
                ),  

                ListTile(
                  contentPadding: const EdgeInsets.only(left: 0, right: 0),
                  title:   Text('Sun Roof', style: Css.labelHarga,),
                  subtitle: Obx(() => ( priceController.kacaSunroof.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaSunroof()),
                ), 

                const Divider(),
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.black,
                  child: Row(   
                        children: [
                          Text('Sub Total', style: Css.labelHarga,),  
                          Flexible(
                            flex:8,
                            child: Align(
                              alignment: Alignment.centerRight, 
                              child:  Obx(() => Text( rupiah('Rp ', priceController.subtotal.toInt(), 2), style: Css.labelTarif,), ),
                            ),
                          ), 
                        ],
                  ),
                ), 

                Container(
                  color: Colors.grey,
                  child: TextField(     
                    style: const TextStyle(color: Colors.white),
                    decoration:  InputDecoration(  
                      hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      hintText: '$diskon',
                      prefix: const Text('Diskon'),
                      contentPadding: const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
                      // fillColor: Colors.red,
                      // focusColor: Colors.yellow,
                      suffixIcon: const Icon(Icons.percent), 
                      // border:                       
                      focusedBorder:const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        gapPadding: 0,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ), 
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        gapPadding: 0,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ) 
                    ),
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    onChanged: (value) { 
                      if (value.length > 1 && GetUtils.isNum(value) == false ){
                        snackError('Error', 'Diskon harus angka');
                        setState(() => diskon =  30 );
                        return;
                      }
                      if( value.length > 1 && int.parse(value) > 30){
                        snackError('Error', 'Max diskon 30%'); 
                        setState(() => diskon = 30 );
                        return;
                      }
                      setState(() => diskon =  int.parse(value) );
                      _total(  diskon.toInt(),  priceController.subtotal.toInt() );
                    },
                  ),
                ),  

                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.black,
                  child: Row( 
                        children: [
                          Center(child: Text('Total', style: Css.labelTarif,)),
                          Flexible(
                            flex:8,
                            child: Align(
                              alignment: Alignment.centerRight, 
                              child: Text( rupiah('Rp ', total.toInt(), 2), style: Css.labelTarif,),
                            ),
                          ),  
                        ],
                  ),
                ),

              ],
            ),
          ),
    );
  }

  double total = 0;
  _total(int diskon, int subtotal){
    double dec = diskon / 100;                          // diskon / 100 = 0,3
    double potongan = subtotal * dec;                   // 4.500.000 x 0,3 = 1.500.00
    setState(() =>  total = subtotal - potongan );      // 4.500.000 - 1.500.000 = 3.500.000 
  }

}//End