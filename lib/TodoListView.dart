import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Providers/TodoList.dart';

class TodoListView extends StatefulWidget {
  @override
  _TodoListViewState createState() {
    return _TodoListViewState();
  }
}

class _TodoListViewState extends State<TodoListView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildTodoList(),
    );
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        List<TodoItem> _todoItems = Provider.of<TodoList>(context).getItems;
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]);
        }
      },
    );
  }

  Widget _buildTodoItem(TodoItem item) {
    return new ListTile(
      leading: Wrap(
        spacing: 12, // space between two icons
        children: <Widget>[
          _getDeleteButton(item.id), // icon-1
          _getEditButton(item), // icon-2
        ],
      ), // ,
      title: new Text(item.todo),
    );
  }

  Widget _getDeleteButton(int key) {
    return new IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        Provider.of<TodoList>(context, listen: false).remove(key);
      },
    );
  }

  Widget _getEditButton(TodoItem newItem) {
    return new IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Provider.of<TodoList>(context, listen: false).edit(newItem);
      },
    );
  }
}
