// // ignore_for_file: non_constant_identifier_names, must_be_immutable, file_names, avoid_print, unused_local_variable, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, unused_field, avoid_unnecessary_containers

// import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';
// import 'package:sales_point/Helper/wg.dart';
// import 'package:sales_point/Models/G/DealermapController.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Infowindowsmap extends StatelessWidget{

//   DealermapController dealermapController = Get.put(DealermapController());
//   String name;
//   String name_pembanding;  
//   LatLng? dealerLatlong;

//   // Location
//     Location location = Location();   
//     late bool _gpsActive;
//     late PermissionStatus _permissionGranted;
//     late LocationData _locationData;  
//     late LatLng latlongUser ;

//   // Infowindowsmap({super.key,  required this.name, required this.name_pembanding,  this.userLatlong,  this.dealerLatlong}); 
//   Infowindowsmap({super.key,  required this.name, required this.name_pembanding,   this.dealerLatlong}); 

//   @override
//   Widget build(BuildContext context) {
     
//   double? dealerLat = dealerLatlong!.latitude;
//   double? dealerLgt = dealerLatlong!.longitude;

//     return Visibility(
//       visible:( name_pembanding  ==  name) ? true : false,
//       child: Container(
//         height: 400,
//         width: 400,
//         margin: const EdgeInsets.only(bottom: 100),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           // color: Colors.white70
//           color: Colors.black54,
//           border: Border.all(
//             color: Colors.grey,
//             width: 2,
//           )
//         ),
//         child:  Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Stack( 
//             children: [ 
//               Positioned(  
//                 top: -18,
//                 right: -18,
//                 // child: IconButton(onPressed: ()=>null, icon: FaIcon(FontAwesomeIcons.close))
//                 child: IconButton(onPressed: (){
//                   print('Close INfowindow');
//                   dealermapController.set_infowindowShow(null);
//                   print('dealermapController ${dealermapController.infowindowShow}');

//                 }, icon: const Icon(Icons.close, size: 20,))
//               ),
//               Container(
//                 child: Column(
//                   children: [
//                     Expanded(
//                       flex: 6,
//                       child: Center(
//                         child: Text(name, 
//                         style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
//                         )
//                       )
//                     ), 
//                     const Divider(height: 0.1,color: Colors.white,),
//                       Expanded(
//                         flex: 5,
//                         child: TextButton.icon(
//                           onPressed: () async {
//                             await _getLocation(); 
//                             double? userLat = latlongUser.latitude;
//                             double? userLgt = latlongUser.longitude;
//                             print('Diraction from $latlongUser'); 
//                             if(latlongUser == null ){
//                               defaultDialogErr('Aktifkan GPS anda');
//                               return;
//                             } 
//                             final Uri _url = Uri.parse('https://www.google.com/maps/dir/$userLat,$userLgt/$dealerLat,$dealerLgt'); 
//                             _openGmaps(_url);
                            
//                           }, 
//                           icon: const FaIcon(FontAwesomeIcons.route, size: 15,color: Colors.yellow,), 
//                           label: const Text('Direction', style: TextStyle(fontSize: 13,color: Colors.yellow,),)
//                         ),
//                       )

//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );

//   }

  
//   Future<void> _openGmaps(Uri _url) async {   
//     if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
//       throw Exception('Could not launch $_url');
//     }
//   }

 
    
//     _getLocation() async {   

//       bool _serviceEnabled; 
//       _serviceEnabled = await location.serviceEnabled();
//       if (!_serviceEnabled) {
//         _serviceEnabled = await location.requestService();
//         if (!_serviceEnabled) {  return ;  }
//       }

//       _permissionGranted = await location.hasPermission();
//       if (_permissionGranted == PermissionStatus.denied) {
//         _permissionGranted = await location.requestPermission();
//         if (_permissionGranted != PermissionStatus.granted) {  return ; }
//       }

//       _locationData = await location.getLocation(); 
//       latlongUser = LatLng( _locationData.latitude!.toDouble() , _locationData.longitude!.toDouble());
//       print('latlongUser $latlongUser');
//       // return latlongUser; s
//     } 

// }