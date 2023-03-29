// To parse this JSON data, do
//
//     final mHargaKaca = mHargaKacaFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

MHargaKaca mHargaKacaFromJson(String str) => MHargaKaca.fromJson(json.decode(str));

String mHargaKacaToJson(MHargaKaca data) => json.encode(data.toJson());

class MHargaKaca {
    MHargaKaca({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    List<Datum>? data;

    factory MHargaKaca.fromJson(Map<String, dynamic> json) => MHargaKaca(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.filmType,
        this.carBrand,
        this.carType,
        this.hargaJual,
    });

    String? filmType;
    String? carBrand;
    String? carType;
    String? hargaJual;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        filmType: json["film_type"],
        carBrand: json["car_brand"],
        carType: json["car_type"],
        hargaJual: json["harga_jual"],
    );

    Map<String, dynamic> toJson() => {
        "film_type": filmType,
        "car_brand": carBrand,
        "car_type": carType,
        "harga_jual": hargaJual,
    };
}
