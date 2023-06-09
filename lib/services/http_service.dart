import 'dart:convert';

import 'package:http/http.dart';

import '../model/post_model.dart';

class Network {


  static String BASE="64088dcf2f01352a8a965e74.mockapi.io";

  static String API_LIST = "/user";
  static String API_CREATE = "/user";
  static String API_UPDATE = "/user/"; //{id}
  static String API_DELETE = "/user/";

  static Future<String?> GET(String api, Map<String,dynamic> params) async {
    var uri = Uri.https(BASE,api,params);
    var response = await get(uri);

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> POST(String api, Map<String, dynamic> params) async {
    print(params.toString());
    var uri = Uri.https(BASE, api); // http or https
    var response = await post(uri, body: jsonEncode(params));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, api); // http or https
    var response = await put(uri, body: jsonEncode(params));
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DEL(String api, Map<String, double> params) async {
    var uri = Uri.https(BASE, api, params); // http or https
    var response = await delete(uri, );

    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, dynamic> paramsCreate(Post post) {
    Map<String, dynamic> params = {};

    params.addAll({
      "name":post.name!,
      "id":post.id!,
      "avatar":post.avatar!
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Post post) {
    Map<String, String> params = {};
    params.addAll({
      "name":post.name!,
      "id":post.id!,
      "avatar":post.avatar!
    });
    return params;
  }

  static List<Post> parsePostList(String response) {
    dynamic json = jsonDecode(response);
    var data = List<Post>.from(json.map((x) => Post.fromJson(x)));
    return data;
  }

  static Post parsePostCreate(String response) {
    dynamic json = jsonDecode(response);
    var data =  Post.fromJson(json);
    return data;
  }

}