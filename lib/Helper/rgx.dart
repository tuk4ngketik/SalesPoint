
bool namaLengkap(var v){  
  RegExp exp = RegExp(r'^[a-zA-Z\s]+$');   
  if( v.length > 0 &&  !exp.hasMatch(v)){   
    return false;
  }  
  return true;
}  

bool alphabetOnly(var v){  
  RegExp exp = RegExp(r'^[a-zA-Z]+$');   
  if( v.length > 0 &&  !exp.hasMatch(v)){   
    return false;
  }  
  return true;
}  

bool numberOnly(var v){  
  RegExp exp = RegExp(r'^[0-9]+$');   
  if( v.length > 0 &&  !exp.hasMatch(v)){   
    return false;
  }  
  return true;
}  

bool kosongLapan(var v){   
  RegExp nolLapan = RegExp(r'08'); 
  if( nolLapan.matchAsPrefix(v, 0) == null){
    return false; 
  } 
  return true;
}  