import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/features/todo/domain/todo_list_controller.dart';

class TodoListPageV2 extends ConsumerStatefulWidget {
  const TodoListPageV2({Key? key}) : super(key: key);

  @override
  ConsumerState<TodoListPageV2> createState() => _TodoListPageState();
}

class _TodoListPageState extends ConsumerState<TodoListPageV2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        ref.refresh(todoListControllerProvider);
      },child: const Icon(Icons.refresh)),
      body: Column(
        children: [
          ref.watch(todoListControllerProvider).when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('No Todos found'),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Text(data[index].title ?? 'No Title found');
                      },
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                },
                loading: () {
                  return const CupertinoActivityIndicator();
                },
              ),
        ],
      ),
    );
  }
}
