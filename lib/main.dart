import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter CRUD App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Item {
  final int id;
  String name;

  Item({required this.id, required this.name});
}

class _MyHomePageState extends State<MyHomePage> {
  int _nextId = 1;
  TextEditingController _textEditingController = TextEditingController();
  List<Item> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _items[index];
          return ListTile(
            title: Text(item.name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteItem(item.id);
              },
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Edit Item'),
                    content: TextField(
                      controller: _textEditingController..text = item.name,
                      decoration: InputDecoration(hintText: 'Enter new name'),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Update'),
                        onPressed: () {
                          _updateItem(item.id, _textEditingController.text);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add New Item'),
                content: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(hintText: 'Enter item name'),
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      _addItem(_textEditingController.text);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addItem(String itemName) {
    setState(() {
      _items.add(Item(id: _nextId++, name: itemName));
    });
  }

  void _updateItem(int id, String newName) {
    setState(() {
      final index = _items.indexWhere((item) => item.id == id);
      if (index != -1) {
        _items[index].name = newName;
      }
    });
  }

  void _deleteItem(int id) {
    setState(() {
      _items.removeWhere((item) => item.id == id);
    });
  }
}
