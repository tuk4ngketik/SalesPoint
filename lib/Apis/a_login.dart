// ignore_for_file: avoid_print, depend_on_referenced_packages

// import 'dart:convert';

import 'package:sales_point/Cfg/Svr.dart';
import 'package:sales_point/Models/m_all.dart'; 
import 'package:sales_point/Models/m_login.dart';
import 'package:http/http.dart' as http;

import '../Models/m_dealer_partisipasi.dart';

class ApiLogin{

  Svr svr = Svr();
  
  // Login
  Future<MLogin?> login(var headers, var data) async {  

      try{
        var res = await http.post( Uri.parse( svr.login() ), headers: headers, body: data );  
        if(res.statusCode == 200){ 
          print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');  
          final mLogin = mLoginFromJson(  res.body ); 
          return mLogin;
        }else{
          return null;
        }
      }
      catch (e){
        print('e =>  $e');
      } 
      return null;
  }

  // Daftar
  Future<MAll?> daftar(var headers, var data) async {  

      try{
        var res = await http.post( Uri.parse( svr.daftar() ), headers: headers, body: data );  
        if(res.statusCode == 200){ 
          print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
           final mAll = mAllFromJson(res.body);
           return mAll;
        }else{
          return null;
        }
      }
      catch (e){
        print('e =>  $e');
      } 
      return null;
  }

  // Daftar Login Partisipan
  
  Future<MDealerPartisipasi?> dealerPartisipan(var headers ) async {  
      print('Header $headers');
      try{
        var res = await http.get( Uri.parse( svr.dealerPartisipan() ), headers: headers );  
        print('svr.dealerPartisipan()  ${svr.dealerPartisipan()}');
        if(res.statusCode == 200){ 
          print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
           final mDealerPartisipasi = mDealerPartisipasiFromJson(res.body);
           return mDealerPartisipasi;
        }else{
          return null;
        }
      }
      catch (e){
        print('e =>  $e');
      } 
    return null;
  }
}//end