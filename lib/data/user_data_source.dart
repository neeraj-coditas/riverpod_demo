
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:riverpod_tutorial/data/user_model.dart';
import 'package:riverpod_tutorial/domain/user_entity.dart';

class UserDataSource{
  String endpoint = 'https://jsonplaceholder.typicode.com/users';

  Future<List<UserEntity>> getUsers() async{
    Response response = await get(Uri.parse(endpoint));
    if(response.statusCode == 200){
      final List result = jsonDecode(response.body);
      return result.map((e) {
        print(e);
        return UserModel.fromJson(e);
      }).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }

}