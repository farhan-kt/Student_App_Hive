import 'package:flutter/material.dart';
import 'package:student_app/db/functions/db_functions.dart';
import 'package:student_app/db/model/data_model.dart';
import 'package:student_app/screens/home/add.dart';
import 'package:student_app/screens/home/edit.dart';

class MyWidget extends StatefulWidget {
  final Key? key;

  const MyWidget({this.key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
        appBar: AppBar(
          title: Text("STUDENT LIST"),
          backgroundColor: Colors.green[400],
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        ),
        body: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext ctx, List<StudentModel> studentList,
              Widget? child) {
            return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = studentList[index];
                  return ListTile(
                    title: Text("NAME :" + data.name,
                        style: TextStyle(color: Colors.black)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AGE     :" + data.age,
                          style: TextStyle(color: Colors.black),
                        ),
                        Text("CLASS :" + data.clas,
                            style: TextStyle(color: Colors.black)),
                        Text("PLACE :" + data.address,
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditScreen(
                                          name: data.name,
                                          age: data.age,
                                          clas: data.clas,
                                          address: data.address,
                                          image: data.image,
                                          index: index,
                                        )));
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 16), // Add some space between icons
                        IconButton(
                          onPressed: () {
                            deleteStudent(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: studentList.length);
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.green[400],
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => ScreenList())));
            },
            label: Text("ADD STUDENT"),
            icon: Icon(Icons.person_add)));
  }
}