// ignore_for_file: library_private_types_in_public_api, avoid_print, annotate_overrides, unused_local_variable

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_point/Apis/a_katalog.dart';
import 'package:sales_point/Helper/myapp-attr.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Models/m_katalog_otomotif.dart';
// import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';  

class Katalog extends StatefulWidget{
  const Katalog({super.key});
  @override
  _Katalog createState() => _Katalog();
  
} 

class _Katalog extends State<Katalog>{

  ApiKatalog apiKatalog = ApiKatalog();
  MyappAttr myappAttr = MyappAttr();
  late List<DataKatalogOtomotif> dataOtomotif = [];
  bool isLoad = false;

  initState(){
    super.initState();
    myappAttr.retHeader().then((v) {
      _getKatalogOtomotif( v );
    }); 
  } 

  _getKatalogOtomotif(var headers){
    setState(()  => isLoad =  true) ;
    apiKatalog.getKatalogOtomotif(headers).then((v) {
      bool? status = v!.status;
      String? msg = v.message;
      if( status ==  false ){
        defaultDialogErr(msg!);
        return;
      }
      var data = v.data;
      setState(() {
        dataOtomotif = v.data!;
        setState(()  => isLoad =  false) ;
      });
      // for (var element in dataOtomotif) {
      //   print('el ${element.serial} => ${element.productName}');
      // }
    })
    .catchError((e){
      setState(()  => isLoad =  false) ;
      snackError('Error Katalog', '${e.msg}');
    });
  }
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87, 
        title: const Text('Katalog'),
      ),
      
      body: Container(
        height: Get.height,
        decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.black87, Colors.black38,Colors.black87,])
                ),
        // child: (dataOtomotif.isEmpty) ? const Center(child: CircularProgressIndicator(),) : ListView.builder(
        child: (isLoad == true ) ? const Center(child: CircularProgressIndicator(),) : ListView.builder(
          // padding: const EdgeInsets.all(0),
          itemCount: dataOtomotif.length,
          itemBuilder: (context, i) { 
                String x =  dataOtomotif[i].file.toString(); 
                return Container( 
                  margin: const EdgeInsets.all(20),
                  child: Image.memory( base64Decode( x.substring(23)  ), 
                                    // filterQuality: FilterQuality.low,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.contain ,
                                    // fit: BoxFit.fill ,
                                    // fit: BoxFit.cover ,
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) { 
                                    return const Center(child: Text('😢 Image Not Found  😢'));
                                  },   
                        ),
                );
                
              },),
      ),
    );
  }

}