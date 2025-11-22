import 'package:authentication/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FireStoreService fireStoreService = FireStoreService();

  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController textController = TextEditingController();

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void openNoteBox(String? docID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if(docID == null){
                await fireStoreService.addNote(textController.text);
              } else{
                // update an existing note
                fireStoreService.updateNote(docID, textController.text);
              }
              textController.clear();
              Navigator.pop(context);
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox,
        child: Icon(Icons.add),
      ),
      // body: Center(
      //   child: Text("LOGGED IN AS: " + user!.email!,
      //   style: TextStyle(fontSize: 20),),
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            // display as a list
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                // get each individual doc
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                // get note from each doc
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                // display as a list tile
                return ListTile(
                  title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // update button
                      IconButton(
                        onPressed: () => openNoteBox(docID),
                        icon: Icon(Icons.settings),
                      ),

                      // delete button
                      IconButton(
                        onPressed: () => fireStoreService.deleteNote(docID),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Text("No notes..");
          }
        },
      ),
    );
  }
}
