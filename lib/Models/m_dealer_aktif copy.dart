// To parse this JSON data, do
//
//     final mDealerAktif = mDealerAktifFromJson(jsonString);

import 'dart:convert';

MDealerAktif mDealerAktifFromJson(String str) => MDealerAktif.fromJson(json.decode(str));

String mDealerAktifToJson(MDealerAktif data) => json.encode(data.toJson());

class MDealerAktif {
    bool? status;
    String? message;
    List<DataDelaer>? data;

    MDealerAktif({
        this.status,
        this.message,
        this.data,
    });

    factory MDealerAktif.fromJson(Map<String, dynamic> json) => MDealerAktif(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<DataDelaer>.from(json["data"]!.map((x) => DataDelaer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataDelaer {
    String? serial;
    String? companySerial;
    String? branchCode;
    String? branchName;
    String? kota;
    String? propinsi;
    String? alamat;

    DataDelaer({
        this.serial,
        this.companySerial,
        this.branchCode,
        this.branchName,
        this.kota,
        this.propinsi,
        this.alamat,
    });

    factory DataDelaer.fromJson(Map<String, dynamic> json) => DataDelaer(
        serial: json["serial"],
        companySerial:  json["company_serial"],
        branchCode: json["branch_code"],
        branchName: json["branch_name"],
        kota: json["kota"],
        propinsi: json["propinsi"],
        alamat: json["alamat"],
    );

    Map<String, dynamic> toJson() => {
        "serial": serial,
        "company_serial": companySerial,
        "branch_code": branchCode,
        "branch_name": branchName,
        "kota": kota,
        "propinsi": propinsi,
        "alamat": alamat,
    };
} 

