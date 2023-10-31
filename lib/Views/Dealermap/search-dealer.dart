import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
// import 'package:sales_point/Cfg/css.dart';

class SearchDealer extends StatefulWidget{
  final  List<String> dealers; 
  const SearchDealer({super.key, required this.dealers});
  @override
  _SearchDealer createState() => _SearchDealer();
}
class _SearchDealer extends State<SearchDealer>{
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        shape: const StadiumBorder(
           side: BorderSide( width: 0.8, color: Colors.grey ) 
        ),
        child: EasyAutocomplete(    
                    // controller: _merek,  ,
                    inputTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),
                    decoration:    InputDecoration(   
                      hoverColor: Colors.white,
                      fillColor: Colors.white,
                      focusColor: Colors.white,  
                      suffixIcon:  IconButton(
                        onPressed: (){  
                        },
                        icon: const Icon(Icons.close),
                      ),
                      
                      hintText: 'Cari Dealer',
                      contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0), 
                      border: const OutlineInputBorder( 
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gapPadding: 10,
                      ),  
                    ), 
                    suggestions: widget.dealers ,
                    onChanged: (value)  {   
                    },  
                    onSubmitted: (v){     
                      }, 
                  ),
      ),
    );
  }
  
}