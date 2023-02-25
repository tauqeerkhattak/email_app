import 'dart:convert';

class MailModel {
  MailModel({
    required this.id,
    required this.threadId,
    required this.labelIds,
    required this.snippet,
    required this.payload,
    required this.sizeEstimate,
    required this.historyId,
    required this.internalDate,
  });

  String id;
  String threadId;
  List<String> labelIds;
  String snippet;
  Payload payload;
  int sizeEstimate;
  String historyId;
  String internalDate;

  factory MailModel.fromRawJson(String str) =>
      MailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MailModel.fromJson(Map<String, dynamic> json) => MailModel(
        id: json["id"],
        threadId: json["threadId"],
        labelIds: List<String>.from(json["labelIds"].map((x) => x)),
        snippet: json["snippet"],
        payload: Payload.fromJson(json["payload"]),
        sizeEstimate: json["sizeEstimate"],
        historyId: json["historyId"],
        internalDate: json["internalDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "threadId": threadId,
        "labelIds": List<dynamic>.from(labelIds.map((x) => x)),
        "snippet": snippet,
        "payload": payload.toJson(),
        "sizeEstimate": sizeEstimate,
        "historyId": historyId,
        "internalDate": internalDate,
      };
}

class Payload {
  Payload({
    required this.partId,
    required this.mimeType,
    required this.filename,
    required this.headers,
    required this.body,
    required this.parts,
  });

  String partId;
  String mimeType;
  String filename;
  List<Header> headers;
  PayloadBody body;
  List<Part> parts;

  factory Payload.fromRawJson(String str) => Payload.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        partId: json["partId"],
        mimeType: json["mimeType"],
        filename: json["filename"],
        headers:
            List<Header>.from(json["headers"].map((x) => Header.fromJson(x))),
        body: PayloadBody.fromJson(json["body"]),
        parts: List<Part>.from(json["parts"].map((x) => Part.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "partId": partId,
        "mimeType": mimeType,
        "filename": filename,
        "headers": List<dynamic>.from(headers.map((x) => x.toJson())),
        "body": body.toJson(),
        "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
      };
}

class PayloadBody {
  PayloadBody({
    required this.size,
    required this.data,
  });

  int size;
  String? data;

  factory PayloadBody.fromRawJson(String str) =>
      PayloadBody.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PayloadBody.fromJson(Map<String, dynamic> json) => PayloadBody(
        size: json["size"],
        data: json['data'],
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        'data': data,
      };
}

class Header {
  Header({
    required this.name,
    required this.value,
  });

  String name;
  String value;

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

class Part {
  Part({
    required this.partId,
    required this.mimeType,
    required this.filename,
    required this.headers,
    required this.body,
  });

  String partId;
  String mimeType;
  String filename;
  List<Header> headers;
  PartBody body;

  factory Part.fromRawJson(String str) => Part.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Part.fromJson(Map<String, dynamic> json) => Part(
        partId: json["partId"],
        mimeType: json["mimeType"],
        filename: json["filename"],
        headers:
            List<Header>.from(json["headers"].map((x) => Header.fromJson(x))),
        body: PartBody.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "partId": partId,
        "mimeType": mimeType,
        "filename": filename,
        "headers": List<dynamic>.from(headers.map((x) => x.toJson())),
        "body": body.toJson(),
      };
}

class PartBody {
  PartBody({
    required this.size,
    required this.data,
  });

  int size;
  String data;

  factory PartBody.fromRawJson(String str) =>
      PartBody.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PartBody.fromJson(Map<String, dynamic> json) {
    final bytes = json["data"] != null ? base64Decode(json['data']) : null;
    return PartBody(
      size: json["size"],
      data: bytes != null ? utf8.decode(bytes) : '',
    );
  }

  Map<String, dynamic> toJson() => {
        "size": size,
        "data": data,
      };
}
