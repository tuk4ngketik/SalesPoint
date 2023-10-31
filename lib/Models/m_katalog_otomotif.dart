// To parse this JSON data, do
//
//     final mKatalogOtomotif = mKatalogOtomotifFromJson(jsonString);

import 'dart:convert';

MKatalogOtomotif mKatalogOtomotifFromJson(String str) => MKatalogOtomotif.fromJson(json.decode(str));

String mKatalogOtomotifToJson(MKatalogOtomotif data) => json.encode(data.toJson());

class MKatalogOtomotif {
    bool? status;
    String? message;
    List<DataKatalogOtomotif>? data;

    MKatalogOtomotif({
        this.status,
        this.message,
        this.data,
    });

    factory MKatalogOtomotif.fromJson(Map<String, dynamic> json) => MKatalogOtomotif(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<DataKatalogOtomotif>.from(json["data"]!.map((x) => DataKatalogOtomotif.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataKatalogOtomotif {
    String? serial;
    String? productName;
    String? productDesc;
    String? file;

    DataKatalogOtomotif({
        this.serial,
        this.productName,
        this.productDesc,
        this.file,
    });

    factory DataKatalogOtomotif.fromJson(Map<String, dynamic> json) => DataKatalogOtomotif(
        serial: json["serial"],
        productName: json["product_name"],
        productDesc: json["product_desc"],
        file: json["file"],
    );

    Map<String, dynamic> toJson() => {
        "serial": serial,
        "product_name": productName,
        "product_desc": productDesc,
        "file": file,
    };
}
