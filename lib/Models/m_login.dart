// To parse this JSON data, do
//
//     final mLogin = mLoginFromJson(jsonString);

import 'dart:convert';

MLogin mLoginFromJson(String str) => MLogin.fromJson(json.decode(str));

String mLoginToJson(MLogin data) => json.encode(data.toJson());

class MLogin {
    MLogin({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    Data? data;

    factory MLogin.fromJson(Map<String, dynamic> json) => MLogin(
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
    Data({
        this.firstName,
        this.lastName,
        this.email,
        this.address,
        this.phone,
        this.prov,
    });

    String? firstName;
    String? lastName;
    String? email;
    String? address;
    String? phone;
    String? prov;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        address: json["address"],
        phone: json["phone"],
        prov: json["prov"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "address": address,
        "phone": phone,
        "prov": prov,
    };
}
