 

import 'package:intl/intl.dart';

int fromList(List<String> list, String val){ 
  int i = list.indexWhere((item) => item == val);
  return i;
}

fromMap(var map){
  var key = map.keys.firstWhere((k) => map[k] == 'Brazil', orElse: () => null);
  return key; 
}

//Ex : 
// rupiah('', 3500000,  0) =>   3.500.000
// rupiah('Rp ', 3500000,  2) => R3.500.000, 00
String rupiah(String simbol, dynamic nilai,  int digitCent){ 
  var f  = NumberFormat.simpleCurrency(locale: 'id',   name: simbol, decimalDigits: digitCent);  
  return  f.format(nilai);
}