// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  final dynamic senderId;
  final dynamic category;
  final String? collapseKey;
  final bool? contentAvailable;
  final Data? data;
  final String? from;
  final String? messageId;
  final dynamic messageType;
  final bool? mutableContent;
  final Notification? notification;
  final int? sentTime;
  final dynamic threadId;
  final int? ttl;

  NotificationModel({
    this.senderId,
    this.category,
    this.collapseKey,
    this.contentAvailable,
    this.data,
    this.from,
    this.messageId,
    this.messageType,
    this.mutableContent,
    this.notification,
    this.sentTime,
    this.threadId,
    this.ttl,
  });

  factory NotificationModel.fromJson(Map<dynamic, dynamic> json) => NotificationModel(
    senderId: json["senderId"],
    category: json["category"],
    collapseKey: json["collapseKey"],
    contentAvailable: json["contentAvailable"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    from: json["from"],
    messageId: json["messageId"],
    messageType: json["messageType"],
    mutableContent: json["mutableContent"],
    notification: json["notification"] == null ? null : Notification.fromJson(json["notification"]),
    sentTime: json["sentTime"],
    threadId: json["threadId"],
    ttl: json["ttl"],
  );

  Map<dynamic, dynamic> toJson() => {
    "senderId": senderId,
    "category": category,
    "collapseKey": collapseKey,
    "contentAvailable": contentAvailable,
    "data": data?.toJson(),
    "from": from,
    "messageId": messageId,
    "messageType": messageType,
    "mutableContent": mutableContent,
    "notification": notification?.toJson(),
    "sentTime": sentTime,
    "threadId": threadId,
    "ttl": ttl,
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
  );

  Map<dynamic, dynamic> toJson() => {
  };
}

class Notification {
  final String? title;
  final List<dynamic>? titleLocArgs;
  final dynamic titleLocKey;
  final String? body;
  final List<dynamic>? bodyLocArgs;
  final dynamic bodyLocKey;
  final Map<dynamic, dynamic>? android;
  final dynamic apple;
  final dynamic web;

  Notification({
    this.title,
    this.titleLocArgs,
    this.titleLocKey,
    this.body,
    this.bodyLocArgs,
    this.bodyLocKey,
    this.android,
    this.apple,
    this.web,
  });

  factory Notification.fromJson(Map<dynamic, dynamic> json) => Notification(
    title: json["title"],
    titleLocArgs: json["titleLocArgs"] == null ? [] : List<dynamic>.from(json["titleLocArgs"]!.map((x) => x)),
    titleLocKey: json["titleLocKey"],
    body: json["body"],
    bodyLocArgs: json["bodyLocArgs"] == null ? [] : List<dynamic>.from(json["bodyLocArgs"]!.map((x) => x)),
    bodyLocKey: json["bodyLocKey"],
    android: Map.from(json["android"]!).map((k, v) => MapEntry<dynamic, dynamic>(k, v)),
    apple: json["apple"],
    web: json["web"],
  );

  Map<dynamic, dynamic> toJson() => {
    "title": title,
    "titleLocArgs": titleLocArgs == null ? [] : List<dynamic>.from(titleLocArgs!.map((x) => x)),
    "titleLocKey": titleLocKey,
    "body": body,
    "bodyLocArgs": bodyLocArgs == null ? [] : List<dynamic>.from(bodyLocArgs!.map((x) => x)),
    "bodyLocKey": bodyLocKey,
    "android": Map.from(android!).map((k, v) => MapEntry<dynamic, dynamic>(k, v)),
    "apple": apple,
    "web": web,
  };
}
