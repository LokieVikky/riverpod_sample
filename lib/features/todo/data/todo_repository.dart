import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/features/todo/domain/todo.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_sample/others/api_endpoints.dart';

final todoRepositoryProvider = Provider((ref) => TodoRepository());

class TodoRepository {
  Future<List<ToDo>> getTodoList() async {
    http.Response response = await http.get(Uri.parse(APIEndpoints.getAllTodo));
    if (response.statusCode == 200) {
      List temp = jsonDecode(response.body);
      return temp.map((e) => ToDo.fromJson(e)).toList();
    }
    throw Exception("${response.statusCode} ${response.body}");
  }
}
