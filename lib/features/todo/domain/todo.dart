class ToDo {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  ToDo.fromJson(Map json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }
}
