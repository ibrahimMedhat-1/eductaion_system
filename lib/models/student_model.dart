class StudentModel {
  String? name;
  String? email;
  String? phone;
  String? id;
  String? password;
  StudentParentData? parentData;

  StudentModel(
    this.name,
    this.email,
    this.phone,
    this.id,
    this.password,
    this.parentData,
  );

  StudentModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    parentData = StudentParentData.fromJson(json['parentData']);
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'phone': phone,
        'id': id,
        'password': password,
        'parentData': parentData!.toMap(),
      };
}

class StudentParentData {
  String? name;
  String? email;
  String? phone;

  StudentParentData(this.name, this.email, this.phone);

  StudentParentData.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'email': email,
      };
}
