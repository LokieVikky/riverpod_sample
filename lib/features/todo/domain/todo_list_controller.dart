import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/features/todo/data/todo_repository.dart';
import 'package:riverpod_sample/features/todo/domain/todo.dart';

final todoListControllerProvider =
    StateNotifierProvider<ToDoListController, AsyncValue<List<ToDo>>>((ref) {
  return ToDoListController(repository: ref.read(todoRepositoryProvider));
});

class ToDoListController extends StateNotifier<AsyncValue<List<ToDo>>> {
  TodoRepository repository;

  ToDoListController({required this.repository}) : super(const AsyncData([])) {
    getAllTodos();
  }

  void getAllTodos() async {
    state = const AsyncLoading();

    // try {
    //   List<ToDo> todos = await repository.getTodoList();
    //   state = AsyncData(todos);
    // } catch (e) {
    //   state = AsyncError(e,StackTrace.current);
    // }

    state = await AsyncValue.guard(() => repository.getTodoList());
  }
}
