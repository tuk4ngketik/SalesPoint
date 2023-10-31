// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, sized_box_for_whitespace, annotate_overrides, prefer_is_empty, unused_local_variable, avoid_returning_null_for_void, prefer_final_fields, non_constant_identifier_names

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:convert';
 
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sales_point/Apis/a_harga.dart';
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Helper/get_key.dart'; 
import 'package:sales_point/Helper/tanggal.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Models/G/PriceController.dart';
import 'package:sales_point/Views/Harga/kaca_belakang.dart';
import 'package:sales_point/Views/Harga/kaca_depan.dart';
import 'package:sales_point/Views/Harga/kaca_samping.dart';
import 'package:sales_point/Views/Harga/kaca_sunroof.dart';
import 'package:sales_point/Views/Harga/sendprice.dart';
import 'package:social_share/social_share.dart';

import '../Cfg/css.dart';
import 'Harga/merek.dart';  

class Harga extends StatefulWidget{
  const Harga({super.key}); 
  _Harga createState() => _Harga(); 
} 

class _Harga extends State<Harga>{

  PriceController priceController = Get.put(PriceController());
  ApiHarga apiHarga = ApiHarga();
  Sess sess = Sess(); 
  
   Tanggal tgl = Tanggal();  
   var headers ;
   List<String> mereks = [];
   final _diskon = TextEditingController();
   String? serial_user, telp, namaLengkap;
   bool isLoad = false;
  String product_name = 'V-KOOL™';
   
   
  final double _h_bgTop =  Get.height / 4;

  double _scrollPosition = 0 ; 
  ScrollController _scrollController = ScrollController();
  _scrollListener()   {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      print('_scrollPosition $_scrollPosition');
    });
  }
  
  // Headers 
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown', packageName: 'Unknown',  version: 'Unknown',
    buildNumber: 'Unknown',  buildSignature: 'Unknown', 
  ); 
  
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() =>  _packageInfo = info ); 
    _getHeader();
  } 
  
  _getHeader(){
    String pckDate = base64.encode(utf8.encode( tgl.dmy() )); 
    String pckName = base64.encode(utf8.encode( _packageInfo.packageName)); 
    
    headers = {
      'pckname': pckName,
      'pckdate': pckDate,
      'appversion':  _packageInfo.version, 
      'targetpath': 'c2lzdGVtZ2FyYW5zaS5jb20vc2l0ZS9hcGk=',
      'apikey': 'aUtvb2wtU2FsZXMtUG9pbnQ',  
      'Content-Type': 'application/json'
    }; 
    _getMerek();
  }
   
  _getMerek(){
    setState(()  => isLoad = true );
    apiHarga.merek(headers).then((v){
      bool? status = v!.status;
      if(status == false){
          snackAlert('Error',  '${v.message}'); 
          return; 
      }
       v.data!.forEach((element) { 
        if(!mounted) {return;}
        setState((){  
          mereks.add('${element.carBrand}');
          setState(()  => isLoad = false );
        } );
      });
    }) 
    .catchError((e) { 
      snackError('Error Load Merk Mobil', '${e.msg}');
      setState(()  => isLoad = false );
    });
  }

  @override
  void initState() { 
    super.initState();
    _initPackageInfo();  
    _scrollController.addListener(() =>  _scrollListener()  );
    total = 0;
    // Clear Harga Kaca
      priceController.set_kacaDepan([]);
      priceController.set_kacaBelakang([]);
      priceController.set_kacaSamping([]);
      priceController.set_kacaSunroof([]);
      priceController.clear_subTotal();
      sess.getSess('serial').then((value) => setState(() => serial_user = value));
      sess.getSess('phone').then((value) => setState(() =>  telp = value ) );
      sess.getSess('namaLengkap').then((value) => setState(() => namaLengkap = value )  ); 
  } 
   
  void dispose() { 
    super.dispose();
    _diskon.dispose();
    _scrollController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.black,            
            pinned: true,  
            title: ( _scrollPosition < 80 ) ?  null
              :  const Text('Daftar Harga', 
                  style: TextStyle(fontSize: 20, 
                        fontWeight: FontWeight.bold, 
                  )
            ), 
            expandedHeight: _h_bgTop , 
            flexibleSpace: FlexibleSpaceBar(     
              background: Image.asset('images/v-kool_logo.png', fit: BoxFit.fitWidth,),            
            ),
          ), 
          
          SliverList( 
            delegate: SliverChildListDelegate( 
            [ 
              ( isLoad == true) ? Container( height: 200, child: const Center(child: CircularProgressIndicator())) : 
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column( 
                    children : [        
                      
                      // Merek n Tipe
                      Merek(listMerek: mereks), 

                      // Kaca Depan
                      Card(
                        shadowColor: Colors.amber, 
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 0, right: 0),
                            title:  Text('Kaca Depan', style: Css.labelHarga,), 
                            subtitle: Obx(() => ( priceController.kacaDepan.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaDepan()),
                          ),
                        ),
                      ),
                  
                      // Kaca Samping
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 0, right: 0),
                            title:   Text('Samping', style: Css.labelHarga,), 
                            subtitle: Obx(() => ( priceController.kacaSamping.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaSamping()),                
                          ),
                        ),
                      ),  
                  
                      // Kaca Belakang
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 0, right: 0),
                            title:   Text('Belakang', style: Css.labelHarga,),
                            subtitle: Obx(() => ( priceController.kacaBelakang.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaBelakang() ),
                          ),
                        ),
                      ),  
                
                      // Sun Roof
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 0, right: 0),
                            title:   Text('Sun Roof', style: Css.labelHarga,),
                            subtitle: Obx(() => ( priceController.kacaSunroof.isEmpty ) ? const Text(' -- Tidak Ada --') : const KacaSunroof()),
                          ),
                        ),
                      ), 
                
                      const Divider(),
                      
                      // Sub Total
                      Container(
                        padding: const EdgeInsets.all(8),
                        // color: Colors.black,
                        child: Row(   
                              children: [
                                Text('Sub Total', style: Css.labelTarif,),  
                                Flexible(
                                  flex:8,
                                  child: Align(
                                    alignment: Alignment.centerRight, 
                                      // child:  Obx(() => Text( rupiah('Rp ', priceController.subtotal.toInt(), 2), style: Css.labelTarif,), ), 
                                      child: Container( 
                                        padding: const EdgeInsets.all(10),
                                        width: 200,  
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          border: Border.all( 
                                            width : 1,
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: Obx(() => Text( rupiah('Rp ', priceController.subtotal.toInt(), 0), style: Css.textTotal, textAlign: TextAlign.right,), ),
                                      ),
                                  ),
                                ), 
                              ],
                        ),
                      ), 
                
                      // Discount
                      Container( 
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start, 
                          children: [
                            const Flexible(flex: 7,
                              child: TextField(   
                                readOnly: true,  
                                decoration: InputDecoration(
                                  hintText: 'Discount',
                                  border: InputBorder.none,
                                ),
                              ),
                            ), 
                            // Flexible(child: Container(width: 10,), flex: 3,),
                            Flexible(
                              flex:3,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextField(    
                                  style: const TextStyle(color: Colors.black),
                                  decoration:  const InputDecoration(                                      
                                    hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), 
                                    hintText: '0',
                                    contentPadding: EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0), 
                                    suffixIcon: Icon(Icons.percent), 
                                    // border:                       
                                    focusedBorder:OutlineInputBorder(
                                      gapPadding: 0,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                    ), 
                                    border: OutlineInputBorder(
                                      gapPadding: 0,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                    ) 
                                  ),
                                  textAlign: TextAlign.right, 
                                  keyboardType: TextInputType.number,
                                  controller: _diskon,
                                  onChanged: (value) => _discountType(), 
                                 ), 
                              ),
                            ),
                          ],
                        ),
                      ),  
                
                      // Total
                      Container(
                        padding: const EdgeInsets.all(10),
                        // color: Colors.black,
                        child: Row( 
                              children: [
                                Center(child: Text('Total', style: Css.labelTarif,)),
                                Flexible(
                                  flex:8,
                                  child: Align(
                                    alignment: Alignment.centerRight, 
                                    // child: Text( rupiah('Rp ', total.toInt(), 2), style: Css.labelTarif,), 
                                    child: Container( 
                                      padding: const EdgeInsets.all(10),
                                      width: 200,  
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all( 
                                          width : 1,
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                      ),
                                      // child: Text(rupiah('Rp ', total.toInt(), 0), style: Css.textTotal, textAlign: TextAlign.right,),
                                      child: Obx(() => Text(rupiah('Rp ', priceController.total.toInt(), 0), style: Css.textTotal, textAlign: TextAlign.right,),) 
                                    ),
                                  ),
                                ),  
                              ],
                        ),
                      ),

                      br(10),
                      Center( 
                        child : TextButton.icon(
                          onPressed: (){ 
                            print('DEBUG TEXT');
                            print(textPriceWhatsapp());
                            print('DEBUG TEXT');
                            _bottomSend();
                          },  
                          icon:  const Icon(Icons.share, color: Colors.amber, weight: 50,  ),  
                          label: const Text('Share', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold),)
                        )   
                      ),
                                   
                    ],
                  ),
                ),
              ]  
            ),
          )
                
        ],
      ),
    );
  }

  double total = 0;
  _total(int diskon, int subtotal){   // NEW
    double dec = diskon / 100;                          // diskon / 100 = 0,3
    double potongan = subtotal * dec;                   // 4.500.000 x 0,3 = 1.500.00
    total = subtotal - potongan;                        // 4.500.000 - 1.500.000 = 3.500.000    
    priceController.set_total(total.toInt());
  } 

  _discountType(){
    print(_diskon.text);
    String diskon = _diskon.text;
    if( priceController.subtotal.toInt() < 1){
      defaultDialogErr('Anda belum memilih produk');
      FocusScope.of(context).unfocus();
      _diskon.clear(); 
      _total( 0,  priceController.subtotal.toInt() );
      return; 
    }
    if ( diskon.length < 1 ){ 
      _diskon.clear();
      _total( 0,  priceController.subtotal.toInt() );
      return;
    }
    if ( diskon.length > 0 && GetUtils.isNum(diskon) == false ){
      defaultDialogErr('Diskon harus angka');
      FocusScope.of(context).unfocus();
      _diskon.clear();
      _total( 0,  priceController.subtotal.toInt() );
      return;
    }
    if( int.parse(diskon) > 30){
      defaultDialogErr( 'Max diskon 30%');   
      FocusScope.of(context).unfocus();
      _diskon.clear();
      _total( 0,  priceController.subtotal.toInt() );
      return;
    }
    priceController.set_diskon( int.parse(diskon) );
     _total( int.parse(diskon),  priceController.subtotal.toInt() );
  }

  shareWhatsapp(){ 
    if( priceController.subtotal.toInt() < 1){
      defaultDialogErr('Anda belum memilih produk');
      FocusScope.of(context).unfocus();
      _diskon.clear(); 
      _total( 0,  priceController.subtotal.toInt() );
      return; 
    }
    print( textPriceWhatsapp() );
    SocialShare.shareWhatsapp( textPriceWhatsapp() ).then((value) {
      print('shareWhatsapp =>  $value'); 
      if(value == 'error'){ 
        defaultDialogErr('Pastikan anda memiliki aplikasi Whatsapp');
      }
    });
  }
   
 String textPriceWhatsapp(){ 
  // rupiah('', hargaJual , 0)
  String harga_kacaDepan = ( priceController.nilai_kacaDepan.toInt()  != 0) ?  'Rp. ${rupiah('',  priceController.nilai_kacaDepan.toInt() , 0)}' : '--';
  String film_kacaDepan = '${priceController.film_kacaDepan}';
  String kacaSamping =  ( priceController.nilai_kacaSamping.toInt()  != 0) ? 'Rp. ${rupiah('',  priceController.nilai_kacaSamping.toInt() , 0)}' : '--';
  String film_kacaSamping = '${priceController.film_kacaSamping}';
  String kacaBelakang =  ( priceController.nilai_kacaBelakang.toInt()  != 0) ? 'Rp.  ${rupiah('',  priceController.nilai_kacaBelakang.toInt(), 0)}' : '--';
  String kacaSunroof =  ( priceController.nilai_kacaSunroof.toInt()  != 0) ? 'Rp.  ${rupiah('',  priceController.nilai_kacaSunroof.toInt(), 0)}' : '-';
  String diskon = '${priceController.diskon}%';
  String subtotal = rupiah('',  priceController.subtotal.toInt(), 0);
  String total = rupiah('',  priceController.total.toInt(), 0);
  
  
  String _itemKacaDepan =  ( priceController.nilai_kacaDepan.toInt()  != 0) ? """
*Kaca Depan* :  
 - Film : *$film_kacaDepan*
 - Harga : *$harga_kacaDepan*  """ : "";
  String _itemKacaSamping = ( priceController.nilai_kacaSamping.toInt()  != 0) ? """
*Kaca Samping* 
 - Film : *$film_kacaSamping*
 - Harga : *$kacaSamping* """ : "";
  String _itemKacaBelakang = ( priceController.nilai_kacaBelakang.toInt()  != 0) ? """
*Kaca Belakang*
 - Film : *${priceController.film_kacaBelakang}*
 - Harga : *$kacaBelakang*  """ : "";
  String _itemKacaSunroof = ( priceController.nilai_kacaSunroof.toInt()  != 0) ? """
*Sun Roof*
 - Film : *${priceController.film_kacaSunroof}* 
 - Harga : *$kacaSunroof*  """ : "";
 

  String  t = """
------------------------------------------ 
*Penawaran Harga $product_name* 
------------------------------------------
Merek Mobil : *${priceController.brand}* 
Tipe Mobil  : *${priceController.tipe}* 

$_itemKacaDepan
$_itemKacaSamping 
$_itemKacaBelakang
$_itemKacaSunroof

========================== 
Sub Total : *Rp. $subtotal* 
Diskon : *$diskon* 
Total : *Rp. $total* 
------------------------------------------
*i-Kool Club*
------------------------------------------
""" ;
    return t;
 }
  

 _bottomSend(){ 
  
    if( priceController.subtotal.toInt() < 1){
      defaultDialogErr('Anda belum memilih produk');
      FocusScope.of(context).unfocus();
      _diskon.clear(); 
      _total( 0,  priceController.subtotal.toInt() );
      return; 
    }

    Get.bottomSheet(
      // Sendprice(serial_user: serial_user!, produk: 'VKOOL', pesan_teks: textPriceWhatsapp(), )
      Sendprice(serial_user: serial_user!, namaLengkap: namaLengkap!, wa_pengirim: telp!, produk: product_name, pesan_teks: textPriceWhatsapp(),)
    );
 }

}//End