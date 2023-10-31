// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:sales_point/Cfg/Svr.dart';
import 'package:sales_point/Models/donException.dart'; 
import 'package:sales_point/Models/m_promo.dart'; 

class ApiPromo{

  Svr svr = Svr();
  

 Future<MPromo?> getPromo(var headers ) async { 

      // try {
      //   final result = await InternetAddress.lookup('example.com');
      //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //     print('result $result');
      //     print('connected');
      //   }
      // } on SocketException catch (e) {
      //   print('not connected');
      //   print('e $e');
      //   throw DonException(e.message);
      // }

      try{
        var res = await http.get( Uri.parse( svr.promo() ), headers: headers );  
            print('svr.promo() :  ${res.statusCode}');
        if(res.statusCode == 200){    
            // print('API getPromo():  ${res.body}'); 
            final mPromo = mPromoFromJson(res.body); 
            return mPromo;
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