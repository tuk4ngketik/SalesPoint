// To parse this JSON data, do
//
//     final mTransaksiRedeem = mTransaksiRedeemFromJson(jsonString);

import 'dart:convert';

MTransaksiRedeem mTransaksiRedeemFromJson(String str) => MTransaksiRedeem.fromJson(json.decode(str));

String mTransaksiRedeemToJson(MTransaksiRedeem data) => json.encode(data.toJson());

class MTransaksiRedeem {
    bool? status;
    String? message;
    List<DataTransaksi>? data;

    MTransaksiRedeem({
        this.status,
        this.message,
        this.data,
    });

    factory MTransaksiRedeem.fromJson(Map<String, dynamic> json) => MTransaksiRedeem(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<DataTransaksi>.from(json["data"]!.map((x) => DataTransaksi.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataTransaksi {
    DateTime? tglRedeem;
    String? serialItem;
    String? itemName;
    String? itemDesc;
    String? itemPoint;

    DataTransaksi({
        this.tglRedeem,
        this.serialItem,
        this.itemName,
        this.itemDesc,
        this.itemPoint,
    });

    factory DataTransaksi.fromJson(Map<String, dynamic> json) => DataTransaksi(
        tglRedeem: json["tgl_redeem"] == null ? null : DateTime.parse(json["tgl_redeem"]),
        serialItem: json["serial_item"],
        itemName: json["item_name"],
        itemDesc: json["item_desc"],
        itemPoint: json["item_point"],
    );

    Map<String, dynamic> toJson() => {
        "tgl_redeem": tglRedeem?.toIso8601String(),
        "serial_item": serialItem,
        "item_name": itemName,
        "item_desc": itemDesc,
        "item_point": itemPoint,
    };
}
