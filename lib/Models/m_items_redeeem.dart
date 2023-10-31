// To parse this JSON data, do
//
//     final mItemsRedeem = mItemsRedeemFromJson(jsonString);

import 'dart:convert';

MItemsRedeem mItemsRedeemFromJson(String str) => MItemsRedeem.fromJson(json.decode(str));

String mItemsRedeemToJson(MItemsRedeem data) => json.encode(data.toJson());

class MItemsRedeem {
    bool? status;
    String? message;
    List<DataItem>? data;

    MItemsRedeem({
        this.status,
        this.message,
        this.data,
    });

    factory MItemsRedeem.fromJson(Map<String, dynamic> json) => MItemsRedeem(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<DataItem>.from(json["data"]!.map((x) => DataItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataItem {
    String? serial;
    String? itemName;
    String? itemPoint;
    String? itemDesc;
    String? itemSyarat;
    String? itemStart;
    String? itemExpired;
    String? isActive;
    DateTime? createdAt;

    DataItem({
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

    factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
        serial: json["serial"],
        itemName: json["item_name"],
        itemPoint: json["item_point"],
        itemDesc: json["item_desc"],
        itemSyarat: json["item_syarat"],
        itemStart: json["item_start"],
        itemExpired: json["item_expired"],
        isActive: json["is_active"],
        // createdAt: json["created_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
   
    );

    Map<String, dynamic> toJson() => {
        "serial": serial,
        "item_name": itemName,
        "item_point": itemPoint,
        "item_desc": itemDesc,
        "item_syarat": itemSyarat,
        "item_start": itemStart,
        "item_expired": itemExpired,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
    };
}
