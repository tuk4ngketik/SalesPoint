// ignore_for_file: avoid_print, depend_on_referenced_packages

// import 'dart:convert';
 
import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:sales_point/Cfg/Svr.dart';  
import 'package:http/http.dart' as http;
import 'package:sales_point/Models/Harga/m_harga-kaca.dart';
import 'package:sales_point/Models/Harga/m_merek.dart';
import 'package:sales_point/Models/Harga/m_type-by-brand.dart';
import 'package:sales_point/Models/donException.dart'; 

class ApiHarga{

  Svr svr = Svr();

  Future<MMerek?> merek(var headers ) async {  

      try{
        var res = await http.get( Uri.parse( svr.merekMobile() ), headers: headers ); 
          print(' res.statusCode ${ res.statusCode} ');   
        if(res.statusCode == 200){ 
          // print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
           final mMerek = mMerekFromJson(res.body);
           return mMerek;
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
          else if(e is NoSuchMethodError){
            msg = e.toString(); 
            print("NoSuchMethodError  exception: ${e.toString()}");
          }
          else{
            print("Unhandled exception: ${e.toString()}");
            msg = e.toString();
          }   
          throw DonException(e.toString()); 
    }   
  }


  Future<MTypeByBrand?> tipe(var headers, var body ) async {  
      try{
        var res = await http.post( Uri.parse( svr.tipeMobile() ), headers: headers, body : body );  
          print(' svr.tipeMobile() res.statusCode ${ res.statusCode} ');   
        if(res.statusCode == 200){  
          // print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
           final mTypeByBrand = mTypeByBrandFromJson(res.body);
           return mTypeByBrand;
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

  
  Future<MHargaKaca?> harga(var headers, var body  ) async {  

      try{
        var res = await http.post( Uri.parse( svr.hargaKaca() ), headers: headers, body : body   );    
          print(' svr.hargaKaca() res.statusCode ${ res.statusCode} ');   
        if(res.statusCode == 200){ 
          // print('body $body');
          // print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
           final mHargaKaca = mHargaKacaFromJson(res.body);
           return mHargaKaca;
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