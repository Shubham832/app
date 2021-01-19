import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  //Model declaration of Todo (which stores data)
  String todoId;
  String content;
  bool done;

  TodoModel({
    this.todoId,
    this.content,
    this.done,
  });

  TodoModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    todoId = documentSnapshot.id;
    content = documentSnapshot.data()['content'] as String;
    done = documentSnapshot.data()['done'] as bool;
  }
}
