// ignore_for_file: file_names

class Svr{

  // Key
  String targetPath() => 'c2lzdGVtZ2FyYW5zaS5jb20vc2l0ZS9hcGk=';
  String apikey () =>  'aUtvb2wtU2FsZXMtUG9pbnQ';
  
  String host = 'https://sistemgaransi.com/site/api'; 

  String daftar() => '$host/daftar.php';

  String dealerPartisipan ()=> '$host/dealer_partisipasi.php'; // daftar
  
  String login() => '$host/login.php';

  String forgot() => '';

  // Tab Harga
  String merekMobile() => '$host/harga_all_merk.php';

  String tipeMobile() => '$host/harga_tipe.php';

  String hargaKaca() => '$host/harga_kaca_depan.php';




}