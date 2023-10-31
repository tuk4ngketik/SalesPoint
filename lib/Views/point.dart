// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_field, unused_element, prefer_typing_uninitialized_variables, unused_local_variable, prefer_is_empty, non_constant_identifier_names, sort_child_properties_last  
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
// import 'package:sales_point/dondrawer.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_point/Apis/a_point.dart';
import 'package:sales_point/Cfg/css.dart';
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Models/G/PointController.dart';
import 'package:sales_point/Views/Point/Point/list-point.dart';
import 'package:sales_point/Views/Point/Transaksi/point_transaksi.dart';  

class Point extends StatefulWidget  {
  const Point({super.key});
  @override
  _Point createState() => _Point();
  
} 

class _Point extends State<Point> with TickerProviderStateMixin{ 
  
  PointController pointController = Get.put(PointController());
  
  late TabController tabController ;
  Sess sess = Sess(); 
  ApiPoint apiPoint = ApiPoint();
  bool isLoad = true;
  int totalPoint = 0;
  var headers; 

  @override
  void initState() {
    super.initState();  
    tabController = TabController(length: 2, vsync: this );  
  }
  

  @override
  Widget build(BuildContext context){
    return Scaffold( 
      appBar: AppBar( 
        backgroundColor: Colors.black87,
        // backgroundColor: Colors.amber,
        toolbarHeight: 125,
        // shape: Css.roundBottomAppbar,  
        title: Column(
          children:  [ 
            const Icon(Icons.diamond_outlined, color: Colors.white, size: 100,),  
            Obx(() => Text( '${pointController.totalPoint} Poin', style: const TextStyle(color:Colors.white ),)  ), 
          ],
        ),
        centerTitle: true,
        bottom: TabBar(
          tabs: _bottomNavigationBar,
          controller: tabController,  
          indicatorColor: Colors.yellowAccent,
        ) ,
      ),  
      body: TabBarView( children : _listWidget, controller:tabController  )
    );
  }

  final List<Widget> _bottomNavigationBar = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Poin', style: Css.tabbar,),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Transaksi', style: Css.tabbar,),
    ),
  ];
  
  final List<Widget> _listWidget = [
     const ListPoint(), 
    PointTransaksi()
  ]; 

}