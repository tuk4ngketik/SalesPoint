// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:sales_point/Cfg/Svr.dart';
import 'package:sales_point/Models/donException.dart';
import 'package:sales_point/Models/m_all.dart';
import 'package:sales_point/Models/m_item_detail.dart';
import 'package:sales_point/Models/m_items_redeeem.dart';
import 'package:sales_point/Models/m_transaksi_redeem.dart';

class ApiRedeem{

  Svr svr = Svr();

 Future<MItemsRedeem?> getItemsRedeem(var headers ) async { 
 
      try{
        var res = await http.get( Uri.parse( svr.itemsRedeem() ), headers: headers );    
            print('Redeem.itemsRedeem():  ${res.statusCode}');
        if(res.statusCode == 200){    
            // print('Redeem.getItemsRedeem():  ${res.body}');
            final mItemsRedeem = mItemsRedeemFromJson(res.body);
            return mItemsRedeem;
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

 Future<MItemDetail?> getItemsDetail(var headers, String serial ) async { 
 
      try{
        var res = await http.get( Uri.parse( svr.itemDetail(serial) ), headers: headers );  
            print('Redeem.itemDetail():  ${res.statusCode}');
        if(res.statusCode == 200){    
            // print('Redeem.getItemsDetail():  ${res.body}');
            final mItemDetail = mItemDetailFromJson(res.body);
            return mItemDetail;
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

  // Send Redeem
  Future<MAll?> sendRedeem(var headers, var data) async {  

      try{
        var res = await http.post( Uri.parse( svr.sendRedeem() ), headers: headers, body: data );   
            print('Redeem.sendRedeem():  ${res.statusCode}');  
        if(res.statusCode == 200){ 
          // print(' sendRedeem() res.statusCode ${ res.statusCode}  res.body ${ res.body}');    
          final mAll = mAllFromJson(res.body);
           return mAll;
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

  // History Transaction by user  
 Future<MTransaksiRedeem?> getRedeemtransaction(var headers, String serial ) async { 
 
      try{
        var res = await http.get( Uri.parse( svr.getRedeemTransaction(serial) ), headers: headers );  
            print('Redeem.getRedeemtransaction():  ${res.statusCode}'); 
        if(res.statusCode == 200){     
            // print('Redeem.getRedeemtransaction():  ${res.body}'); 
            final mTransaksiRedeem = mTransaksiRedeemFromJson(res.body);
            return mTransaksiRedeem;
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