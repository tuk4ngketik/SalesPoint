// ignore_for_file: library_private_types_in_public_api, avoid_print, annotate_overrides, prefer_typing_uninitialized_variables, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_point/Apis/a_redeem.dart';
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Helper/get_key.dart';
import 'package:sales_point/Helper/myapp-attr.dart';
import 'package:sales_point/Helper/tanggal.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Models/m_items_redeeem.dart';
import 'package:sales_point/Views/Redeem/detail_item.dart';
import 'package:sales_point/Views/point.dart'; 
 

class Redeem extends StatefulWidget{
  final totalPoint;
  const Redeem({super.key, required this.totalPoint}); 
  _Redeem createState() => _Redeem();
  
} 

class _Redeem extends State<Redeem>{

  Sess sess = Sess();
  Tanggal tanggal = Tanggal();
  MyappAttr myappAttr = MyappAttr();
  ApiRedeem apiRedeem = ApiRedeem();
  var headers;
  List<DataItem> dataItem = [];
  int? totalPoint;
  String? serial_ikool, serial_reseller;
  bool isLoad =  false;

  @override
  void initState() { 
     super.initState();
     setState(() {
       totalPoint = int.parse(widget.totalPoint); 
     });
     myappAttr.retHeader().then((value){ 
      if(!mounted ){  return;  }
      setState(() =>  headers  = value ); 
      _getItemsRedeem();
     });
     sess.getSess('serial').then((v) => setState(() => serial_ikool = v) );
  }

  _getItemsRedeem(){
    setState(() =>  isLoad = true );
    apiRedeem.getItemsRedeem(headers).then((v){
      bool? status = v!.status;
      if(status == false ) return; 
      setState(()   {
        dataItem.addAll(v.data!);
        setState(() =>  isLoad = false );
      });
    })
    .catchError((e){
      setState(() =>  isLoad = false );
      snackError('Error Daftar Item Redeem', '${e.msg}'); 
    });
  }
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.black87, 
        // centerTitle: true, 
        // leading: Text('iKool Poin:  $totalPoint', style: TextStyle(color: Colors.grey, fontSize: 15),),
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text('Item Redeem', style: TextStyle(color: Colors.amber),),br(10),
            Text('iKool Poin:  $totalPoint', style: const TextStyle(color: Colors.grey, fontSize: 15),),
          ]), 
      ), 
      // body:  (dataItem.isEmpty ) ? const Center( child: CircularProgressIndicator() ,) : 
      body:  (isLoad == true ) ? const Center( child: CircularProgressIndicator() ,) : 
              ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: dataItem.length,
                itemBuilder: (context, i) {
                  // return Text( '$i ${dataItem[i].itemName}' );        
                  return Card( 
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () => _itemDetail(dataItem[i].serial!) ,
                        // leading:  Text('${dataItem[i].itemPoint}'),
                        leading:  Text( rupiah('', int.parse( dataItem[i].itemPoint!), 0) ), 
                        trailing: IconButton(onPressed: ()=>  _redeem(  totalPoint!,  int.parse( dataItem[i].itemPoint!), dataItem[i].serial!), 
                          icon: const Icon(Icons.redeem)
                        ),
                        title: Text('${dataItem[i].itemName}'), 
                        subtitle: Column( 
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
                           const Text('Masa berlaku'),
                            // Text('${dataItem[i].itemStart} -  ${dataItem[i].itemExpired}') 
                            Text( tanggal.convertTanggal('${dataItem[i].itemStart}')  + ' s/d '+   tanggal.convertTanggal('${dataItem[i].itemExpired}') ) 
                        ],),
                      ),
                    ),
                  );        
              },) 
    );
  }

  _redeem(int totalPoint, int itemPoint, String serial_item) {
      print('totalPOint $totalPoint itemPoint $itemPoint');
      if(totalPoint < itemPoint){
        defaultDialogErr('Poin tidak cukup');
        return;
      }    
      // Alert / Dialog Konfirmasi
      Get.defaultDialog(
        title: '',
        titlePadding: const EdgeInsets.all(10), 
        content: Column(children:   const [
          Icon(Icons.info_sharp, color: Colors.green, size: 40,),
          Divider(color: Colors.amber,),
          Text('Yakin ingin menukarkan poin')
        ],),
        textConfirm: 'Lanjutkan',
        confirmTextColor: Colors.black,
        buttonColor: Colors.yellow,
        textCancel: 'Batal',
        onConfirm: () =>  _prosesRedeem(serial_item)
      );
  }

  _itemDetail(String serial){
    
    apiRedeem.getItemsDetail(headers, serial).then((v){

      bool? status = v!.status;
      if(status == false ){
        defaultDialogErr('${v.message}');
      }
      var data = v.data;
      // data.itemName
      defaultBottomSheet(itemDetail(data: v.data, totalPoin: totalPoint,  ));
    });
  }

  _prosesRedeem(String serial_item){
      print("POST sendRedeem()");
      var data = {"serial_ikool" : serial_ikool ,  "serial_item" : serial_item }; 
      apiRedeem.sendRedeem(headers, jsonEncode(data)).then((v) {
        bool? status = v!.status;
        String? msg = v.message;
        if(status == false ){
          defaultDialogErr(v.message!);
          return;
        } 
        if(msg != 'Sukses' ){
          defaultDialogErr(v.message!);
          return;
        }  
        defaultDialogSukses( 'Poin berhasil ditukarkan',  const Point());
      });
  }

}