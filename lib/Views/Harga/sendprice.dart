// ignore_for_file: annotate_overrides, library_private_types_in_public_api, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, prefer_is_empty, non_constant_identifier_names, avoid_print, must_be_immutable, unused_local_variable, unused_field
 
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sales_point/Apis/a_share_pricelist.dart';
import 'package:sales_point/Cfg/css.dart';
import 'package:sales_point/Helper/myapp-attr.dart';
import 'package:sales_point/Helper/rgx.dart';
import 'package:sales_point/Helper/wg.dart'; 
// import 'package:vil_pricelist/Apis/a_share_pricelist.dart'; 
// import 'package:vil_pricelist/Cfg/css.dart'; 
// import 'package:vil_pricelist/Helper/myapp-attr.dart';
// import 'package:vil_pricelist/Helper/rgx.dart';
// import 'package:vil_pricelist/Helper/wg.dart'; 


class Sendprice extends StatefulWidget{
  late String serial_user, namaLengkap, wa_pengirim, produk, pesan_teks ; 
  Sendprice({super.key, required this.serial_user, required this.namaLengkap, required this.wa_pengirim,  required this.produk, required this.pesan_teks   }); 
  @override
  _Sendprice createState() => _Sendprice(); 
}

class _Sendprice extends State<Sendprice>{   

  // PricesolargardController pricesolargardController = Get.put(PricesolargardController());
  String? serial_user; 
  final TextEditingController _nowhatsapp = TextEditingController(); 
  final TextEditingController _noPengirim = TextEditingController(); 
  ApiSharePricelist apiSharePricelist = ApiSharePricelist();
  MyappAttr myappAttr = MyappAttr();
  var headers;
  bool isLoad = false;
 

  @override
  void initState() { 
    super.initState();
     myappAttr.retHeader().then((value) {   headers  = value;   } );
     _noPengirim.text = widget.wa_pengirim; 
  }

  @override
  void dispose() { 
    super.dispose();
    _nowhatsapp.dispose();
    _noPengirim.dispose();
  }
  

  @override
  Widget build(BuildContext context) {  
    return Container(
      decoration: const BoxDecoration( 
      color: Colors.white,
        borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )
      ),  
      padding: const EdgeInsets.all(20), 
      // margin: EdgeInsets.all(20),
      // height: 240,
      child: SingleChildScrollView(
        child: Column(
          children:   [
              const Text('Share Harga ', style: TextStyle(fontSize: 18),),
              br(15),
              TextField(   
                keyboardType: TextInputType.number, 
                decoration:   InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0, strokeAlign: 0,  color: Colors.grey  ),
                                borderRadius: BorderRadius.all(Radius.circular(20)),  
                  ),
                  enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0, strokeAlign: 0,  color: Colors.grey  ),
                                borderRadius: BorderRadius.all(Radius.circular(20)),  
                  ),
                  label : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No. Whatsapp penerima', style: TextStyle(color: Colors.black),),
                  ) ,
                  hintText: 'No. Whatsapp penerima',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(
                    gapPadding: 0,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),  
                  suffixIcon: (  _nowhatsapp.text.length < 1) ? null 
                        : IconButton(onPressed: (){
                          _nowhatsapp.clear();
                        }, 
                        icon: const Icon(Icons.close)
                        ),
                ),
                controller: _nowhatsapp, 
              ), 
              br(15),
              TextField(   
                keyboardType: TextInputType.number,  
                decoration: const InputDecoration(   
                  focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0, strokeAlign: 0,  color: Colors.grey  ),
                                borderRadius: BorderRadius.all(Radius.circular(20)),  
                  ),
                  enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0, strokeAlign: 0,  color: Colors.grey  ),
                                borderRadius: BorderRadius.all(Radius.circular(20)),  
                  ),
                  label : Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No. Whatsapp anda', style: TextStyle(color: Colors.black),),
                  ) ,
                  hintText: 'No. Whatsapp anda',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    gapPadding: 0,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  )
                ),
                controller: _noPengirim, 
              ), 
              br(10),
              SizedBox(
                width: Get.width,
                height: 50,
                child: TextButton.icon(
                  style :  TextButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    shape: Css.stadiumBorderBlack,
                  ),  
                  onPressed: () => _shareWhatsapp(),  
                  icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green,),
                  label: (isLoad == true) ? const LinearProgressIndicator(color: Colors.amber, ) 
                         : const Text('Whatsapp', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 17),)
                ),
              ) 
          ],
        ),
      ) ,
    );
  }  

  _shareWhatsapp(){
    String pengirim = _noPengirim.text;
    String no = _nowhatsapp.text;
     

    if (numberOnly(no) == false || (no.length < 10 || no.length > 15)){
      defaultDialogErr('Whatsapp penerima tidak valid');
      return;
    } 

    if (numberOnly(pengirim) == false || (pengirim.length < 10 || pengirim.length > 15)){
      defaultDialogErr('Whatsapp pengirim tidak valid');
      return;
    }     

    String isiPesan =  widget.pesan_teks; 
    String namaLengkap = widget.namaLengkap.trim();
    String produk = widget.produk;
    final produk_encoded = Uri.encodeComponent(produk);
    isiPesan += """
*$namaLengkap*
_klik untuk balas pesan_
https://wa.me/62$pengirim?text=reply%20pricelist%20$produk_encoded
==========================
""";
    var data = { 
        "penerima" : _nowhatsapp.text,  
        "produk" : produk, 
        // "pesan_teks" :  textPriceWhatsapp(),
        "pesan_teks" : isiPesan, 
        "appname" : myappAttr.realApppName() , 
        "packagename" : myappAttr.realPckName() , 
        "serial_user" : widget.serial_user
    };
    print(data);
    // return ;
    setState(()  =>  isLoad = true );
    apiSharePricelist.sharePrice(headers, jsonEncode(data) ).then((v) {
      bool? status = v!.status;
      String? msg = v.message;
      var data = v.data;
      print('status $status');
      print('msg $msg');
      print('data $data'); 
      if(status == true) {  
        Get.back(); 
        defaultDialogSuksesStaypage('Pesan terkirim');
      }
      setState(()  =>  isLoad = false );
    });

  }
 
 
}