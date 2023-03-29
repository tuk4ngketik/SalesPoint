// To parse this JSON data, do
//
//     final mTypeByBrand = mTypeByBrandFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

MTypeByBrand mTypeByBrandFromJson(String str) => MTypeByBrand.fromJson(json.decode(str));

String mTypeByBrandToJson(MTypeByBrand data) => json.encode(data.toJson());

class MTypeByBrand {
    MTypeByBrand({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    List<Datum>? data;

    factory MTypeByBrand.fromJson(Map<String, dynamic> json) => MTypeByBrand(
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
        this.carBrand,
        this.carType,
    });
 
    String? carBrand;
    String? carType;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        carBrand:  json["car_brand"]!,
        carType: json["car_type"],
    );

    Map<String, dynamic> toJson() => {
        "car_brand": carBrand,
        "car_type": carType,
    };
}
 