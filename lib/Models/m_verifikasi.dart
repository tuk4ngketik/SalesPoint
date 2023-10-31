// To parse this JSON data, do
//
//     final mVerifikasi = mVerifikasiFromJson(jsonString);

import 'dart:convert';

MVerifikasi mVerifikasiFromJson(String str) => MVerifikasi.fromJson(json.decode(str));

String mVerifikasiToJson(MVerifikasi data) => json.encode(data.toJson());

class MVerifikasi {
    bool status;
    String message;
    Data? data;

    MVerifikasi({
        required this.status,
        required this.message,
        this.data,
    });

    factory MVerifikasi.fromJson(Map<String, dynamic> json) => MVerifikasi(
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
    String? email;
    String? phone;
    DateTime? expiredOtp;

    Data({
        this.serial,
        this.email,
        this.phone,
        this.expiredOtp,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        serial: json["serial"],
        email: json["email"],
        phone: json["phone"],
        expiredOtp: json["expired_otp"] == null ? null : DateTime.parse(json["expired_otp"]),
    );

    Map<String, dynamic> toJson() => {
        "serial": serial,
        "email": email,
        "phone": phone,
        "expired_otp": expiredOtp?.toIso8601String(),
    };
}
