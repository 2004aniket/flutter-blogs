import '../../../../core/common/User.dart';

class Usermodel extends User {
  Usermodel(super.id, super.name, super.email);

  factory Usermodel.fromJson(Map<String, dynamic> map) {
    return Usermodel(map["id"] ?? '', map['name'] ?? '', map["email"] ?? '');
  }
}
