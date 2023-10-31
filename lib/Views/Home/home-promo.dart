// ignore_for_file: override_on_non_overriding_member, library_private_types_in_public_api, annotate_overrides, prefer_typing_uninitialized_variables, unused_local_variable, prefer_is_empty

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_point/Apis/a_promo.dart';
import 'package:sales_point/Helper/myapp-attr.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Models/donException.dart'; 

class HomePromo extends StatefulWidget{ 
  const HomePromo({super.key }); 
  _HomePromo createState () => _HomePromo(); 
}


class _HomePromo extends State<HomePromo>{
  @override
  String? serial;
  var headers;
  bool isLoad = false;
  MyappAttr myappAttr = MyappAttr();
  ApiPromo apiPromo = ApiPromo();
  
  void initState() { 
    super.initState(); 
    setState(() => isLoad = true );
    myappAttr.retHeader().then((value) {  
        headers = value; 
          _getPromo();
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return (isLoad == true) 
            ? const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child:  LinearProgressIndicator(color: Colors.white,),),
              ) 
            : (imgSlider.length < 1) ? const Text('')
            : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(margin: const EdgeInsets.only(left:20), child: const Text('Promo', style: TextStyle(fontSize: 20, color: Colors.white),)),                            
                br(10),
                CarouselSlider.builder(
                  itemCount: imgSlider.length, 
                  itemBuilder: (context, i, realIndex) {  
                    // return Center(child: Text('${imgSlider[i]}'),);
                    String x= imgSlider[i];
                    return Image.memory( 
                                base64Decode( x.substring(23)  ), 
                                filterQuality: FilterQuality.low, 
                                width: Get.width,
                                // fit: BoxFit.cover ,
                                // fit: BoxFit.fitWidth,
                                fit: BoxFit.contain,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) { 
                                  return const Center(child: Text('😢 Image Not Found  😢'));
                                },   
                            );
                  }, 
                  options: CarouselOptions(
                    // aspectRatio: 10/12, 
                    aspectRatio:1/1,  
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    clipBehavior: Clip.none,
                    pageSnapping: false, 
                    viewportFraction: 0.99, 
                    // padEnds: false,
                     
                  ),
                ),
              ],
            );
  } 

   
  List<String> imgSlider = [];

  _getPromo(){ 
    
    apiPromo.getPromo(headers).then((v){
      bool? status = v!.status;
      String? msg = v.message;
      if(status == false){ 
         defaultSnackError(msg!);
         setState(() => isLoad = false );
        return;
      }
      var dataPromo = v.data;
      for (var element in dataPromo!) {
        // print('promoName ${element.promoName}');
        setState(() {
          // imgSlider.add( '${element.promoName}' );
          imgSlider.add( '${element.imgFile}' );
        });
      }
      setState(() => isLoad = false );
    })
    // .onError((error, stackTrace) => null );
    .catchError((e){ 
      setState(() =>  isLoad = false );
      snackError('Error load promo', '${e.msg}');  
    }) ;  
  }

}