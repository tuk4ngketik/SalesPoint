// To parse this JSON data, do
//
//     final mLogin = mLoginFromJson(jsonString);

import 'dart:convert';

MLogin mLoginFromJson(String str) => MLogin.fromJson(json.decode(str));

String mLoginToJson(MLogin data) => json.encode(data.toJson());

class MLogin {
    bool? status;
    String? message;
    Data? data;

    MLogin({
        this.status,
        this.message,
        this.data,
    });

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
    String? serial;
    DateTime? createdDate;
    dynamic createdBy;
    String? status;
    dynamic companySerial;
    String? branchSerial;
    dynamic accountSerial;
    String? tipeCustomer;
    String? firstName;
    dynamic lastName;
    String? noKtp;
    String? address;
    dynamic city;
    dynamic state;
    dynamic zip;
    String? phone;
    dynamic fax;
    String? email;
    dynamic notes;
    String? pic;
    dynamic idMember;
    dynamic idMobApps;
    String? passwd;
    String? verified;
    String? otp;
    DateTime? expiredOtp;
    String? kelengkapan;
    String? imgKtp;
    dynamic prov;

    Data({
        this.serial,
        this.createdDate,
        this.createdBy,
        this.status,
        this.companySerial,
        this.branchSerial,
        this.accountSerial,
        this.tipeCustomer,
        this.firstName,
        this.lastName,
        this.noKtp,
        this.address,
        this.city,
        this.state,
        this.zip,
        this.phone,
        this.fax,
        this.email,
        this.notes,
        this.pic,
        this.idMember,
        this.idMobApps,
        this.passwd,
        this.verified,
        this.otp,
        this.expiredOtp,
        this.kelengkapan,
        this.imgKtp,
        this.prov,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        serial: json["serial"],
        createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
        createdBy: json["created_by"],
        status: json["status"],
        companySerial: json["company_serial"],
        branchSerial: json["branch_serial"],
        accountSerial: json["account_serial"],
        tipeCustomer: json["tipe_customer"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        noKtp: json["no_ktp"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        phone: json["phone"],
        fax: json["fax"],
        email: json["email"],
        notes: json["notes"],
        pic: json["pic"],
        idMember: json["id_member"],
        idMobApps: json["id_mob_apps"],
        passwd: json["passwd"],
        verified: json["verified"],
        otp: json["otp"],
        expiredOtp: json["expired_otp"] == null ? null : DateTime.parse(json["expired_otp"]),
        kelengkapan: json["kelengkapan"],
        imgKtp: json["img_ktp"],
        prov: json["prov"],
    );

    Map<String, dynamic> toJson() => {
        "serial": serial,
        "created_date": createdDate?.toIso8601String(),
        "created_by": createdBy,
        "status": status,
        "company_serial": companySerial,
        "branch_serial": branchSerial,
        "account_serial": accountSerial,
        "tipe_customer": tipeCustomer,
        "first_name": firstName,
        "last_name": lastName,
        "no_ktp": noKtp,
        "address": address,
        "city": city,
        "state": state,
        "zip": zip,
        "phone": phone,
        "fax": fax,
        "email": email,
        "notes": notes,
        "pic": pic,
        "id_member": idMember,
        "id_mob_apps": idMobApps,
        "passwd": passwd,
        "verified": verified,
        "otp": otp,
        "expired_otp": expiredOtp?.toIso8601String(),
        "kelengkapan": kelengkapan,
        "img_ktp": imgKtp,
        "prov": prov,
    };
}
