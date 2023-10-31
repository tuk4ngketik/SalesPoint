// ignore_for_file: override_on_non_overriding_member, library_private_types_in_public_api, annotate_overrides, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales_point/Apis/a_point.dart';
import 'package:sales_point/Helper/myapp-attr.dart';
import 'package:sales_point/Helper/wg.dart'; 

class HomePoint extends StatefulWidget{
  final String serial, namaLengkap;
  const HomePoint({super.key, required this.serial, required this.namaLengkap}); 
  _HomePoint createState () => _HomePoint(); 
}


class _HomePoint extends State<HomePoint>{
  @override
  String? serial,  namaLengkap;
  var headers;
  
  void initState() { 
    super.initState();
    setState(() {
      namaLengkap = widget.namaLengkap;
      serial = widget.serial;
    });
    myappAttr.retHeader().then((value) { 
      setState(() {
        headers = value;
      });
      _point();
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(10),
      height: 80, 
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10 ),
        color: Colors.black38
      ),
      child:     ListTile( 
        title: const Text('Halo,', style: TextStyle(color: Colors.white54),),
        subtitle: Text(namaLengkap!, style: const TextStyle(fontSize: 17, color: Colors.white),),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            const Icon(Icons.diamond, size: 20, color: Colors.yellow,),
            // Text('1304500 Poin', style: TextStyle(color: Colors.yellow, fontSize: 16),)
            Text('$totalPoint', style: const TextStyle(color: Colors.yellow, fontSize: 16),)
        ],)
      )
    );
  }

  MyappAttr myappAttr = MyappAttr();
  ApiPoint apiPoint = ApiPoint();

  
  bool isLoad = true;
  int totalPoint = 0;

  _point(){

    var data = {
        "serial_ikool" : "$serial",
        "per_page" : "1",
        "pg" : "1"
    };
    
    apiPoint.point(headers,  jsonEncode(data) ).then((v) {

      bool? status = v!.status; 
      if(status == false  ) { 
        setState(() {
          isLoad = false; 
        });
        return;
      }  
      print('status $status');
      print('isLoad $isLoad');
      setState(() {
        totalPoint = int.parse('${v.totalPoint}') ; 
        isLoad = false;
      });  

    })
    .catchError((e){
      setState(()=>  isLoad = false);
      snackError('Error load poin', '${e.msg}');
    });

  }

}