import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/cubit/note_cubit.dart';


class EditScreen extends StatefulWidget {
  final Map<dynamic, dynamic>? note;
 
  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      _titleController = TextEditingController(text: widget.note!['title']);
      _contentController = TextEditingController(text: widget.note!['subTitle']);
    }

    super.initState();
  }
void _saveNote() {
  final title = _titleController.text;
  final content = _contentController.text;

  if (title.isNotEmpty && content.isNotEmpty) {
    if (widget.note != null) {
      NotesCubit.get(context).updateNoteData(
        title: title,
        subTitle: content,
        date: DateFormat.yMMMd().format(DateTime.now()),
        time: TimeOfDay.now().format(context).toString(),
        id: widget.note!['id'], 
      );
    } else {
      NotesCubit.get(context).insertToDatabase(
        title: title,
        subTitle: content,
        date: DateFormat.yMMMd().format(DateTime.now()),
        time: TimeOfDay.now().format(context).toString(),
      );
    }
    Navigator.pop(context);
  }
}

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
     super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800.withOpacity(.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
          Expanded(
              child: ListView(
            children: [
              TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white, fontSize: 30),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 30)),
              ),
              TextField(
                controller: _contentController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                maxLines: null,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type something here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
            ],
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if((_contentController.text.isEmpty && _titleController.text.isEmpty) ||_contentController.text.isEmpty ||  _titleController.text.isEmpty )
          {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.grey.shade900,
                  title: const SizedBox(
                    height: 60,
                    child: Icon(
                      Icons.warning_amber,
                      color: Colors.amber,
                      size: 25,
                    ),
                  ),
                  content: const Text('Please fill in all fields',
                                            textAlign: TextAlign.center,

                  style: TextStyle(
                    color: ColorUtility.white ,
                    fontSize: 18,
                  ),),
                  actions:[
                         SizedBox(
                        width: 60,
                        child: TextButton(
                            onPressed: () {
                          Navigator.pop(context);
                            },
                         child:  const Text(
                          'OK',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,
                          fontSize: 18,
                         ),
                        )),
                      )
                  ],
                );
              },
            );
            return;
          }
          else
          {
  _saveNote();
          }
        


    
       
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.save,color: ColorUtility.grey),
      ),
    );
  }
}