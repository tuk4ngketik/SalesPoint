// ignore_for_file: avoid_print, depend_on_referenced_packages, non_constant_identifier_names

// import 'dart:convert';
 
import 'package:sales_point/Cfg/Svr.dart';
import 'package:sales_point/Models/donException.dart';
import 'package:sales_point/Models/m_all.dart'; 
import 'package:sales_point/Models/m_login.dart';
import 'package:http/http.dart' as http;
import 'package:sales_point/Models/m_verifikasi.dart';


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
  //  Future<MDealerPartisipasi?> dealerPartisipan(var headers ) async {  
  //     print('Header $headers');
  //     try{
  //       var res = await http.get( Uri.parse( svr.dealerPartisipan() ), headers: headers );  
  //       print('svr.dealerPartisipan()  ${svr.dealerPartisipan()}');
  //       if(res.statusCode == 200){ 
  //         print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
  //          final mDealerPartisipasi = mDealerPartisipasiFromJson(res.body);
  //          return mDealerPartisipasi;
  //       }else{
  //         return null;
  //       }
  //     }
  //     catch (e){
  //       print('e =>  $e');
  //     } 
  //   return null;
  // }
  
  // VErifikasi
  Future<MVerifikasi?> verifikasi(var headers, var data)async {
      

    print('headers $headers');
    print('body $data');

      try{
        var res = await http.post( Uri.parse( svr.verifikasi() ), headers: headers, body: data );  
        if(res.statusCode == 200){ 
          print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}'); 
          final mVerifikasi = mVerifikasiFromJson(res.body);
          return mVerifikasi;
        }else{
          return null;
        }
      }
      catch (e){
        print('e =>  $e');
      } 
      return null;
  }

  // Forgot
  Future<MAll?> forgot(var headers, var data) async {  

      try{
        var res = await http.post( Uri.parse( svr.forgot() ), headers: headers, body: data );  
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
  
  // Forgot Verifikasi / Konfirmasi
  Future<MAll?> forgotKonfirmasi(var headers, var data) async {  

      try{
        var res = await http.post( Uri.parse( svr.forgotKonfirmasi() ), headers: headers, body: data );  
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

  // Kelengkapan data setelah verifikasi login
  Future<MLogin?> kelengkapanData(var headers, Map<String, String> dataBody, String pathFoto, String pathKtp ) async {
    String url = svr.kelengkapanData();
    var request = http.MultipartRequest('POST', Uri.parse( url ));
    request.fields.addAll( dataBody );
    // request.files.add(await http.MultipartFile.fromPath('pic', '/C:/Users/itdev/OneDrive/Pictures/Screenshots/Screenshot_20230228_162232.png'));
    // request.files.add(await http.MultipartFile.fromPath('img_ktp', '/C:/Users/itdev/OneDrive/Pictures/Screenshots/Screenshot 2023-03-13 165657.png'));
    request.files.add(await http.MultipartFile.fromPath('pic', pathFoto));
    request.files.add(await http.MultipartFile.fromPath('img_ktp', pathKtp));
    request.headers.addAll(headers);
 
    http.StreamedResponse response = await request.send();  
    if (response.statusCode == 200) {
      print('await response.stream.bytesToString()');
      var body = await response.stream.bytesToString();  
      print('res $body');
      // print(await response.stream.bytesToString());  
          // print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');  
          final mLogin = mLoginFromJson(  body ); 
          return mLogin; 
    }
    else {
      print(response.reasonPhrase);  
      return null;
    } 
  }

  // Update Akun
  Future<MAll?> updateAkun(var headers, var data)async { 
    print('headers $headers');
    print('data $data');
      try{
        var res = await http.post( Uri.parse( svr.updateAkun() ), headers: headers, body: data );  
        if(res.statusCode == 200){ 
          print(' res.statusCode ${ res.statusCode}  res.body ${ res.body}');   
           final mAll = mAllFromJson(res.body);
           return mAll;
        }else{
          throw DonException('${res.statusCode}'); 
        }
      }
      on Exception catch(e){   
        print('e =>  $e');  
      } 
      return null;
  }

}//end