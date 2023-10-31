// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables, unrelated_type_equality_checks
 
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_point/Cfg/css.dart';
import 'package:sales_point/Helper/get_key.dart';
import 'package:sales_point/Models/G/PriceController.dart'; 

class KacaSamping extends StatefulWidget{
  const KacaSamping({super.key});
    
  @override
  _KacaSamping createState() => _KacaSamping();
  
} 

class _KacaSamping extends State<KacaSamping>{ 

  PriceController priceController = Get.put(PriceController());

  List<String> listFilm = [];  
  List<String> listKacaSamping = []; 
  final _kacaSamping = TextEditingController();
  
  var data;
  int hargaJual = 0;
  
  @override
  void initState() { 
    super.initState();
    setState(() { 
      data = priceController.kacaSamping;
    });
    _getPriceList();
  }
  @override
  dispose(){
    super.dispose();
    _kacaSamping.dispose(); 
  }

  _getPriceList(){ 
    data.forEach((element) {
      // print('${element.filmType}');
      setState(() {
        listFilm.add('${element.filmType}');
      });
    });
  }

  @override
  Widget build(BuildContext context){ 
      return Row(
        children: [
          Flexible(
            flex: 6, 
            child: EasyAutocomplete(
              decoration:   InputDecoration(
                hintText: '-- Tipe Film --',
                contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
                border: const OutlineInputBorder( 
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gapPadding: 0,
                ), 
                suffixIcon: ( priceController.nilai_kacaSamping != 0 ) ? IconButton(
                  icon : const Icon(Icons.close),
                  onPressed: (){
                    setState(() =>  hargaJual = 0 );  
                    priceController.set_nilaiKacaSamping(  hargaJual );
                    priceController.hitung_subTotal();  
                    priceController.set_filmKacaSamping('-');
                    _total( priceController.diskon.toInt(),  priceController.subtotal.toInt() );
                    _kacaSamping.clear();
                  },
                ) : null
              ),
              controller: _kacaSamping,
              suggestions: listFilm, 
              onChanged: (String v) {  
                  int i = fromList(listFilm, v);
                  setState(() =>  hargaJual = int.parse( data[i].hargaJual ) );
                  priceController.set_nilaiKacaSamping(  hargaJual ); 
                  priceController.hitung_subTotal();
                  priceController.set_filmKacaSamping(v);
                  _total( priceController.diskon.toInt(),  priceController.subtotal.toInt() ); 
              },
              onSubmitted: (String v) { 
                  int i = fromList(listFilm, v);
                  setState(() =>  hargaJual = int.parse( data[i].hargaJual ) );
                  priceController.set_nilaiKacaSamping(  hargaJual ); 
                  priceController.hitung_subTotal();
                  priceController.set_filmKacaSamping(v);
                  _total( priceController.diskon.toInt(),  priceController.subtotal.toInt() );
                  print('onSubmitted  Harga Jaul $v : $hargaJual'); 
              },
            ),
          ), 
          Container(width: 10,), 
          Flexible(
              flex: 3 , 
              child: Align(
                alignment: Alignment.centerRight, 
                child: Text( rupiah('', hargaJual , 0), style: Css.labelTarif, ), 
              ),
            )
        ],
      ); 
  } 
   

  double total = 0;
  _total(int diskon, int subtotal){   // NEW
    double dec = diskon / 100;                          // diskon / 100 = 0,3
    double potongan = subtotal * dec;                   // 4.500.000 x 0,3 = 1.500.00
    total = subtotal - potongan;                        // 4.500.000 - 1.500.000 = 3.500.000    
    priceController.set_total(total.toInt());
  } 

}//End