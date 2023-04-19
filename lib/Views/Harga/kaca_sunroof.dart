// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables
 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_point/Cfg/css.dart';
import 'package:sales_point/Helper/get_key.dart';
import 'package:sales_point/Models/G/PriceController.dart'; 

class KacaSunroof extends StatefulWidget{
  const KacaSunroof({super.key});
    
  @override
  _KacaSunroof createState() => _KacaSunroof();
  
} 

class _KacaSunroof extends State<KacaSunroof>{ 

  PriceController priceController = Get.put(PriceController());

  List<String> listFilm = [];  
  List<String> listKacaSunroof = [];    

  var data;
  int hargaJual = 0;
  
  @override
  void initState() { 
    super.initState();
    setState(() { 
      data = priceController.kacaBelakang;
    });
    _getPriceList();
  }

  _getPriceList(){ 
    data.forEach((element) { 
      setState(() {
        listFilm.add('${element.filmType}');
      });
    });  
  }


  @override
  Widget build(BuildContext context){ 
      return Row( 
        children: [
          Expanded(
            flex: 6,
            child: DropdownButtonFormField<String>(  
              menuMaxHeight: Get.height/2,    
              decoration: const InputDecoration(    
              contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30) ), 
              // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white24) ), 
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ), 
              border: OutlineInputBorder( 
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gapPadding: 0,
              ), 
            ),
            // dropdownColor: Colors.blueGrey, 
            dropdownColor: Colors.white, 
            style: const TextStyle(
              color: Colors.black,  
              fontWeight: FontWeight.bold,
              letterSpacing: 1
            ), 
                hint: const Text('-- Tipe Film -- '),     
                 onChanged: (String? v) {  
                    int i = fromList(listFilm, v!);
                    setState(() =>  hargaJual = int.parse( data[i].hargaJual ) );
                    priceController.set_nilaiKacaSunroof(  hargaJual );
                    priceController.hitung_subTotal();
                    print('index ke- $i Harga Jaul $hargaJual');   
                 }, 
                 items: listFilm.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>( value: value, child: Text(value), ); 
                 }).toList(), 
            ),
          ), 
          Container(width: 10,), 
          Flexible(
              flex: 3 , 
              child: Align(
                alignment: Alignment.centerRight, 
                child: Text( rupiah('', hargaJual , 0), style: Css.labelTarif,), 
              ),
            )
        ],
      ); 
  } 
   

}//End