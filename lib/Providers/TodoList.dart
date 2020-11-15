import 'package:flutter/foundation.dart';

class TodoItem {
  final int id;
  String todo;

  TodoItem({
    @required this.id,
    @required this.todo,
  });
}

class TodoList with ChangeNotifier {
  TodoList();

  List<TodoItem> _todoItems = [];

  List<TodoItem> get getItems {
    return _todoItems;
  }

  void add(TodoItem task) {
    try {
      if (task.todo.length > 0) {
        _todoItems.add(task);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void remove(int id) {
    try {
      _todoItems.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
  void edit(TodoItem item) {
    try {
      TodoItem itemToBeEdited = _todoItems.where((element) => element.id == item.id).first;
      int indexToEdit = _todoItems.indexOf(itemToBeEdited);
      _todoItems[indexToEdit].todo = item.todo;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
