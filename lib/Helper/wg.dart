// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget titlePage(BuildContext context, String title){
  return Center(
    child: Container( 
      color: Colors.black,
      height: 40 ,
      child: Center(
        child : Text(title, style: const TextStyle(color: Colors.orange, fontSize: 20, ),)
      ),
    ),
  );
}


Widget br(double height ){
  return Container(
    height: height,
  );
}

Widget spasi(double width){
  return Container(
    width: width,
  );
}

 snackAlert(String title, String message){
  Get.snackbar(
    title, 
    message,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    titleText:  Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
    messageText: Text(message, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
    backgroundColor: Colors.grey,
    icon: const Icon(Icons.info_outline, color: Colors.red, size: 40,)
  );
 }

 snackError(String title, String message){
  Get.snackbar(
    title, 
    message,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    titleText:  Text(title, style: const TextStyle(fontSize: 17),),
    messageText: Text(message, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
    backgroundColor: Colors.yellow[50],
    icon: const Icon(Icons.info_outline, color: Colors.red, size: 40,)
  );
 }

 defaultDialogErr(String msg){ 
          Get.defaultDialog(
            title: '',
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(20),
            content: Column(children:   [
              const Icon(Icons.error, color: Colors.red, size: 40,),
              const Divider(color: Colors.amber,),
              Text(msg)
            ],),
            textCancel: 'Tutup',
            cancelTextColor: Colors.black 
          );
 }