// To parse this JSON data, do
//
//     final mAll = mAllFromJson(jsonString);

import 'dart:convert';

MAll mAllFromJson(String str) => MAll.fromJson(json.decode(str));

String mAllToJson(MAll data) => json.encode(data.toJson());

class MAll {
    MAll({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    dynamic data;

    factory MAll.fromJson(Map<String, dynamic> json) => MAll(
        status: json["status"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
    };
}
