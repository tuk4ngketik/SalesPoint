// ignore_for_file: file_names, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_string_interpolations


import 'package:get/get.dart';

class PriceController extends GetxController{ 


  var brand = ''.obs;
  setBrand(String v) => brand.value = v;
  
  var tipe = ''.obs;
  setTipe(String v) => tipe.value = v;
  
  // Harga Item Kaca
  final nilai_kacaDepan = 0.obs;
  set_nilaiKacaDepan(int v) => nilai_kacaDepan.value = v;
  
  final nilai_kacaSamping = 0.obs;
  set_nilaiKacaSamping(int v) => nilai_kacaSamping.value = v;
  
  var nilai_kacaBelakang = 0.obs;
  set_nilaiKacaBelakang(int v) => nilai_kacaBelakang.value = v;

  var nilai_kacaSunroof = 0.obs;
  set_nilaiKacaSunroof(int v) => nilai_kacaSunroof.value = v;
 
  // Tipe Film terpilih
  final film_kacaDepan = '-'.obs;
  set_filmKacaDepan(String v) => film_kacaDepan.value = v;
  
  final film_kacaSamping = '-'.obs;
  set_filmKacaSamping(String v) => film_kacaSamping.value = v;
  
  var film_kacaBelakang = '-'.obs;
  set_filmKacaBelakang(String v) => film_kacaBelakang.value = v;

  var film_kacaSunroof = '-'.obs;
  set_filmKacaSunroof(String v) => film_kacaSunroof.value = v; 
  
  final kacaDepan = [].obs;
  set_kacaDepan(var v) {
    kacaDepan.value = v;
  }
   
  final kacaBelakang = [].obs;
  set_kacaBelakang(v) {
    kacaBelakang.value = v;
  }
 
  final kacaSamping = [].obs;
  set_kacaSamping(v) {
    kacaSamping.value = v;
  }
 
  final kacaSunroof = [].obs;
  set_kacaSunroof( v) {
    kacaSunroof.value = v;
  }

  // Discount,  Sub Total n Total
  var diskon = 0.obs;
  set_diskon( v) {
    diskon.value = v;
  } 

  var subtotal = 0.obs;
  hitung_subTotal(){ 
    subtotal.value = nilai_kacaDepan.value  + nilai_kacaSamping.value + nilai_kacaBelakang.value + nilai_kacaSunroof.value; // OK
    // subtotal.value = nilai_kacaDepan.toInt()  + nilai_kacaSamping.toInt() + nilai_kacaBelakang.toInt() + nilai_kacaSunroof.toInt(); // OK juga 
  }
  clear_subTotal(){ 
    subtotal.value = 0;
  }

  var total =  0.obs ;
  set_total(int v) => total.value = v ; 
  clear_total() =>  total.value =  0; 
  
  // var brand = ''.obs;
  // setBrand(String v) => brand.value = v;
  
  // var tipe = ''.obs;
  // setTipe(String v) => tipe.value = v;
  
  // final nilai_kacaDepan = 0.obs;
  // set_nilaiKacaDepan(int v) => nilai_kacaDepan.value = v;
  
  // final nilai_kacaSamping = 0.obs;
  // set_nilaiKacaSamping(int v) => nilai_kacaSamping.value = v;
  
  // var nilai_kacaBelakang = 0.obs;
  // set_nilaiKacaBelakang(int v) => nilai_kacaBelakang.value = v;

  // var nilai_kacaSunroof = 0.obs;
  // set_nilaiKacaSunroof(int v) => nilai_kacaSunroof.value = v;
 
  
  // final kacaDepan = [].obs;
  // set_kacaDepan(var v) {
  //   kacaDepan.value = v;
  // }
   
  // final kacaBelakang = [].obs;
  // set_kacaBelakang(v) {
  //   kacaBelakang.value = v;
  // }
 
  // final kacaSamping = [].obs;
  // set_kacaSamping(v) {
  //   kacaSamping.value = v;
  // }
 
  // final kacaSunroof = [].obs;
  // set_kacaSunroof( v) {
  //   kacaSunroof.value = v;
  // }

  // // Discount,  Sub Total n Total
  // var diskon = 0.obs;
  // set_diskon( v) {
  //   diskon.value = v;
  // } 

  // var subtotal = 0.obs;
  // hitung_subTotal(){ 
  //   subtotal.value = nilai_kacaDepan.value  + nilai_kacaSamping.value + nilai_kacaBelakang.value + nilai_kacaSunroof.value; // OK
  //   // subtotal.value = nilai_kacaDepan.toInt()  + nilai_kacaSamping.toInt() + nilai_kacaBelakang.toInt() + nilai_kacaSunroof.toInt(); // OK juga 
  // }
  // clear_subTotal(){ 
  //   subtotal.value = 0;
  // }

  // var total =  0.obs ;
  // set_total(int v) => total.value = v ; 
  // clear_total() =>  total.value =  0; 
}