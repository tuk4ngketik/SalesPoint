// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, file_names, non_constant_identifier_names, unused_field, unused_local_variable
 

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:sales_point/Apis/a_login.dart';
import 'package:sales_point/Cfg/css.dart'; 
import 'package:sales_point/Helper/rgx.dart';
import 'package:sales_point/Helper/wg.dart';
import 'package:sales_point/Views/login.dart';

class EditAkun extends StatefulWidget{
  final headers;
  final serial, namaLengkap, email, telp;
  const EditAkun({super.key,  required this.headers,  required this.serial, required this.namaLengkap, required this.email, required this.telp });
  @override
  _EditAkun createState() => _EditAkun();
}

class _EditAkun extends State<EditAkun>{

  ApiLogin apiLogin = ApiLogin();
  // MyappAttr myappAttr = MyappAttr();
  bool isLoad =  false;
  bool visiblePass =   false;
  bool visibleCurrentPasswd = false;
  final _formKey = GlobalKey<FormState>();
  String? _email, no_hp, _currentPasswd, _passwd, _passwdKonfirm;
  final passwd_ = TextEditingController(); 

  @override
  void initState() { 
    super.initState();  
  }
  @override
  void dispose() { 
    super.dispose();
    passwd_.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [  
                      
                      TextFormField( 
                        initialValue: widget.email,
                        decoration:  InputDecoration(           
                          border: Css.round20,      
                          prefixIcon: const Icon(Icons.email, color: Colors.black) ,
                          labelStyle: Css.labelStyle,
                          labelText: 'Email ' , 
                        ), 
                        onSaved:(newValue) => _email = newValue,
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Lengkapi Email';
                          }
                          if (GetUtils.isEmail( value ) == false ){                              
                            return 'Email tidak valid';
                          }
                          return null;
                        },
                      ), 
                      br(15),
      
                      TextFormField( 
                        initialValue: widget.telp,
                        decoration:  InputDecoration(           
                          border: Css.round20,      
                          prefixIcon:  const Icon(Icons.phone, color: Colors.black), 
                          labelStyle: Css.labelStyle,
                          labelText: 'No. Hp / Whatsapp  ' ,
                          hintText: '${widget.telp}',
                        ),
                          onSaved:(newValue) => no_hp = newValue,
                          validator: (value) { 
                            if(  value!.isEmpty )  {
                              return 'Lengkapi No.HP';
                            } 
                            if( numberOnly(value) == false){
                              return 'Harus angka';
                            }
                            if(  value.length < 10  || value.length > 15 || kosongLapan(value) == false )  {
                              return 'No. HP tidak valid';
                            } 
                            return null;
                          },
                      ),
                      br(15),
                      
                      const Divider(),  
                      TextFormField( 
                            obscureText: (visibleCurrentPasswd ==  false) ? true : false,
                        decoration:  InputDecoration(           
                          border: Css.round20,      
                          prefixIcon: const Icon(Icons.key,  color: Colors.black),
                          labelStyle: Css.labelStyle,
                          labelText: 'Kata sandi saat ini ' , 
                              suffixIcon: IconButton(
                                onPressed: (){ 
                                  setState(() {
                                    visibleCurrentPasswd =  !visibleCurrentPasswd; 
                                  });
                                }, 
                                icon: ( visibleCurrentPasswd ==  false) ? const Icon(Icons.visibility_off_sharp, color: Colors.black) : const Icon(Icons.visibility, color: Colors.black,)
                              )
                        ),
                            onSaved:(newValue) => _currentPasswd = newValue,
                            validator: (value) { 
                              if(  value!.isEmpty )  {
                                return 'Lengkapi Kata sandi saat ini';
                              }  
                              return null;
                            },
                      ),
                      br(15), 
       
                      TextFormField( 
                            obscureText: (visiblePass ==  false) ? true : false,
                        decoration:  InputDecoration(           
                          border: Css.round20,      
                              prefixIcon: const Icon(Icons.lock_open, color: Colors.black),
                          labelStyle: Css.labelStyle,
                          labelText: 'Kata sandi baru' ,
                          hintText: '',
                              suffixIcon: IconButton(
                                onPressed: (){ 
                                  setState(() {
                                    visiblePass =  !visiblePass; 
                                  });
                                }, 
                                icon: (visiblePass ==  false) ? const Icon(Icons.visibility_off_sharp, color: Colors.black) : const Icon(Icons.visibility, color: Colors.black,)
                              )
                        ),  
                        controller: passwd_,
                            onSaved:(newValue) => _passwd = newValue,
                            validator: (value) {
                              if(value!.isEmpty  ){
                                return 'Lengkapi Kata Sandi';
                              }
                              if( value.length < 6 || value.length > 15){
                                return 'Kata Sandi min 6 s/d  15 karakter';
                              }
                              return null;
                            },
                      ),

                      br(15),
                      TextFormField( 
                            obscureText: (visiblePass ==  false) ? true : false,
                        decoration:  InputDecoration(           
                          border: Css.round20,      
                              prefixIcon: const Icon(Icons.password, color: Colors.black),
                          labelStyle: Css.labelStyle,
                          labelText: 'Konfirmasi Kata sandi ' ,
                          hintText: '',
                        ),
                            onSaved:(newValue) => _passwdKonfirm = newValue,
                            validator: (value) {
                              if(value!.isEmpty){
                                return 'Lengkapi Konfirmasi Kata Sandi'; 
                              }
                              if(value != passwd_.text ){ 
                                return 'Kata Sandi & Konfirmasi tidak sama';  
                              }
                              return null;
                            }
                      ),
                      br(25),
                      
                      Container(
                        // color: Colors.yellow,
                          decoration: const BoxDecoration(
                            color: Colors.amber,   
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          height: 55,
                          child:  Center(
                            child: TextButton( 
                                onPressed: (){    
                                  if (_formKey.currentState!.validate() == false) { return; }
                                  _formKey.currentState!.save();  
                                  _editAkun();
                                },
                                child:  Center(
                                  child: ( isLoad == true ) 
                                    ? const CircularProgressIndicator(color: Colors.orange,)
                                    : const Text('Perbaharui Akun', style: TextStyle(fontSize: 18, color: Colors.black),)
                                    // : const Icon(Icons.send)
                                ),
                              ),
                          )
                      ),
                          
         
          ],
        ),
      ),
    ); 
  } 

  _editAkun(){

    var data = {
      'serial' : widget.serial,
      'email' : _email,
      'phone' : no_hp,
      'last_passwd' : _currentPasswd,
      'passwd' : _passwd,
    }; 
    setState(() => isLoad = true );
    apiLogin.updateAkun(widget.headers, jsonEncode(data)).then((v) {
      bool? status = v!.status;
      if(status == false){
        defaultDialogErr('${v.message}');
        setState(() => isLoad = false );
        return;
      } 
      defaultDialogSukses( '${v.message}',   const Login() );
    });

  }

}