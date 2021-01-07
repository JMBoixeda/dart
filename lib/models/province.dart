import "dart:io";

import "package:flutter/foundation.dart";

class Province {
  final String id;
  final DateTime createdAt;
  final String name;

  Province({
    @required this.id,
    @required this.createdAt,
    @required this.name,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Province(
      id: json["id"],
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      name: json["name"],
    );
  }

  static List<Province> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Province.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String stateAsString() {
    return '#${this.id} ${this.name}';
  }

  ///this method will prevent the override of toString
  bool stateFilterByCreationDate(String filter) {
    return this?.createdAt?.toString()?.contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Province model) {
    return this?.id == model?.id;
  }

  @override
  String toString() => name;
}
