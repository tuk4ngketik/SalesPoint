// ignore_for_file: camel_case_types, avoid_print, prefer_typing_uninitialized_variables, annotate_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_point/Cfg/css.dart';
import 'package:sales_point/Helper/wg.dart';

class itemDetail extends StatelessWidget{

  final data;
  final totalPoin;
  const itemDetail({super.key, required this.data, required this.totalPoin}); 


  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
        Center(child: Text(data.itemName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)),
        br(10),
        Center(
          child: Text('${data.itemStart} s/d ${data.itemExpired}', style: const TextStyle(fontSize: 18, color: Colors.green)),
        ),
        ListTile(
          title: const Text('Poin'),
          subtitle: Text(data.itemPoint),
        ),
        ListTile(
          title: const Text('Deskripsi'),
          subtitle: Text(data.itemDesc),
        ),
        ListTile(
          title: const Text('Syarat dan Ketentuan'),
          subtitle: Text(data.itemSyarat),
        ), 
        Center(
          child: TextButton(
            onPressed: () {
                Get.back();
                _redeem( int.parse('$totalPoin'), int.parse('${data.itemPoint}') ); 
              }, 
            style : TextButton.styleFrom ( shape : Css.stadiumBorderBlack ),
            child: const Text('Redeem')
          ),
        )
      ],),
    );
  }

  _redeem(int totalPoint, int itemPoint){
      print('totalPOint $totalPoint itemPoint $itemPoint');
      if(totalPoint < itemPoint){
        defaultDialogErr('Poin tidak cukup');
        return;
      }
      deafultDialogKonfirm( _prosesRedeem ); 
  }
}


 _prosesRedeem(){
    print("POST sendRedeem()");
    // apiRedeem.sendRedeem(headers, data)
 }