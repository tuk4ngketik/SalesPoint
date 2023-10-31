// ignore_for_file: library_private_types_in_public_api,  avoid_print, unused_local_variable, unused_element, unnecessary_null_comparison, annotate_overrides, unused_field, unused_import, no_leading_underscores_for_local_identifiers, file_names, prefer_final_fields, non_constant_identifier_names, sized_box_for_whitespace
// avoid_function_literals_in_foreach_calls,
import 'dart:convert'; 
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_map/flutter_map.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:sales_point/Apis/a_dealer.dart';
import 'package:sales_point/Helper/get_key.dart';
import 'package:sales_point/Helper/myapp-attr.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Models/G/DealermapController.dart';
import 'package:sales_point/Views/Dealermap/infowindow-map.dart';
import 'package:sales_point/Views/Dealermap/search-dealer.dart';
import 'package:url_launcher/url_launcher.dart';
  

class DealerMap extends StatefulWidget{
  const DealerMap({super.key});   
  _DealerMap createState() => _DealerMap();
}

class _DealerMap extends State<DealerMap>  with TickerProviderStateMixin {
 
   
  ApiDealer apiDealer = ApiDealer(); 
  MyappAttr myappAttr = MyappAttr(); 
  LatLng _indonesia = LatLng(-1.493971,118.168945); 
  LatLng _center = LatLng(-1.493971,118.168945);  

  late LatLng _cureentPosition; 
  late final MapController mapController; 
  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';
  double currentZoom = 4.00;   double minZoom = 4;  double maxZoom = 18; 
  bool isLoad = false; bool isMapReady = false; bool loadCurrentPosition = false;
  String? dealerSelected; // Jika marker di click
  String titleCurrentUser = 'Posisi Anda';

  List<Marker> markers = [];        // MArker dealer
  List<String> markerNames = [];    // Dealer Name
  List<Widget> infowindows = []; 
  Marker? markerUser;
  late LatLng latlongUser;
  int? lengthDealer;
  double _h_marker_widget = 250;
  double _w_marker_widget = 250;
  String _url = 'https://www.google.com/maps/dir/'; //$userLat,$userLgt/$dealerLat,$dealerLgt'); 

  // Location
    Location location = Location();   
    late bool _gpsActive;
    late PermissionStatus _permissionGranted;
    late LocationData _locationData;  


  @override
  void initState() {
    super.initState();
    myappAttr.retHeader().then((v){ 
      _getDealer(v);
    });
    mapController = MapController(); 
  }

  _infoWindoClose(){
    setState(() =>  dealerSelected = null );
    _animatedMapMove( _indonesia,  minZoom ); 
     _type.clear() ;
  }

  Widget _widgetInfoWindow(String name, LatLng point){
    int i = fromList(markerNames,  name);
    return (dealerSelected != name) ? const Text('') : Stack( 
          children: [  
            Container(
              margin: const EdgeInsets.only(top:10, right: 10, bottom: 130),
              // color: Colors.white54,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all( color: Colors.black )
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Center(
                      child: Text(name, 
                      style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    )
                  ), 
                  (dealerSelected == titleCurrentUser) ? const Text('') : const Divider(height: 0.1,color: Colors.grey,),
                  (dealerSelected == titleCurrentUser) ? const Text('') : Expanded(
                    flex: 5,
                    child: TextButton.icon(
                      onPressed: () async {
                        await _getLocation(); 
                        double? userLat = latlongUser.latitude;
                        double? userLgt = latlongUser.longitude; 
                        double? dealerLat = point.latitude;
                        double? dealerLgt = point.longitude;
                        print('Direction from $latlongUser :: $point');  
                        // $userLat,$userLgt/$dealerLat,$dealerLgt
                         _openGmaps(Uri.parse('$_url/$dealerLat,$dealerLgt/$userLat,$userLgt'));
                      }, 
                      // icon: const FaIcon(FontAwesomeIcons.route, size: 15 ,),  
                      icon: const Icon(Icons.directions),  
                      label: const Text('Direction', style: TextStyle(fontSize: 13, ),)
                    ),
                  )

                ],
              ),
            ),
            Positioned(  
              top: -10, right: -10, 
              child: IconButton(
                onPressed: () => _infoWindoClose(),
                icon: const Icon(Icons.close, size: 25, weight: 100 ))
            ),
          ],
        );
  }

  _getDealer(var headers){
    setState(() => isLoad = true );
    await () => isMapReady = true;
    apiDealer.getDealer(headers).then((v){
      bool? status = v!.status;
      String? msg = v.message;
      if(status == false){
        snackError('', msg!);
        return;
      }
      var data = v.data;  
      
      for (var element in data!) { 
        if( element.latitude == null || element.longitude  == null || element.latitude == '' || element.longitude  == '' ) {  
          continue;
        }
        print('${element.branchName} ${element.latitude}, ${element.longitude}');
        String name = '${element.branchName}';
        double lat = double.parse('${element.latitude}');
        double lgt = double.parse('${element.longitude}');
        LatLng point = LatLng( lat, lgt); 

        Marker marker = Marker(  
          // rotate: false,
              point: point, 
              builder: (ctx) =>  Stack(
                children: [     
                  _widgetInfoWindow( name,  point),
                  Center(child: IconButton(
                      onPressed: () => _visibleInfoWindow(name, point), 
                      icon: const Icon(Icons.location_pin, size: 25, ))
                    ), 
                ],
              ),
              width: _w_marker_widget,
              height: _h_marker_widget,
        );
        
        setState((){ 
          markers.add(marker); 
          markerNames.add(name); 
        });  
      } 
      setState(() {
         lengthDealer = markerNames.length;
         isLoad = false;
      });

    })
    .catchError((e){
      setState(() {
        isLoad = false; 
      });
      snackError('Error Maps', '${e.msg}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('V-KOOL Delaer'),
        backgroundColor: Colors.black,
      ), 
      body:  Stack(
        children: [             
            FlutterMap(
            mapController: mapController,  
            options: MapOptions(
              center: LatLng( -0.789275,113.921326 ),  
              zoom: currentZoom, 
              onMapReady: (){
                setState(() =>  isMapReady = true );
                print('onMapReady MapReady');
              }, 
              onMapEvent: (MapEvent e) {  
                _center = e.center; 
                // print('mapEvent ${e.center}');
              },
              
            ) ,
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                // userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                userAgentPackageName: 'com.vkoolid.reseller.point', 
              ),
              MarkerLayer(
                markers: markers,             
              )
            ],
          ), 
          (isLoad == true ) ?  const Center(child: RefreshProgressIndicator(color: Colors.amber,),) : const Text('') ,
          searchDealer(), 
          (loadCurrentPosition ==  false) ? const Text('') 
          : Center(
             child: Container(
              // margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              // height: 90,
              color: Colors.white70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:   [
                  Container( width : 180, child : const LinearProgressIndicator(color: Colors.amber )),
                  const Text('Loading position', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)
                ],
              ),
            ),
          )
        ]
      ), 
      floatingActionButton: SizedBox(
        height: 150,
        width: 50,
        child: Column(
          children: [ 
            IconButton(onPressed:  () => _zoomOut(),  icon: const Icon(Icons.zoom_out,size: 50,color: Colors.blueGrey,), 
           
            ),  
            IconButton(onPressed: () => _zoomIn() , icon: const Icon(Icons.zoom_in, size: 50,color: Colors.blueGrey,),  ),   
            IconButton(onPressed: () => _goToCurreentPosition() , icon: const Icon(Icons.location_searching_sharp, size: 40,color: Colors.blueGrey,),  ),  
          ],
        ),
      ), 
    );
  }  

  _visibleInfoWindow( String name, LatLng destLocation ){  
      setState(() { 
        dealerSelected = name; 
        _center = destLocation;
        currentZoom = maxZoom / 2;
      });    
      _animatedMapMove( destLocation,   maxZoom / 2);
  }
 
  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination. 
    // final camera = mapController.camera; 
    final latTween = Tween<double>(  begin: _center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(  begin: _center.longitude, end: destLocation.longitude);
    // final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);
    final zoomTween = Tween<double>(begin: 5, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    final controller = AnimationController( duration: const Duration(milliseconds: 1000), vsync: this);  
    final Animation<double> animation =  CurvedAnimation(parent: controller, curve: Curves.slowMiddle); // rada OK 
    // final startIdWithTarget =  '$_startedId#${destLocation.latitude},${destLocation.longitude},$destZoom';
    bool hasTriggeredMove = false;

    controller.addListener(() {
      // final String id;
      // if (animation.value == 1.0) {
      //   id = _finishedId;
      // } else if (!hasTriggeredMove) {
      //   id = startIdWithTarget;
      // } else {
      //   id = _inProgressId;
      // }

      hasTriggeredMove |= mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation), 
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    }); 
    controller.forward();
  }
  
  void _zoomOut() { 
      setState(()  => currentZoom -= 1 );
      if(currentZoom<= 4) {
        setState(() =>  currentZoom = 4 );
      }
      mapController.move( _center, currentZoom);
      print('_zoomOut() : currentZoom $currentZoom'); 
  }

  void _zoomIn() {  
      setState(()  => currentZoom += 1 );
      if(currentZoom>= maxZoom ) {
        setState(() =>  currentZoom = maxZoom );
      }
      mapController.move( _center, currentZoom); 
      print('_zoomIn() : currentZoom $currentZoom');
  }
   
  _getLocation() async {  
      
      if(markerNames.length > lengthDealer! ){ 
        markers.removeLast();
        markerNames.removeLast();
       }
       setState(() => loadCurrentPosition = true );
      bool _serviceEnabled; 
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) { setState(() => loadCurrentPosition = false ); defaultDialogErr('Aktifkan GPS Anda'); return ;  }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) { setState(() => loadCurrentPosition = false ); defaultDialogErr('Aktifkan GPS Anda');  return ; }
      }

      _locationData = await location.getLocation(); 
      latlongUser = LatLng( _locationData.latitude!.toDouble() , _locationData.longitude!.toDouble());
      print('latlongUser $latlongUser'); 
       setState(() => loadCurrentPosition = false );
      // return latlongUser; s
  } 

  _goToCurreentPosition() async {

        await _getLocation();

        setState(() => _center = latlongUser ); 
        markerUser = Marker( 
          point: latlongUser,   
          builder: (ctx) =>  Stack(
            children: [      
                _widgetInfoWindow( titleCurrentUser ,latlongUser),
              Center(
                child: IconButton(
                  onPressed: () => _visibleInfoWindow( titleCurrentUser, latlongUser), 
                  icon: const Icon(Icons.location_history, size: 30,color: Colors.red,)
                )
              ), 
            ],
          ),
          width:  _w_marker_widget,
          height: _h_marker_widget
        );
           
          setState(() {
              markers.add(markerUser!); 
              markerNames.add( titleCurrentUser ); 
              currentZoom = maxZoom;
          });
          _animatedMapMove( latlongUser, maxZoom);
          print('Debug markerNames ${markerNames.length}');    
  }
  
  final _type = TextEditingController();
  
  Widget searchDealer(){      
      return   Padding(
          padding: const EdgeInsets.all(20),
          child: Opacity( opacity: 0.7,
            child: Card(
              shape: const StadiumBorder( side: BorderSide( width: 0.5, color: Colors.grey )  ),
              child: EasyAutocomplete(    
                          controller: _type,  
                          inputTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),
                          decoration:    InputDecoration(    
                            hoverColor: Colors.white,
                            fillColor: Colors.white,
                            focusColor: Colors.white,  
                            suffixIcon:  (_type.text.isEmpty ) ? null : IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () =>  _type.clear() ,
                            ), 
                            hintText: 'Cari Dealer',
                            contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0), 
                            border: const OutlineInputBorder( 
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              gapPadding: 10,
                            ),  
                          ), 
                          suggestions: markerNames ,
                          onChanged: (value)  {   
                          },  
                          onSubmitted: (v){      
                            if(v.isEmpty) { return;}
                            int i =  fromList(markerNames,  v); 
                            print('_infowindowShow $i : $v ${markers[i].point}'); 
                            _visibleInfoWindow(v, markers[i].point);
                            setState(() =>  dealerSelected = v );
                            _type.text = v;
                          }, 
                        ),
            ),
          ),
        );
  }

  Future<void> _openGmaps(Uri _url) async {   
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }
  
}