// To parse this JSON data, do
//
//     final mPointPaginate = mPointPaginateFromJson(jsonString);

import 'dart:convert';

MPointPaginate mPointPaginateFromJson(String str) => MPointPaginate.fromJson(json.decode(str));

String mPointPaginateToJson(MPointPaginate data) => json.encode(data.toJson());

class MPointPaginate {
    bool? status;
    String? message;
    int? nextPage;
    String? totalPoint;
    List<PaginatePoint>? data;

    MPointPaginate({
        this.status,
        this.message,
        this.nextPage,
        this.totalPoint,
        this.data,
    });

    factory MPointPaginate.fromJson(Map<String, dynamic> json) => MPointPaginate(
        status: json["status"],
        message: json["message"],
        nextPage: json["next_page"],
        totalPoint: json["total_point"],
        data: json["data"] == null ? [] : List<PaginatePoint>.from(json["data"]!.map((x) => PaginatePoint.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "next_page": nextPage,
        "total_point": totalPoint,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class PaginatePoint {
    String? serial;
    String? totalPoint;
    DateTime? tglPoint;
    DateTime? tglExp;
    String? totalInv;
    dynamic serialItem;
    dynamic pointBefore;
    dynamic tutupPoint;
    dynamic tglTutupPoint;
    String? garansiCode;
    DateTime? installDate;
    String? firstName;
    String? lastName;
    String? branchName;

    PaginatePoint({
        this.serial,
        this.totalPoint,
        this.tglPoint,
        this.tglExp,
        this.totalInv,
        this.serialItem,
        this.pointBefore,
        this.tutupPoint,
        this.tglTutupPoint,
        this.garansiCode,
        this.installDate,
        this.firstName,
        this.lastName,
        this.branchName,
    });

    factory PaginatePoint.fromJson(Map<String, dynamic> json) => PaginatePoint(
        serial: json["serial"],
        totalPoint: json["total_point"],
        tglPoint: json["tgl_point"] == null ? null : DateTime.parse(json["tgl_point"]),
        tglExp: json["tgl_exp"] == null ? null : DateTime.parse(json["tgl_exp"]),
        totalInv: json["total_inv"],
        serialItem: json["serial_item"],
        pointBefore: json["point_before"],
        tutupPoint: json["tutup_point"],
        tglTutupPoint: json["tgl_tutup_point"],
        garansiCode: json["garansi_code"],
        installDate: json["install_date"] == null ? null : DateTime.parse(json["install_date"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        branchName: json["branch_name"],
    );

    Map<String, dynamic> toJson() => {
        "serial": serial,
        "total_point": totalPoint,
        "tgl_point": "${tglPoint!.year.toString().padLeft(4, '0')}-${tglPoint!.month.toString().padLeft(2, '0')}-${tglPoint!.day.toString().padLeft(2, '0')}",
        "tgl_exp": "${tglExp!.year.toString().padLeft(4, '0')}-${tglExp!.month.toString().padLeft(2, '0')}-${tglExp!.day.toString().padLeft(2, '0')}",
        "total_inv": totalInv,
        "serial_item": serialItem,
        "point_before": pointBefore,
        "tutup_point": tutupPoint,
        "tgl_tutup_point": tglTutupPoint,
        "garansi_code": garansiCode,
        "install_date": "${installDate!.year.toString().padLeft(4, '0')}-${installDate!.month.toString().padLeft(2, '0')}-${installDate!.day.toString().padLeft(2, '0')}",
        "first_name": firstName,
        "last_name": lastName,
        "branch_name": branchName,
    };
}
