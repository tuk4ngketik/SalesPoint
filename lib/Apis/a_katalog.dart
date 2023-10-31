// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:sales_point/Cfg/Svr.dart';
import 'package:sales_point/Models/donException.dart';
import 'package:sales_point/Models/m_katalog_otomotif.dart'; 

class ApiKatalog{

  Svr svr = Svr();

 Future<MKatalogOtomotif?> getKatalogOtomotif(var headers ) async { 
 
      try{
        var res = await http.get( Uri.parse( svr.katalogOtomotif() ), headers: headers );  
            print('svr.katalogOtomotif() :  ${res.statusCode}');
        if(res.statusCode == 200){    
            // print('API getKatalogOtomotif():  ${res.body}');
            final mKatalogOtomotif = mKatalogOtomotifFromJson(res.body);
            return mKatalogOtomotif;
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