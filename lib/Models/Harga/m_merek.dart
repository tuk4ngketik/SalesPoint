// To parse this JSON data, do
//
//     final mMerek = mMerekFromJson(jsonString);

import 'dart:convert';

MMerek mMerekFromJson(String str) => MMerek.fromJson(json.decode(str));

String mMerekToJson(MMerek data) => json.encode(data.toJson());

class MMerek {
    MMerek({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    List<Datum>? data;

    factory MMerek.fromJson(Map<String, dynamic> json) => MMerek(
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
    });

    String? carBrand;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        carBrand: json["car_brand"],
    );

    Map<String, dynamic> toJson() => {
        "car_brand": carBrand,
    };
}
