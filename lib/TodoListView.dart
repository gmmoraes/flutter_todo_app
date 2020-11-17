import 'dart:collection';

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
  int editingIndex = -1;
  //HashMap editingIndexed = new HashMap<int, String>();
  final txtFieldController = TextEditingController();
  TodoItem itemInEdition = TodoItem(id: -1, todo: "");
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
        int foundId =
            _todoItems.indexWhere((element) => element.id == editingIndex);
        if (index < _todoItems.length) {
          //cleanEditinAction();
          int idx = foundId == index ? editingIndex:-1;
          return _buildTodoItem(_todoItems[index],idx);
        } else if (foundId == index) {
          return _buildTodoItem(_todoItems[foundId],editingIndex);
        }
      },
    );
  }

  Widget _buildTodoItem(TodoItem item, int _editingIndex) {
    return new Column(
      children: [
        Row(
          children: <Widget>[
            if (_editingIndex != -1)
              Expanded(
                child: TextField(
                  controller: txtFieldController,
                  decoration: InputDecoration(
                    hintText: "edit to do",
                    labelText: itemInEdition.todo,
                    suffixIcon: IconButton(
                      onPressed: () => textFieldAction(),
                      icon: Icon(Icons.send),
                    ),
                  ),
                ),
              )
            else
              Expanded(
                  child: ListTile(
                leading: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    _getDeleteButton(item.id), // icon-1
                    _getEditButton(item), // icon-2
                  ],
                ), // ,
                title: new Text(item.todo),
              )),
          ],
        )
      ],
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
          setState((){
            editingIndex = newItem.id;
            itemInEdition = newItem;
          });
        },
      // onPressed: () {
      //     editingIndex = newItem.id;
      //     itemInEdition = newItem;


      //   // Provider.of<TodoList>(context, listen: false).edit(newItem);
      // },
    );
  }

  void textFieldAction() {
    itemInEdition.todo = txtFieldController.text;
    Provider.of<TodoList>(context, listen: false).edit(itemInEdition);
    cleanEditinAction();
  }

  void cleanEditinAction() {
    txtFieldController.clear();
    itemInEdition = TodoItem(id: -1, todo: "");
    editingIndex = -1;
  }
}
