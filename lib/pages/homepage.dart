import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _tododb = Hive.box('TodoDB');

  List tododbvalue = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 

    if (_tododb.get('todo').isEmpty) {
     
      tododbvalue = [
        ["Coding", true],
        ["Do exercise", false],
      ];
    } else {
      tododbvalue = _tododb.get('todo');
    }
  }

  final inputValue = TextEditingController();

  bool istaskdone = false;

  void addTask(String userinput) {
    setState(() {
      tododbvalue.add([userinput, false]);
      _tododb.put('todo', tododbvalue);
      print(_tododb.get('todo'));
      // todoList.add([userinput,false]);
    });
  }

  void removeTask(int removingindex) {
    setState(() {
      tododbvalue.removeAt(removingindex);
      _tododb.put('todo', tododbvalue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Todo App',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.amber[400],
        elevation: 0,
        
      ),

      body: Container(
        color: Colors.amber[300],
        child: ListView.separated(
          padding: EdgeInsets.all(10),
          itemCount: tododbvalue.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(8),
              height: 50,
              color: Colors.amber[400],

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: tododbvalue[index][1],
                        onChanged: (value) {
                          setState(() {
                            tododbvalue[index][1] = value!;
                            _tododb.put('todo', tododbvalue);
                          });
                        },
                      ),
                      Text(
                        tododbvalue[index][0],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          decoration:
                              tododbvalue[index][1]
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                        ),
                      ),
                    ],
                  ),

                  IconButton(
                    onPressed: () {
                      removeTask(index);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, value) {
            return SizedBox(height: 20);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        shape: CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (builder) {
              return Dialog(
                backgroundColor: Colors.amber[300],
                child: Container(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                       
                      children: [
                        TextField(
                          controller: inputValue,
                           
                          decoration: InputDecoration(
                            hintText: 'Enter your Task',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                addTask(inputValue.text);
                                Navigator.of(builder).pop();
                                inputValue.clear();
                              },
                              child: Text('Add'),
                            ),
                    
                            SizedBox(width: 30),
                    
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(builder).pop();
                              },
                              child: Text('Cancel'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
