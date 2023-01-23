import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/features/todo/domain/todo_list_controller.dart';
import 'package:riverpod_sample/features/todo/presentation/todo_list_page_v2.dart';

class TodoListPage extends ConsumerStatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends ConsumerState<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.refresh(todoListControllerProvider);
          },
          child: const Icon(Icons.refresh)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ref.watch(todoListControllerProvider).when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('No Todos found'),
                    );
                  }
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index].id.toString()),
                          Text(data[index].title ?? 'No Title found'),
                        ],
                      );
                    },
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
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const TodoListPageV2();
                    },
                  ));
                },
                child: Text('Navigate')),
          ],
        ),
      ),
    );
  }
}
