// ignore_for_file: file_names, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_string_interpolations


import 'package:get/get.dart';

class PointController extends GetxController{  
  
  final totalPoint = 0.obs;
  set_totalPoint(int v) => totalPoint.value = v;
   
  
}