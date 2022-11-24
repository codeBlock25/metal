import 'package:metal/metal.dart';

class UserOre extends Ore {
  UserOre({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.dateOfBirth,
    this.registerDate,
    this.phone,
    this.picture,
    this.location,
  });

  UserOre.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    lastName = json['lastName'];
    gender = json['gender'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    registerDate = json['registerDate'];
    phone = json['phone'];
    picture = json['picture'];
    location = json['location'];
  }
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? dateOfBirth;
  String? registerDate;
  String? phone;
  String? picture;
  String? location;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['gender'] = gender;
    map['email'] = email;
    map['dateOfBirth'] = dateOfBirth;
    map['registerDate'] = registerDate;
    map['phone'] = phone;
    map['picture'] = picture;
    map['location'] = location;
    return map;
  }

  @override
  UserOre parse(data) => UserOre.fromJson(data);
}
