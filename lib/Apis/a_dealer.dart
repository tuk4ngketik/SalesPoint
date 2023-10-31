// ignore_for_file: avoid_print, depend_on_referenced_packages
   
import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:sales_point/Cfg/Svr.dart';  
import 'package:http/http.dart' as http;
import 'package:sales_point/Models/donException.dart'; 
import 'package:sales_point/Models/m_dealer_aktif.dart';
import 'package:sales_point/Models/m_dealer_partisipasi.dart'; 

class ApiDealer{

  Svr svr = Svr();

  Future<MDealerAktif?> getDealer(var headers ) async {  

      try{
        var res = await http.get( Uri.parse( svr.dealerAktif() ), headers: headers );  
        // var res = await http.get( Uri.parse( 'http://kinyangbadur.com' ), headers: headers );  
        if(res.statusCode == 200){ 
          // print(' getDealer() :  res.statusCode ${ res.statusCode}  res.body ${ res.body}');    
           final mDealerAktif = mDealerAktifFromJson(res.body);
           return mDealerAktif;
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

 
  // Daftar Login Partisipan
   Future<MDealerPartisipasi?> dealerPartisipan(var headers ) async {   
      try{
        var res = await http.get( Uri.parse( svr.dealerPartisipan() ), headers: headers );  
        // print('svr.dealerPartisipan()  ${svr.dealerPartisipan()}');
        if(res.statusCode == 200){ 
          // print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
           final mDealerPartisipasi = mDealerPartisipasiFromJson(res.body);
           return mDealerPartisipasi;
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