// To parse this JSON data, do
//
//     final mPromo = mPromoFromJson(jsonString);

import 'dart:convert';

MPromo mPromoFromJson(String str) => MPromo.fromJson(json.decode(str));

String mPromoToJson(MPromo data) => json.encode(data.toJson());

class MPromo {
    bool? status;
    String? message;
    List<Datum>? data;

    MPromo({
        this.status,
        this.message,
        this.data,
    });

    factory MPromo.fromJson(Map<String, dynamic> json) => MPromo(
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
    String? serial;
    String? promoName;
    String? promoDesc;
    String? imgFile;
    String? promoStart;
    String? promoExpired;
    String? isActive;
    DateTime? createdAt;

    Datum({
        this.serial,
        this.promoName,
        this.promoDesc,
        this.imgFile,
        this.promoStart,
        this.promoExpired,
        this.isActive,
        this.createdAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        serial: json["serial"],
        promoName: json["promo_name"],
        promoDesc: json["promo_desc"],
        imgFile: json["img_file"], 
        promoStart: json["promo_start"] , 
        promoExpired: json["promo_expired"],
        isActive: json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "serial": serial,
        "promo_name": promoName,
        "promo_desc": promoDesc,
        "img_file": imgFile,
        "promo_start":  promoStart,
        "promo_expired": promoExpired,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
    };
}
