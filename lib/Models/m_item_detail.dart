// To parse this JSON data, do
//
//     final mItemDetail = mItemDetailFromJson(jsonString);

import 'dart:convert';

MItemDetail mItemDetailFromJson(String str) => MItemDetail.fromJson(json.decode(str));

String mItemDetailToJson(MItemDetail data) => json.encode(data.toJson());

class MItemDetail {
    bool? status;
    String? message;
    Data? data;

    MItemDetail({
        this.status,
        this.message,
        this.data,
    });

    factory MItemDetail.fromJson(Map<String, dynamic> json) => MItemDetail(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? serial;
    String? itemName;
    String? itemPoint;
    String? itemDesc;
    String? itemSyarat;
    String? itemStart;
    String? itemExpired;
    String? isActive;
    DateTime? createdAt;

    Data({
        this.serial,
        this.itemName,
        this.itemPoint,
        this.itemDesc,
        this.itemSyarat,
        this.itemStart,
        this.itemExpired,
        this.isActive,
        this.createdAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        serial: json["serial"],
        itemName: json["item_name"],
        itemPoint: json["item_point"],
        itemDesc: json["item_desc"],
        itemSyarat: json["item_syarat"],
        itemStart: json["item_start"] ,
        itemExpired: json["item_expired"],
        isActive: json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "serial": serial,
        "item_name": itemName,
        "item_point": itemPoint,
        "item_desc": itemDesc,
        "item_syarat": itemSyarat,
        "item_start":  itemStart ,
        "item_expired": itemExpired ,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
    };
}
