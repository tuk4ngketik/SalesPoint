// ignore_for_file: avoid_print, depend_on_referenced_packages

// import 'dart:convert';
 
import 'package:sales_point/Cfg/Svr.dart';  
import 'package:http/http.dart' as http;
import 'package:sales_point/Models/Harga/m_harga-kaca.dart';
import 'package:sales_point/Models/Harga/m_merek.dart';
import 'package:sales_point/Models/Harga/m_type-by-brand.dart'; 

class ApiHarga{

  Svr svr = Svr();

  Future<MMerek?> merek(var headers ) async {  

      try{
        var res = await http.get( Uri.parse( svr.merekMobile() ), headers: headers );  
        if(res.statusCode == 200){ 
          // print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
           final mMerek = mMerekFromJson(res.body);
           return mMerek;
        }else{
          return null;
        }
      }
      catch (e){
        print('e =>  $e');
      } 
    return null;
  }


  Future<MTypeByBrand?> tipe(var headers, var body ) async {  
      try{
        var res = await http.post( Uri.parse( svr.tipeMobile() ), headers: headers, body : body );  
        if(res.statusCode == 200){  
          // print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
           final mTypeByBrand = mTypeByBrandFromJson(res.body);
           return mTypeByBrand;
        }else{
          return null;
        }
      }
      catch (e){
        print('e =>  $e');
      } 
    return null;
  }

  
  Future<MHargaKaca?> harga(var headers, var body  ) async {  

      try{
        var res = await http.post( Uri.parse( svr.hargaKaca() ), headers: headers, body : body   );  
        if(res.statusCode == 200){ 
          // print('body $body');
          // print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
           final mHargaKaca = mHargaKacaFromJson(res.body);
           return mHargaKaca;
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