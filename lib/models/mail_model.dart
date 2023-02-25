// To parse this JSON data, do
//
//     final mailModel = mailModelFromJson(jsonString);

import 'dart:convert';

import '../utils/convert_utils.dart';

class MailModel {
  MailModel({
    this.id,
    this.threadId,
    this.labelIds,
    this.snippet,
    this.payload,
    this.sizeEstimate,
    this.historyId,
    this.internalDate,
  });

  String? id;
  String? threadId;
  List<String>? labelIds;
  String? snippet;
  Payload? payload;
  int? sizeEstimate;
  String? historyId;
  String? internalDate;

  factory MailModel.fromRawJson(String str) =>
      MailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MailModel.fromJson(Map<String, dynamic> json) => MailModel(
        id: json["id"],
        threadId: json["threadId"],
        labelIds: json["labelIds"] == null
            ? []
            : List<String>.from(json["labelIds"]!.map((x) => x)),
        snippet: json["snippet"],
        payload:
            json["payload"] == null ? null : Payload.fromJson(json["payload"]),
        sizeEstimate: json["sizeEstimate"],
        historyId: json["historyId"],
        internalDate: json["internalDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "threadId": threadId,
        "labelIds":
            labelIds == null ? [] : List<dynamic>.from(labelIds!.map((x) => x)),
        "snippet": snippet,
        "payload": payload?.toJson(),
        "sizeEstimate": sizeEstimate,
        "historyId": historyId,
        "internalDate": internalDate,
      };
}

class Payload {
  Payload({
    this.partId,
    this.mimeType,
    this.filename,
    this.headers,
    this.body,
    this.parts,
  });

  String? partId;
  String? mimeType;
  String? filename;
  List<Header>? headers;
  Body? body;
  List<Payload>? parts;

  factory Payload.fromRawJson(String str) => Payload.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        partId: json["partId"],
        mimeType: json["mimeType"],
        filename: json["filename"],
        headers: json["headers"] == null
            ? []
            : List<Header>.from(
                json["headers"]!.map((x) => Header.fromJson(x))),
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
        parts: json["parts"] == null
            ? []
            : List<Payload>.from(
                json["parts"]!.map((x) => Payload.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "partId": partId,
        "mimeType": mimeType,
        "filename": filename,
        "headers": headers == null
            ? []
            : List<dynamic>.from(headers!.map((x) => x.toJson())),
        "body": body?.toJson(),
        "parts": parts == null
            ? []
            : List<dynamic>.from(parts!.map((x) => x.toJson())),
      };
}

class Body {
  Body({
    this.size,
    this.data,
  });

  int? size;
  String? data;

  factory Body.fromRawJson(String str) => Body.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        size: json["size"],
        data: json["data"] != null ? base64ToNormal(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "data": data,
      };
}

class Header {
  Header({
    this.name,
    this.value,
  });

  String? name;
  String? value;

  factory Header.fromRawJson(String str) => Header.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
