class TeacherModel {
  String? name;
  String? id;
  String? image;
  String? bio;
  String? centerName;
  String? centerNo;
  String? email;
  String? degree;

  TeacherModel({
    this.name,
    this.bio,
    this.image,
    this.centerName,
    this.centerNo,
    this.email,
    this.degree,
    this.id,
  });

  TeacherModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    id = json['id'];
    image = json['image'];
    bio = json['bio'];
    centerName = json['centerName'];
    centerNo = json['centerNo'];
    email = json['email'];
    degree = json['degree'];
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'id': id,
        'image': image,
        'centerName': centerName,
        'centerNo': centerNo,
        'email': email,
        'degree': degree,
        'bio': bio,
      };
}
