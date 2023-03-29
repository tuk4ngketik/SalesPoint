// ignore_for_file: library_private_types_in_public_api, avoid_print 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_point/Cfg/css.dart';
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Views/login.dart'; 

class Profil extends StatefulWidget{
  const Profil({super.key});
  @override
  _Profil createState() => _Profil();
  
} 

class _Profil extends State<Profil>{ 

  Sess sess = Sess();
  String? namaDepan, namaBelakang, email, telp, prov, alamat;

  @override
  void initState() { 
    super.initState();
        sess.getSess('first_name').then((value) => setState(() => namaDepan = value )  );
        sess.getSess('last_name').then((value) => setState(() => namaBelakang = value  ) );
        sess.getSess('email').then((value) => setState(() =>  email = value ) );
        sess.getSess('phone').then((value) => setState(() =>  telp = value ) );
        sess.getSess('prov').then((value) => setState(() => prov = value )  ); 
        sess.getSess('address').then((value) => setState(() => alamat = value ) ); 
  }

  @override
  Widget build(BuildContext context){

    return Column(
      children: [ 

        Stack(
          clipBehavior: Clip.none,// <-- add this
          children: [
            Container(
              height: 180,
              decoration: const BoxDecoration(
                  image: DecorationImage( 
                    image: AssetImage("images/bg2.jpg"), 
                    fit: BoxFit.cover,
                  ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
                color: Colors.black,
              ),
            ),
            Positioned(
                bottom: -50,// <-- add this 
                // left: MediaQuery.of(context).size.width / 3,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80, 
                        child: Icon(Icons.person, size: 150,color: Colors.black,),)
                  ),
                )),
          ], 
        ),    
        br(30),

        Expanded(
          child: (namaDepan == null) ? const Center(child: CircularProgressIndicator()) : Padding(
            padding: const EdgeInsets.all(30.0),
            child: Card(
                color: Colors.white10,
              child: ListView(
                padding: const EdgeInsets.all (20),
                children : [
                   ListTile(
                    title: const Text('Name'),
                    subtitle:  Text('$namaDepan $namaBelakang', style: Css.profilText,),
                               ),
                  // Divider(),
                   ListTile(
                    title: const Text('Email'),
                    subtitle:  Text('$email', style: Css.profilText,),
                  ),
                  
                   ListTile(
                    title:const Text('Telp'),
                    subtitle:  Text('$telp', style: Css.profilText,),
                  ),
            
                  ListTile(
                    title: const Text('Province'),
                    subtitle:  Text('$prov', style: Css.profilText,),
                  ),  
            
                  ListTile(
                    title: const Text('Address'),
                    subtitle:  Text('$alamat', style: Css.profilText,),
                  ),  
            
                  // Center(
                  //   child: TextButton( 
                  //       onPressed: () => Get.to(const Login()), 
                  //       child:  Center(
                  //         child: Text('Logout', style: TextStyle(fontSize: 18, color: Colors.yellow[600]),) 
                  //       ),
                  //     ),
                  // ), 
                  
                  Container(
                    // color: Colors.yellow,
                      decoration: const BoxDecoration(
                        color: Colors.yellow,
                        // border: Border.all(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      height: 35,
                      child:  Center(
                        child: TextButton( 
                        // onPressed: () => Get.to(const Login()), 
                        onPressed: (){
                          sess.destroy();
                          Get.offAll(const Login());
                        },
                            child:  const Center(
                              child:   Text('Logout', style: TextStyle(fontSize: 17, color: Colors.black),) 
                            ),
                          ),
                      )
                    ), 
            
                ],
              ),
            ),
          ),
        ),
          
      ],
    ); 
  }

}