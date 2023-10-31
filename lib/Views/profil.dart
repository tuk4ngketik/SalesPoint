// ignore_for_file: library_private_types_in_public_api, avoid_print, non_constant_identifier_names 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_point/Cfg/css.dart';
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Helper/wg.dart'; 
import 'package:sales_point/Views/login.dart';
import 'package:sales_point/Views/Profil/profil-edit.dart'; 

class Profil extends StatefulWidget{
  const Profil({super.key});
  @override
  _Profil createState() => _Profil();
  
} 

class _Profil extends State<Profil>{ 

  Sess sess = Sess();
  String urlPhoto = 'https://www.sistemgaransi.com/storage/ikool/';
  String? serial, namaLengkap, email, telp, noktp, prov, alamat, pic, imgKtp; 
  bool isLoad = false;

  @override
  void initState() { 
    super.initState();
        sess.getSess('namaLengkap').then((value) => setState(() => namaLengkap = value )  ); 
        sess.getSess('email').then((value) => setState(() =>  email = value ) );
        sess.getSess('phone').then((value) => setState(() =>  telp = value ) );
        sess.getSess('prov').then((value) => setState(() => prov = value )  ); 
        sess.getSess('address').then((value) => setState(() => alamat = value ) ); 
        sess.getSess('serial').then((value) => setState(() => serial = value ) );   
        sess.getSess('noktp').then((value) => setState(() => noktp = value  ) );  
        sess.getSess('pic').then((value) => setState(() => pic = value ) );     
        sess.getSess('img_ktp').then((value) => setState(() { imgKtp = value; print('img $imgKtp'); }) );     
  }

  final double _h_bgTop =  Get.height / 4; // hight bg top 
  double h_profil_img = 150;
  double h_bannerHeader = 220;
  @override 
  Widget build(BuildContext context) {  
    return Stack(
        children: [

          Container(
            height: h_bannerHeader,
            child: Column( 
              children: [ 
                Container(
                  height: h_bannerHeader / 1.5, 
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    // borderRadius: BorderRadius.only(
                    //   bottomLeft: Radius.circular(40),
                    //   bottomRight: Radius.circular(40),
                    // )
                  ),
                  // child: const Center(child: Text('Profil', style: TextStyle(color: Colors.white),),)
                ),
                Container(
                  height: h_bannerHeader / 3,
                  // color: Colors.grey,
                )
              ],
            ),

          ),
          
          Container(  
            margin: const EdgeInsets.only(top:30 ), 
            width: Get.width, 
            // child: imgProfile(),
            child: Column(children: [
              const Text('Profil', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),  
               imgProfile(),
            ],),
          ), 
          
          Container( 
              // margin: EdgeInsets.only(top: _h_bgTop * 1.3 ),
              margin: EdgeInsets.only(top: h_bannerHeader ),
              child:  (namaLengkap == null) ? const Center(child: CircularProgressIndicator()) : ListView(
              padding: const EdgeInsets.all (20),
              children : [

                Card(
                  child: ListTile( 
                    title:   Text('Nama Lengkap', style: Css.profilLabel,),
                    subtitle:  Text('$namaLengkap', style: Css.profilText,),
                  ),
                ),
                // Divider(),
                
                Card(
                  child: ListTile(
                    title:   Text('Email', style: Css.profilLabel,),
                    subtitle:  Text('$email', style: Css.profilText,),
                   ),
                ), 
                
                Card(
                  child: ListTile(
                    title:  Text('No. Telp / Whatsapp', style: Css.profilLabel,),
                    subtitle:  Text('$telp', style: Css.profilText,),
                                ),
                ),
                
                Card(
                  child: ListTile(
                    title:  Text('KTP', style: Css.profilLabel,),
                    subtitle:  Text('$noktp', style: Css.profilText,),
                                ),
                ), 
                
                Card(
                  child: ListTile(
                    title:   Text('Alamat', style: Css.profilLabel,),
                    subtitle:  Text('$alamat', style: Css.profilText,),
                  ),
                ),  

                br(20),
                Container(
                  // color: Colors.yellow,
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      // border: Border.all(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    height: 45,
                    child:  Center(
                      child: TextButton(  
                      onPressed: ()   {   
                        Get.to(  ProfilEdit( serial: serial , namaLengkap: namaLengkap, email: email, telp: telp, noKtp: noktp, alamat: alamat, pic: pic, imgKtp: imgKtp,));  
                      },
                      child:  const Center(
                        child:  Text('Edit Profil', style: TextStyle(fontSize: 17, color: Colors.white),) 
                      ),
                    ),
                    )
                ), 
                         
                br(20),
                Container(
                  // color: Colors.yellow,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      // border: Border.all(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    height: 45,
                    child:  Center(
                      child: TextButton(  
                      onPressed: () async {
                        setState(() =>  isLoad = true );
                        sess.destroy(); 
                        await Future.delayed(const Duration( milliseconds: 500));
                        Get.offAll(const Login());
                      },
                          child:  Center(
                            child: (isLoad == true) ? const CircularProgressIndicator( strokeWidth: 2, ) : const Text('Logout', style: TextStyle(fontSize: 17, color: Colors.black),) 
                          ),
                        ),
                    )
                ), 

              ],
            ),
          )
          
        ],
      );
  }
  
  // Widget bgTop(){ 
  //       return  Container(   
  //           // height: _h_bgTop,  
  //           height: 150,  
  //             padding: const EdgeInsets.all(8.0),
  //           decoration: const BoxDecoration(
  //             color: Colors.black,
  //             borderRadius: BorderRadius.only(
  //               bottomLeft: Radius.circular(10),
  //               bottomRight: Radius.circular(10),
  //             )
  //           ),
  //           child: const Center(child: Text('Profil', style: TextStyle(color: Colors.white, fontSize: 25),),),
  //         );
  // }

  Widget imgProfile(){
      return CircleAvatar(
        backgroundColor: Colors.white,
              radius:80, 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),  
                child:  ( pic == null || pic == 'null' ) ? const Icon(Icons.person, color: Colors.grey, size: 80,) 
                                      : Image.network( urlPhoto + pic! ,  
                                          height: 159,
                                          width: 159,
                                          // fit: BoxFit.cover,                                   // fit: BoxFit.contain, 
                                          fit: BoxFit.fill, 
                                          filterQuality: FilterQuality.low,
                                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) { 
                                            return const Center(child: Text('Image Not Found'));
                                          },   
                      ),
              ),
      );
  }

}