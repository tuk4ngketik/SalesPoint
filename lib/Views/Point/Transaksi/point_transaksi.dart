// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, annotate_overrides, avoid_print, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 
import 'package:sales_point/Apis/a_redeem.dart';
import 'package:sales_point/Cfg/sess.dart';
import 'package:sales_point/Helper/myapp-attr.dart';
import 'package:sales_point/Helper/tanggal.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Models/m_transaksi_redeem.dart';

class PointTransaksi extends StatefulWidget{
  @override
  _PointTransaksi createState() => _PointTransaksi();
}
class _PointTransaksi extends State<PointTransaksi>{

  Sess sess = Sess();
  String? serial; 
  Tanggal tgl = Tanggal();  
  MyappAttr myappAttr = MyappAttr();
  var headers;
  ApiRedeem apiRedeem = ApiRedeem();
  List<DataTransaksi> data = [];
  bool isload = false;

  _gethistory(){ 
    setState(() => isload = true );
    apiRedeem.getRedeemtransaction(headers, serial!).then((v) { 
      bool? status =  v!.status;
      String? msg = v.message;
      if(status ==  false ){
        defaultDialogErr(msg!);
        setState(() => isload = false );
        return;
      }
      
      setState(() {data = v.data!; isload = false; });
      print('data after ${data.length}');  
    }) 
    .catchError((e){
      setState(() => isload =  false );
      snackError('Error Transaksi', '${e.msg}');
    });
  }
  
  void initState() {
    super.initState(); 
    sess.getSess('serial').then((value) => setState(() => serial = value ) );   
    myappAttr.retHeader().then((value)  {   
       headers = value; 
      _gethistory(); 
    });
  }

  @override
  Widget build(BuildContext context) { 
    return (isload == true) ? const Center(child: CircularProgressIndicator(),) 
        : ( data.length < 1) ? const Center(child: Text('Belum ada penukaran poin'),) 
        : ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: data.length,
          itemBuilder: (context, i) {
            return Card(
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('${data[i].itemName}'),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      // Text('${data[i].tglRedeem}'), 
                      Text( tgl.convertTanggal('${data[i].tglRedeem}')), 
                      Text('${data[i].itemDesc}'),
                    ],
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,  
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:  [  
                    const FaIcon( FontAwesomeIcons.gem, size: 15,color: Colors.amber,),  
                    Text('${data[i].itemPoint}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
                  ]),
                ),
              ),
            );
        },);
  } 

}