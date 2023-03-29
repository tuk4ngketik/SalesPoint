// // ignore_for_file: library_private_types_in_public_api, avoid_print, unused_element, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables
 
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sales_point/Models/G/PriceController.dart'; 

// class Posisi extends StatefulWidget{  
//   final String posisi;
//   const Posisi({super.key, required this.posisi});  
//   @override
//   _Posisi createState() => _Posisi();
  
// } 

// class _Posisi extends State<Posisi>{ 

//   PriceController priceController = Get.put(PriceController());

//   List<String> listPosisi = []; 

//   @override
//   Widget build(BuildContext context){ 
//       return DropdownButtonFormField<String>(  
//         decoration: const InputDecoration(   
//           contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
//           focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30) ), 
//           enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white24) ), 
//           border: OutlineInputBorder( 
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             gapPadding: 0,
//           ), 
//         ),
//         // dropdownColor: Colors.grey, 
//         style: const TextStyle(
//           color: Colors.black, 
//         ),
//           hint: const Text('-- Pilih Jenis Kaca Film -- '),    
//           elevation: 20, 
//                 // style: Css.txtField,
//            onChanged: (String? v) {  
//                   print('Tipe :  $v');  
//            }, 
//            items: listPosisi.map<DropdownMenuItem<String>>((String value){
//             return DropdownMenuItem<String>( value: value, child: Text(value), ); 
//            }).toList(), 
//       ); 
//   } 
   

// }//End