

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


 List<String> todoList=["Coding","Do exercise"];

 final inputValue= TextEditingController();

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
          child:Text(todoList[index],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500
          ),
          
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
             backgroundColor: Colors.amber[400],
            //  insetPadding: EdgeInsets.all(100),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TextField(
                //  controller: inputValue,
                // ),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
               [ElevatedButton(onPressed: (){
                        
                }, child: Text('Add')),
                        
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