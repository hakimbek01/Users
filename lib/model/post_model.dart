class Post {
  String? name;
  String? id;
  String? avatar;
  num? count;
  Post({this.count,this.id,this.name,this.avatar});

  Post.fromJson(Map<String, dynamic> json) {
    name=json["name"];
    id=json['id'];
    count=json['count'];
    avatar=json['avatar'];
  }

  Map<String, dynamic> toJson() => {
    "name":name,
    "count":count,
    "id":id,
    "avatar":avatar
  };
}