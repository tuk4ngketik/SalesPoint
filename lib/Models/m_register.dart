// To parse this JSON data, do
//
//     final mRegister = mRegisterFromJson(jsonString);

import 'dart:convert';

MRegister mRegisterFromJson(String str) => MRegister.fromJson(json.decode(str));

String mRegisterToJson(MRegister data) => json.encode(data.toJson());

class MRegister {
    MRegister({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    String? data;

    factory MRegister.fromJson(Map<String, dynamic> json) => MRegister(
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
