import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo list',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 32, 52, 76),
        textTheme: GoogleFonts.comfortaaTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('ToDo List'),
          backgroundColor: const Color.fromARGB(255, 55, 89, 130),
        ),
        body: const ToDoListPage(),
      ),
    );
  }
}

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  late String _textFieldValue = '';
  List<String> toDoList = [];

  void _addTask() {
    setState(() {
      if (_textFieldValue.isNotEmpty) {
        toDoList.add(_textFieldValue);
        _textFieldValue = '';
      }
    });
  }

  void _deleteListItem(String listItem) {
    setState(() {
      toDoList.remove(listItem);
        _textFieldValue = listItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          toDoList.isEmpty ? const Column(
            children: [
              SizedBox(height: 100,),
              Text(
                'There are no tasks',
                style: TextStyle(fontSize: 30, color: Colors.white,),
              ),
              SizedBox(height: 20,),
              Icon(
                Icons.mood_bad,
                size: 100,
                color: Colors.white,
              )
            ],
          ) : const Text(''),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.separated(
                itemCount: toDoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: index == 0 ? const Radius.circular(15) : Radius.zero,
                          topRight: index == 0 ? const Radius.circular(15) : Radius.zero,
                          bottomRight: index == toDoList.length - 1 ? const Radius.circular(15) : Radius.zero,
                          bottomLeft: index == toDoList.length - 1 ? const Radius.circular(15) : Radius.zero,
                        ),
                    ),
                    title: Text(
                      toDoList[index],
                      style: const TextStyle(color: Colors.teal, fontSize: 19,),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red,),
                      onPressed: () {
                        _deleteListItem(toDoList[index]);
                      },
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 55, 89, 130),
            padding: const EdgeInsets.only(top: 30),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 40),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: _textFieldValue),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.none,
                          ),
                        ),
                        labelText: 'Add Task',
                        labelStyle: TextStyle(color: Colors.teal,),
                      ),
                      onChanged: (value) {
                        _textFieldValue = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}