// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, file_names, non_constant_identifier_names, avoid_print
 

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:sales_point/Cfg/css.dart';
import 'package:sales_point/Helper/wg.dart';

class EditDataPribadi extends StatefulWidget{
  final namaLengkap, noKtp,address, pic, img_ktp; 
  const EditDataPribadi({super.key, required this.namaLengkap, required this.noKtp, required this.address, required this.pic, required this.img_ktp}); 
  @override
  _EditDataPribadi createState() => _EditDataPribadi();
}

class _EditDataPribadi extends State<EditDataPribadi>{

  bool isLoad =  false;
  String urlPhoto = 'https://www.sistemgaransi.com/storage/ikool/';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [  
                      TextFormField( 
                        initialValue: widget.namaLengkap,
                        decoration:  InputDecoration(           
                          border: Css.round20,      
                              prefixIcon: const Icon(Icons.person, color: Colors.black),
                          labelStyle: Css.labelStyle,
                          labelText: 'Nama Lengkap' , 
                        ),
                        // controller: idforgot,
                      ),
                      br(15),
                      
                      TextFormField( 
                        initialValue: widget.noKtp,
                        decoration:  InputDecoration(           
                          border: Css.round20,      
                          prefixIcon: const Icon(Icons.tag , color: Colors.black) ,
                          labelStyle: Css.labelStyle,
                          labelText: 'No. KTP ' , 
                        ),
                        // controller: idforgot,
                      ), 
                      br(15),  
                      TextFormField( 
                        maxLines: 3,
                        initialValue: widget.address,
                        decoration:  InputDecoration(           
                          border: Css.round20,      
                          prefixIcon: const Icon(Icons.streetview , color: Colors.black) ,
                          labelStyle: Css.labelStyle,
                          labelText: 'Alamat' , 
                        ),
                        // controller: idforgot,
                      ),  
                      br(15),  

                      Row(
                        children: [  
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                const Center(child: Text('Foto Profil'),),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  color: Colors.black12,
                                  child:  InkWell(
                                    onTap: ()=> openImage('Foto Profil' , widget.pic),
                                    child: buildImage(widget.pic)
                                  ),
                                ),
                                IconButton(onPressed: ()=> print('Change Pic'), icon: const Icon(Icons.image))
                              ],
                            ),
                          ),  
                          spasi(10),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                const Center(child: Text('Foto KTP'),),
                                Container(
                                  color: Colors.black12,
                                  padding: const EdgeInsets.all(5), 
                                  child:  InkWell(
                                    onTap: ()=> openImage('Foto KTP' , widget.img_ktp),
                                    child: buildImage(widget.img_ktp)
                                  ),
                                ),
                                IconButton(onPressed: ()=> print('Change KTP'), icon: const Icon(Icons.image))
                              ],
                            ),
                          ),  
                        ],
                      ),
                      br(15),
                                         
                      TextFormField( 
                        obscureText: true,
                        decoration:  InputDecoration(           
                          border: Css.round20,      
                          prefixIcon: const Icon(Icons.key,  color: Colors.black),
                          labelStyle: Css.labelStyle,
                          labelText: 'Kata sandi saat ini ' , 
                        ),
                        // controller: idforgot,
                      ),
                      br(25), 
                      
                      Container(
                        // color: Colors.yellow,
                          decoration: const BoxDecoration(
                            color: Colors.amber,   
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          height: 55,
                          child:  Center(
                            child: TextButton( 
                                onPressed: (){    
                                  if (_formKey.currentState!.validate() == false) { return; } 
                                },
                                child:  Center(
                                  child: ( isLoad == true ) 
                                    ? const CircularProgressIndicator(color: Colors.orange,)
                                    : const Text('Perbaharui Data', style: TextStyle(fontSize: 18, color: Colors.black),)
                                    // : const Icon(Icons.send)
                                ),
                              ),
                          )
                      ),
                          
         
          ],
        ),
      ),
    ); 
  } 

  Widget buildImage(String img){
    return Image.network( urlPhoto + img, 
                                                height: 150, 
                                                // fit: BoxFit.cover,                                   // fit: BoxFit.contain, 
                                                // // fit: BoxFit.fill, 
                                                filterQuality: FilterQuality.low,
                                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) { 
                                                  return const Center(child: Text('Image Not Found'));
                                                },   
                              );
  }
  
 openImage(String title, String path){ 
  Get.defaultDialog(
    title: title,
    titlePadding: const EdgeInsets.all(0),
    contentPadding: const EdgeInsets.all(10),
    content: Image.network(urlPhoto + path),
    textCancel: 'Tutup',
    cancelTextColor: Colors.black 
  );
 }


}