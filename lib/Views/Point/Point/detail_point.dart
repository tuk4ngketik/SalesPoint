// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, annotate_overrides, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_point/Cfg/css.dart';
import 'package:sales_point/Helper/tanggal.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Models/m_point_paginate.dart';
import 'package:sales_point/Views/redeem.dart';

class PointDetail extends StatefulWidget{   
  final  detailPoint;
  final totalPoint;
  const PointDetail({super.key,  this.detailPoint,  this.totalPoint  });  
  _PointDetail createState() => _PointDetail();
}


class _PointDetail extends State<PointDetail>{

  Tanggal tgl = Tanggal();
  PaginatePoint data = PaginatePoint();
  int? totalPoint;

  @override
  void initState() {
    super.initState();
    setState(() {
      data = widget.detailPoint;  
      totalPoint = widget.totalPoint;
    });
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Detail Poin',  style:   TextStyle(  color: Colors.yellow),),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children:   [
            br(10),
            const Center(child: Icon(Icons.check_circle, color: Colors.amber, size: 40,)),
            br(10),
            Center(child: Text('${data.totalPoint} Poin', style: const TextStyle(fontSize: 25, color: Colors.amber), )), 
            br(10),
            Card(
              child:  Padding(
                padding: const EdgeInsets.all(20),  
                child: Column(
                  children: [
      
                    Row(children: [
                      Expanded(flex: 4 ,child: Text('Tgl Installasi ', style: Css.pointsDetail,)),  
                      Flexible(flex: 5 ,child: Text( tgl.convertTanggal('${data.installDate}'), style: Css.pointsDetail,), ), 
                    ]),
      
                    br(10),
                    Row(children: [
                      Expanded(flex: 4 ,child: Text('Pelanggan ', style: Css.pointsDetail,)),  
                      Flexible(flex: 5 ,child: Text('${data.firstName} ${data.lastName}', style: Css.pointsDetail,)), 
                    ]),
                    br(10),
      
                    Row(children: [
                      Expanded(flex: 4 ,child: Text('Kode ', style: Css.pointsDetail,)),  
                      Flexible(flex: 5 ,child: Text('${data.garansiCode}', style: Css.pointsDetail,)), 
                    ]),
                    br(10),
                    Row(children: [
                      Expanded(flex: 4 ,child: Text('Dealer ', style: Css.pointsDetail,)),  
                      Flexible(flex: 5 ,child: Text('${data.branchName}', style: Css.pointsDetail,)), 
                    ]),
                    br(10),
      
                    Row(children: [
                      Expanded(flex: 4 ,child: Text('Tgl Poin', style: Css.pointsDetail,)),  
                      Flexible(flex: 5 ,child: Text( tgl.convertTanggal('${data.tglPoint}'), style: Css.pointsDetail,) ), 
                    ]),
                    br(10),
      
                    Row(children: [
                      Expanded(flex: 4 ,child: Text('Berakhir', style: Css.pointsDetail,)),  
                      Flexible(flex: 5 ,child: Text( tgl.convertTanggal('${data.tglExp}'),  style: Css.pointsDetailExp) ), 
                    ]),
                    br(10), 
                  ],
                ),
              ),
            ),
            TextButton.icon(
                    // onPressed: ()=>Get.to(const Login()), 
                    // onPressed: () => defaultDialogErr('Redeem'),
                    onPressed: () => Get.to(()=>  Redeem(totalPoint: '$totalPoint')),
                    icon: const Icon(Icons.redeem_sharp, color: Colors.amber,), 
                    label: const Text('Redeem', style: TextStyle(fontSize: 18, color: Colors.amber),) 
                  ),
        ]),
      ),
    );
  } 

}// End