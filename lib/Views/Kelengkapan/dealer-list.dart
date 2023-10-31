// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, override_on_non_overriding_member, annotate_overrides, file_names, avoid_print

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:sales_point/Cfg/css.dart';

class DealerList extends StatefulWidget{
  @override
  final  listBranchname; 
  const DealerList({super.key, this.listBranchname});
  _DealerList createState() =>_DealerList ();
}

class _DealerList extends State<DealerList>{

  final _branchName = TextEditingController();

  @override
  void initState() { 
    super.initState();
  }

  @override
  void dispose() { 
    super.dispose();
    _branchName.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyAutocomplete(
          suggestionBackgroundColor: Colors.grey, 
          suggestions:  widget.listBranchname ,  
          controller: _branchName,
          onSubmitted: (v){ 
            _branchName.text = v; 
            print('onSubmitted ${_branchName.text}');
          } , 
          onChanged: (v) {
            _branchName.text = v;
            print('onChanged ${_branchName.text}');
          },
          decoration:  InputDecoration(       
            // labelText: 'Dealer',
            hintText: 'Pilih Dealer',    
            border: Css.roundInput20,   
            enabledBorder:  Css.roundInput20,    
            prefixIcon: const Icon(Icons.work_history , color: Colors.black),
            labelStyle: Css.labelStyle,
            filled: true,
            fillColor: Colors.white,
            suffixIcon:  (  _branchName.text == '') ? null :  IconButton(
              onPressed: (){  
                _branchName.clear();
                _branchName.text == '';
              },
              icon: const Icon(Icons.close),
            ),    
          ), 
          validator: (value) {  
            if(value!.isEmpty){
              return 'Lengkapi Dealer';
            } 
            return null;
          },
        )
      ],
    );
  }

}