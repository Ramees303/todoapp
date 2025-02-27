

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


 List todoList=[["Coding",true],["Do exercise",false]];

 final inputValue= TextEditingController();

  bool istaskdone=false;

 void addTask(String userinput){
  setState(() {
    List userValue = [];
    userValue.add(userinput);
    userValue.add(false);
     todoList.add(userValue);
  });
 
 }


 void removeTask(int removingindex){
  setState(() {
    todoList.removeAt(removingindex);
  });
 
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Todo App',
        style: TextStyle(
           fontWeight: FontWeight.bold,
            color: Colors.black
        ),)),
        backgroundColor: Colors.amber[400],  
        elevation: 0,
        
      ),

     body: Container(
      color: Colors.amber[300],
      child: ListView.separated(
        padding: EdgeInsets.all(10),
        itemCount: todoList.length,
        itemBuilder:(context,index){
        return Container(
          padding: EdgeInsets.all(8),
          height:50,
          color: Colors.amber[400],
          
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(value:todoList[index][1] , onChanged:(value){
                     setState(() {
                        todoList[index][1]=value!;
                     });
                  } ),
                  Text(todoList[index][0],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    decoration: todoList[index][1]? TextDecoration.lineThrough:TextDecoration.none
                    
                  ),
                  
                  ),
                ],
              ),

              IconButton(onPressed: (){
                 removeTask(index);
              }, icon: Icon(Icons.delete))
            ],
          )
        );
      },
      separatorBuilder: (context,value){
                 return SizedBox(
                  height: 20,
                 );
      }
      
      
      ),
     ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.amber[400],
      shape: CircleBorder(),
      onPressed:(){

        showDialog(context: context, builder: (builder){
           return Dialog(
             backgroundColor: Colors.amber[300],
              insetPadding: EdgeInsets.only(top: 270 ,bottom: 270 ,left: 50 ,right: 50),
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
                children: 
               [ElevatedButton(onPressed: (){
                       addTask(inputValue.text);
                       Navigator.of(builder).pop();
                       inputValue.clear();
                }, child: Text('Add')),

                   SizedBox(
                    width: 30,
                   ),

               ElevatedButton(onPressed: (){
                  Navigator.of(builder).pop();
                }, child: Text('Cancel')) ])
              ],
             ),
           );
        });

    },
    child: Icon(Icons.add,color: Colors.black,),
    ),

       );
  }
}