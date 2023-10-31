// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_final_fields, unused_field, non_constant_identifier_names, unused_local_variable, prefer_typing_uninitialized_variables, annotate_overrides 

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_point/Apis/a_promo.dart';
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Helper/myapp-attr.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Views/Home/home-point.dart';
import 'package:sales_point/Views/Home/home-promo.dart';
import 'package:sales_point/Views/dealer-map.dart';   

class Home extends StatefulWidget{ 
  // final String  serial, namaLengkap, kelengkapan;
  // const Home({super.key, required this.serial, required this.namaLengkap,  required this.kelengkapan});

  const Home({super.key});
  @override
  _Home createState() => _Home();  
} 
 

class _Home extends State<Home>{
  
  ApiPromo apiPromo = ApiPromo();
  MyappAttr myappAttr = MyappAttr();
  Sess sess = Sess();
  var headers;
  double _scrollPosition = 0 ; 
  ScrollController _scrollController = ScrollController();
  _scrollListener()   {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      // print('_scrollPosition $_scrollPosition');
    });
  }
  
  String? status_app, serial, namaLengkap, mail, kelengkapan; 
  void initState() { 
    super.initState();     
    _scrollController.addListener(() =>  _scrollListener()  ); 
     
    sess.getSess('serial').then((value) => setState(() => serial = value));  
    sess.getSess('namaLengkap').then((value) => setState(() => namaLengkap  = value));  
    sess.getSess('kelengkapan').then((value) => setState(() => kelengkapan  = value)); 
    myappAttr.retHeader().then((value) {
      headers = value;
      // _getPromo();
    });
  } 
 
  final double _h_bgTop =  Get.height / 4;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
              // height: Get.height,
              width: Get.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.black87, Colors.black38,Colors.black87,]),
                  // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))
                ),
        child: CustomScrollView(
          controller : _scrollController,
          slivers: [
                      SliverAppBar(  
                        // backgroundColor:  ( _scrollPosition < 80 ) ?   Colors.transparent : Colors.black,   
                        backgroundColor:  ( _scrollPosition < 80 ) ?   Colors.transparent : Colors.black,    
                        expandedHeight:  _h_bgTop,
                        pinned: true,
                        title: ( _scrollPosition < 80 ) ?  null
                          :  const Text('i-Kool Club', 
                              style: TextStyle(fontSize: 20, 
                                    fontWeight: FontWeight.bold, 
                              )
                        ),   
                        flexibleSpace: FlexibleSpaceBar(  
                          background: Container(
                            decoration: const BoxDecoration(
                              // gradient: LinearGradient(colors: [Colors.black45, Colors.black38,Colors.black12,]), 
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                                // bottomRight:  Radius.circular(80),
                               ), 
                              color: Colors.black, 
                            ),
                            child: Image.asset('images/ikool-apps-logo.png', color: Colors.white,), 
                          ),
                        ),  
                      ),   
                      SliverList( 
                        delegate: SliverChildListDelegate(  
                          [ 

                            br(10),
                            (namaLengkap == null) ? const LinearProgressIndicator() 
                              : HomePoint(serial: serial!, namaLengkap: namaLengkap!), 

                            br(10),
                            // Container(margin: const EdgeInsets.only(left:20), child: const Text('Promo', style: TextStyle(fontSize: 20, color: Colors.white),)),
                            // InkWell( 
                            //   onTap:() =>  defaultDialogErr('Open Page Promo'),
                            //   child: Container( 
                            //     width: Get.width,
                            //       margin: const EdgeInsets.all(10),
                            //     child: ClipRRect(
                            //       borderRadius: const BorderRadius.all(Radius.circular(10)),
                            //       child: Image.asset(
                            //         'images/home-promo-02.jpg',
                            //         width:  Get.width,
                            //         fit: BoxFit.cover,
                            //         // fit: BoxFit.fill,
                            //       ),
                            //     ),
                            //   ),
                            // ), 
                            // InkWell(
                            //   onTap:() =>  defaultDialogErr('Open Page Promo'),
                            //   child: Container( 
                            //     width: Get.width,
                            //       margin: const EdgeInsets.all(10),
                            //     child: ClipRRect(
                            //       borderRadius: const BorderRadius.all(Radius.circular(10)),
                            //       child: Image.asset(
                            //         'images/home-event-01.jpg',
                            //         width:  Get.width,
                            //         fit: BoxFit.cover, 
                            //       ),
                            //     ),
                            //   ),
                            // ),  

                            // Promo
                            const HomePromo(),
                            
                            br(20),
                            Container(margin: const EdgeInsets.only(left:20),child: const Text('Dealer', style: TextStyle(fontSize: 20, color: Colors.white),)),
                            InkWell( 
                              onTap: () => Get.to(() => const DealerMap()),
                              child: Container( 
                                width: Get.width,
                                  margin: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset(
                                    'images/home-dealer-01.jpg',
                                    width:  Get.width,
                                    fit: BoxFit.cover,
                                    // fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),  
                          ]
                        )
                      )
                      
          ],
        ),
      ),
    );
  }

}