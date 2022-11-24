import 'package:metal/metal.dart';

class PostOre extends Ore {
  PostOre({
    num? userId,
    num? id,
    String? title,
    String? body,
  }) {
    _userId = userId;
    _id = id;
    _title = title;
    _body = body;
  }

  PostOre.fromJson(dynamic json) {
    _userId = json['userId'];
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
  }
  num? _userId;
  num? _id;
  String? _title;
  String? _body;
  PostOre copyWith({
    num? userId,
    num? id,
    String? title,
    String? body,
  }) =>
      PostOre(
        userId: userId ?? _userId,
        id: id ?? _id,
        title: title ?? _title,
        body: body ?? _body,
      );
  num? get userId => _userId;
  num? get id => _id;
  String? get title => _title;
  String? get body => _body;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    return map;
  }

  @override
  Ore parse(data) => PostOre.fromJson(data);

  @override
  Ore? mineError(data) {
    return null;
  }
}
