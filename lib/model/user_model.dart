class UserModel {
  String? name;
  String? email;
  String? password;
  String? id;
  UserModel({this.id,this.name,this.email,this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    email = json['email'];
    password = json['password'];
  }

  Map<String,dynamic> toJson() => {
    "name":name,
    "id":id,
    "email":email,
    "password":password,
  };

}
