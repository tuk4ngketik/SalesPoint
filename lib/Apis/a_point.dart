// ignore_for_file: avoid_print, depend_on_referenced_packages

// import 'dart:convert';
 
import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:sales_point/Cfg/Svr.dart'; 
import 'package:http/http.dart' as http;
import 'package:sales_point/Models/donException.dart';
import 'package:sales_point/Models/m_point_paginate.dart'; 
 

class ApiPoint{

  Svr svr = Svr();
   
  Future<MPointPaginate?> point(var headers, var data) async {  

      try{
        var res = await http.post( Uri.parse( svr.point() ), headers: headers, body: data );  
            print('svr.point() :  ${res.statusCode}');
        if(res.statusCode == 200){ 
          // print(' point() res.statusCode ${ res.statusCode} point res.body ${ res.body}');   
          final mPointPaginate = mPointPaginateFromJson(res.body);
          return mPointPaginate;
        }else{
          throw DonException('${res.statusCode}'); 
        }
      }
      on Exception catch(e){     
         String? msg;
          if( e is SocketException ){ 
            msg = e.message;
            print("SocketException  exception: ${e.toString()}");
          }
          else if( e is TimeoutException ){   
            msg = e.message;
            print("TimeoutException  exception: ${e.toString()}");
          }
          else if( e is HttpException ){
            msg = e.message;
            print("HttpException  exception: ${e.toString()}");
          }
          else if( e is TlsException ){
            msg = e.message; 
            print("TlsException  exception: ${e.toString()}");
          }  
          else if( e is IsolateSpawnException ){
            msg = e.message; 
            print("IsolateSpawnException  exception: ${e.toString()}");
          }  
          else{
            print("else  exception: ${e.toString()}");
            msg = 'Unhandled exception';
          }   
          throw DonException(msg!); 
    } 
  }
  

}//end