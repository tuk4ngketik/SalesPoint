// ignore_for_file: avoid_print, depend_on_referenced_packages

// import 'dart:convert';

import 'package:sales_point/Cfg/Svr.dart';
import 'package:sales_point/Models/m_all.dart'; 
import 'package:sales_point/Models/m_login.dart';
import 'package:http/http.dart' as http;

class ApiLogin{

  Svr svr = Svr();

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


}//end