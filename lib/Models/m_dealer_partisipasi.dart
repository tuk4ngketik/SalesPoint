// To parse this JSON data, do
//
//     final mDealerPartisipasi = mDealerPartisipasiFromJson(jsonString);

import 'dart:convert';

MDealerPartisipasi mDealerPartisipasiFromJson(String str) => MDealerPartisipasi.fromJson(json.decode(str));

String mDealerPartisipasiToJson(MDealerPartisipasi data) => json.encode(data.toJson());

class MDealerPartisipasi {
    MDealerPartisipasi({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    List<Datum>? data;

    factory MDealerPartisipasi.fromJson(Map<String, dynamic> json) => MDealerPartisipasi(
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
        this.serial,
        this.branchName,
        this.kota,
        this.status,
        this.resellerVkPoint,
    });

    String? serial;
    String? branchName;
    String? kota;
    String? status;
    String? resellerVkPoint;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        serial: json["serial"],
        branchName: json["branch_name"],
        kota: json["kota"],
        status: json["status"],
        resellerVkPoint: json["reseller_vk_point"],
    );

    Map<String, dynamic> toJson() => {
        "serial": serial,
        "branch_name": branchName,
        "kota": kota,
        "status": status,
        "reseller_vk_point": resellerVkPoint,
    };
}
