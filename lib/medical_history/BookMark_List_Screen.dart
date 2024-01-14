import 'package:flutter/material.dart';
import 'TabBar_View.dart';

class ToDo {
  String title;
  String description;

  ToDo(this.title, this.description);
}


class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  List<ToDo> toDoList = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController editTitleController = TextEditingController();
  final TextEditingController editDescriptionController =
      TextEditingController();

  void _addTask() {
    String title = titleController.text;
    String description = descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      setState(() {
        toDoList.add(ToDo(title, description));
        titleController.clear();
        descriptionController.clear();
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  void _editTask(BuildContext context, int index) {
    ToDo selectedTask = toDoList[index];
    titleController.text = selectedTask.title;
    descriptionController.text = selectedTask.description;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5),
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: "Add Title",
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(8, 52, 109, 1.0)),
                      ),
                    ),
                    maxLines: null,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: "Add Description",
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(8, 52, 109, 1.0)),
                      ),
                    ),
                    maxLines: null,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedTask.title = titleController.text;
                      selectedTask.description = descriptionController.text;
                      Navigator.of(context).pop();
                    });
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(30, 10, 30, 10)),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(236, 220, 248, 1.0)),
                  ),
                  child: Text('Edit Done'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheet(
      BuildContext context, String BookmarkTitle, String BookmarkDescription) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (BuildContext context) {
        return Container(
          color: Color.fromRGBO(236, 220, 248, 1.0),
          height: 500, // Adjust the height as needed
          child: Column(
            children: [
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      BookmarkTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Color.fromRGBO(8, 52, 109, 1.0),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(BookmarkDescription),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(241, 229, 220, 1.0),
        toolbarHeight: 40,
        title: Text(
          "Bookmark Notes",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(8, 52, 109, 1.0),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(

        color: Color.fromRGBO(241, 229, 220, 1.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(2),
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: ' Title',
                  hintText: "Add Title",
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Set border radius here
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(8, 52, 109, 1.0),
                    ),
                  ),
                ),
                maxLines: null,
              ),
            ),
            Container(
              margin: EdgeInsets.all(2),
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: ' Description',
                  hintText: 'Add Description',
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Set border radius here
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(8, 52, 109, 1.0),
                    ),
                  ),
                ),
                maxLines: null,
              ),
            ),
            ElevatedButton(
              onPressed: _addTask,
              child: Text(
                'ADD',
                style: TextStyle(
                    fontSize: 16.0, color: Color.fromRGBO(8, 52, 109, 1.0)),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5.0,
                padding: EdgeInsets.fromLTRB(40, 16, 40, 16),
                backgroundColor: Color.fromRGBO(236, 220, 248, 1.0),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(12),
                itemCount: toDoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 18,
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Color.fromRGBO(255, 255, 255, 1.0),
                        ),
                        backgroundColor: Color.fromRGBO(144, 125, 227, 1.0),
                      ),
                      title: Text(toDoList[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color.fromRGBO(8, 52, 109, 1.0),
                        ),),
                      subtitle: Text(toDoList[index].description),
                      trailing: IconButton(
                        onPressed: () {
                          String BookmarkTitle = toDoList[index].title;
                          String BookmarkDescription =
                              toDoList[index].description;
                          _showBottomSheet(context, BookmarkTitle,
                              BookmarkDescription); // Call the _showBottomSheet function
                        },
                        icon: Icon(Icons.arrow_forward),
                      ),
                      tileColor: Color.fromRGBO(236, 220, 248, 1.0),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Choosee"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _editTask(context, index);
                                  },
                                  child: Text("Edit"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _deleteTask(index);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 2.0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
