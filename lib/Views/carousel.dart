// ignore_for_file: library_private_types_in_public_api, avoid_print, non_constant_identifier_names, unused_field, prefer_const_constructors 
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 

class Karousel extends StatefulWidget{
  const Karousel({super.key});
  @override
  _Karousel createState() => _Karousel();
  
} 

class _Karousel extends State<Karousel>{ 
 
  bool isLoad = false;

  @override
  void initState() { 
    super.initState();   
  }

  final double _h_bgTop =  Get.height / 4; // hight bg top 
  double h_Karousel_img = 150;

  @override 
  Widget build(BuildContext context) { 
    return Scaffold(   
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('i-Kool Club'),
        toolbarHeight: 100,
      ),
      
      body: Container(
        height: Get.height,
        decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.black, Colors.black38,Colors.black87,])
                ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container( 
                padding: EdgeInsets.all(20), 
                child: Center(child: Text('OTOMOTIF', style: TextStyle(fontSize: 20, color: Colors.white),))
              ),
              Container(  
                padding: EdgeInsets.only(bottom: 10), 
                child: autoPlayImageVkool, 
              ),
               
              // br(20), 
              // Container(
              //   padding: EdgeInsets.all(10),  
              //   child: Center(child: Text('PPF', style: TextStyle(fontSize: 20, color: Colors.white),) )
              
              // ),
              // Container(  
              //   padding: EdgeInsets.only(bottom: 10), 
              //   child: autoPlayImageSolargard,
              // ), 
               
            ],
          ),
        ),
      ),
    );
  }
   
  // Vkool
  static final List<String> imgSliderVkool = [ 
    '1.jpg',
    '2.jpg',
    '3.jpg',
    '4.jpg',
    '5.jpg',
    '7.jpg' 
  ];
 
  final CarouselSlider autoPlayImageVkool= CarouselSlider( 
    items: imgSliderVkool.map((fileImage) {
      return Container( 
        width: Get.width,
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Image.asset(
            'images/vkool/$fileImage',
            width:  Get.width,
            fit: BoxFit.cover,
            // fit: BoxFit.fill,
          ),
        ),
      );
    }).toList(),   
    options: CarouselOptions(
      aspectRatio: 21 / 9, 
      // height: Get.height / 3,
     ),
  );  

  // Solargard
  static final List<String> imgSliderSolargard = [ 
    '1.jpg',
    '2.jpg',
    '3.jpg',
    '4.jpg',
    '5.jpg',
    '7.jpg' 
  ];
 
  final CarouselSlider autoPlayImageSolargard = CarouselSlider(
    items: imgSliderSolargard.map((fileImage) {
      return Container(
        width: Get.width,
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Image.asset(
            'images/solargard/$fileImage',
            width:  Get.width,
            fit: BoxFit.cover,
          ),
        ),
      );
    }).toList(),    
    options: CarouselOptions(
      aspectRatio: 21 / 9,
      // height: Get.height / 3,
     ),
  );

}