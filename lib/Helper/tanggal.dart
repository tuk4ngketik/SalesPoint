// import 'package:flutter/material.dart';

class Tanggal{

  // date 2023-03-07 10:00:02.617882
  DateTime  sekarang = DateTime.now();
  
  String ymdDetik (){
    final ymd =   DateTime.utc( sekarang.year, sekarang.month, sekarang.day);
    return ymd.toString();
  }

  // thn-bln-tgl 
  String ymdDash(){
    String tgl = ymdDetik();
    final splitted = tgl.split(' ');
    return splitted[0]; 
  }
  String ymd(){ 
    String tgl = ymdDetik();
    final a = tgl.split(' ');
    final s = a[0].split('-');
    return '${s[0]}${s[1]}${s[2]}'; 
  }

  // tgl-bln-thn
  String dmyDash(){
    String tgl = ymdDetik();
    final dmy = tgl.split(' '); 
    final s = dmy[0].split('-');
    return '${s[2]}-${s[1]}-${s[0]}'; 
  }

  String dmy(){
    String tgl = ymdDetik();
    final dmy = tgl.split(' '); 
    final s = dmy[0].split('-');
    return '${s[2]}${s[1]}${s[0]}'; 
  }

}