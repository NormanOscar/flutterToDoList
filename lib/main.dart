import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars Characters App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 32, 52, 76),
        fontFamily: 'Comfortaa',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('To Do List'),
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

  void _copyText() {
    setState(() {
      toDoList.add(_textFieldValue);
      _textFieldValue = '';
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
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
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
                      )
                    ),
                    title: Text(
                      toDoList[index],
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 19,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _deleteListItem(toDoList[index]);
                      },
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: _textFieldValue),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        labelText: 'Add To Do',
                      ),
                      onChanged: (value) {
                        _textFieldValue = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _copyText,
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
          ],
        ),
      ),
    );
  }
}
