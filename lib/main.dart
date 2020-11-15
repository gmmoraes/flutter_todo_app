import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TodoListView.dart';
import 'package:todo_app/Providers/TodoList.dart';
import 'dart:math';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoList(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  //final todoListView = Provider.of<TodoListView>(context, listen: false);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var todoListView = TodoListView();
  final txtFieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    txtFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo app",
      home: Scaffold(
        appBar: AppBar(title: Text("Todo app")),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: txtFieldController,
                    decoration: InputDecoration(
                      hintText: "Add a to do",
                      suffixIcon: IconButton(
                        onPressed: () => txtFieldController.clear(),
                        icon: Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    Random random = new Random();
                    int randomNumber = random.nextInt(100);
                    TodoItem currentTodo = TodoItem(
                        id: randomNumber,
                        todo: Text(txtFieldController.text).data);
                    Provider.of<TodoList>(context, listen: false)
                        .add(currentTodo);
                        txtFieldController.clear();
                  },
                )
              ],
            ),

            ///LEMBRAR DO TRANSACTION QUE USA MAP PARA MOSTRAR NA LIST VIEW TUDO DISPONIVEL NA LISTA DE TRANSACTION
            Expanded(
              child: todoListView,
            ),
          ],
        ),
      ),
    );
  }
}
