import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/cubit/note_cubit.dart';
import 'package:notes_app/cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';


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
      backgroundColor: ColorUtility.darkGrey,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                      NotesCubit.get(context).isSubTitleClick = false;
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: ColorUtility.mediumGrey.withOpacity(.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: ColorUtility.white,
                    ),
                  ))
            ],
          ),
          Expanded(
            child: BlocBuilder<NotesCubit, NotesStates>(
              builder: (context, state) {
                final cubit = NotesCubit.get(context);
                return ListView(
                  children: [
                    TextField(
                      controller: _titleController,
                      style: const TextStyle(
                        color: ColorUtility.white,
                        fontSize: 30,
                      ),
                      cursorColor: ColorUtility.lightGrey,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle: TextStyle(
                          color: ColorUtility.grey,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 0.1,
                      color: ColorUtility.grey,
                    ),
                  if (widget.note?['subTitle'] != null)
                    cubit.isSubTitleClick
                        ? 
                        buildEditableSubtitle()
                        
                        :
                         buildLinkifiedSubtitle()
                   else 
                           buildEditableSubtitle()
                        
                  ]
                );
              }
        
        ),
      ),
        ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if((_contentController.text.isEmpty && _titleController.text.isEmpty) ||_contentController.text.isEmpty ||  _titleController.text.isEmpty )
          {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: ColorUtility.darkGrey,
                  title: const SizedBox(
                    height: 60,
                    child: Icon(
                      Icons.warning_amber,
                      color: ColorUtility.amber,
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
                          style: TextStyle(color: ColorUtility.white,
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
  NotesCubit.get(context).isSubTitleClick = false;
          }
        


    
       
        },
        elevation: 10,
        backgroundColor: ColorUtility.mediumGrey,
        child: const Icon(Icons.save,color: ColorUtility.lightGrey),
      ),
    );
  }

  Widget buildLinkifiedSubtitle() {
    final cubit = NotesCubit.get(context);
    return InkWell(
      onTap: () {
        cubit.getSubTitle();
      },
      child: Linkify(
        text: widget.note?['subTitle'] ?? "",
        onOpen: (link) async {
          if (!await launchUrl(Uri.parse(link.url))) {
            throw Exception('Could not launch ${link.url}');
          }
        },
        linkStyle: const TextStyle(fontSize: 18),
        style: const TextStyle(
          fontSize: 18,
          color: ColorUtility.white,
        ),
      ),
    );
  }
  Padding buildEditableSubtitle() {
    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            controller: _contentController,
                            style: const TextStyle(
                              color: ColorUtility.white,
                            ),
                            maxLines: null,
                            cursorColor: ColorUtility.lightGrey,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type something here',
                              hintStyle: TextStyle(
                                color: ColorUtility.grey,
                              ),
                            ),
                          ),
                      );
  }
}