// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_field, unused_element, prefer_typing_uninitialized_variables, unused_local_variable, prefer_is_empty, non_constant_identifier_names  
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
// import 'package:sales_ListPoint/dondrawer.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart'; 
import 'package:sales_point/Apis/a_point.dart';
import 'package:sales_point/Cfg/css.dart';
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Helper/tanggal.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Models/G/PointController.dart';   
import 'package:sales_point/Models/m_point_paginate.dart';
import 'package:sales_point/Views/Point/Point/detail_point.dart';
import 'package:sales_point/Views/redeem.dart';

class ListPoint extends StatefulWidget{ 
  const ListPoint({super.key });
  @override
  _ListPoint createState() => _ListPoint();
  
} 

class _ListPoint extends State<ListPoint>{

  PointController pointController = Get.put(PointController());
  Sess sess = Sess();
  String? serial;
  ApiPoint apiPoint = ApiPoint();
  bool isLoad = true;

  Tanggal tgl = Tanggal();  
  var headers ;  
  int? totalPoint;
  int nextPage = 1; // default 
  List<PaginatePoint> dataPaginate = [];
 
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown', packageName: 'Unknown',  version: 'Unknown',
    buildNumber: 'Unknown',  buildSignature: 'Unknown', 
  ); 

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() =>  _packageInfo = info ); 
    _point();
  } 
  
  _point(){

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
    
    var data = {
        "serial_ikool" : "$serial",
        "per_page" : "10",
        "pg" : "$nextPage"
    };
    print('form $data');

    apiPoint.point(headers,  jsonEncode(data) ).then((v) {

      bool? status = v!.status; 
      if(status == false  ) { 
        setState(() {
          isLoad = false;
          // totalListPoint = v.totalListPoint; 
        });
        return;
      }  
      print('status $status');
      print('isLoad $isLoad');
      setState(() {
        dataPaginate = v.data! ;
        nextPage = v.nextPage!;  
        totalPoint = int.parse('${v.totalPoint}') ; 
        pointController.set_totalPoint(totalPoint!);
        if( dataPaginate.length < 1 ) {  
          isLoad = false;
          return;
        } 
        isLoad = false;
        print('dataPaginate ${dataPaginate.length}');
      });  

    })
    .catchError((e){
      setState(() => isLoad =  false );
      snackError('Error Poin', '${e.msg}');
    });

  }

  @override
  void initState() {
    super.initState(); 
    sess.getSess('serial').then((value) => setState(() => serial = value ) );  
     _initPackageInfo();
  }
  

  @override
  Widget build(BuildContext context){
    return Scaffold(  
      body: (isLoad == true ) ?  const Center(child: CircularProgressIndicator()) 
            : (dataPaginate.isEmpty ) ?   const Center(child: Text('Belum ada poin'))
              : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: dataPaginate.length,
                itemBuilder: (context, i) { 
                  String tgl_ListPoints = '${dataPaginate[i].tglPoint}';
                  String tgl_exp = '${dataPaginate[i].tglExp}';
                  String nama = '${dataPaginate[i].firstName} ${dataPaginate[i].lastName} ';
                  return Card(
                    child: Padding(  
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        onTap: () => Get.to(  PointDetail(detailPoint: dataPaginate[i], totalPoint: totalPoint, )),
                        leading: Text('${dataPaginate[i].totalPoint}', style: Css.pointsLead ,),  
                        title: Text( '${dataPaginate[i].garansiCode}', style: Css.pointsTitle,),  
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text('Pelanggan : ',style: Css.pointsSubTitle,),
                              Expanded(child: Text(nama, style: Css.pointsSubTitle,)),
                            ],), 
                            Row(children: [
                              Text('Berakhir : ', style: Css.pointsSubTitle,),
                              Text(tgl.convertTanggal(tgl_exp),   style: Css.pointsSubTitle,),
                            ],) 
                          ],
                        ), 
                      ),
                    ),
                  );
                },
              ), 
              floatingActionButton: FloatingActionButton(
                  // onPressed: () => defaultDialogErr('Redeem ListPoint'),
                  onPressed: () => Get.to(()=>  Redeem(totalPoint: '$totalPoint')),
                  backgroundColor: Colors.yellow,
                  child: const Icon(Icons.card_giftcard_sharp, color: Colors.pink,),
                ),
    );
  }

}