

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/cubit/note_cubit.dart';
import 'package:notes_app/cubit/note_states.dart';
import 'package:notes_app/screens/edit.dart';
import 'package:notes_app/shared/network/local_network/preferences_helper.dart';
import 'package:notes_app/shared/shared_component/task_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.secondary,
      body: BlocBuilder<NotesCubit,NotesStates>
      (
        builder: (context, state) {
        NotesCubit cubit = NotesCubit.get(context);
          var notes = cubit.notes;
      
      
        return  Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notes',
                  style: TextStyle(fontSize: 30, color: ColorUtility.white),
                ),
                IconButton(
                    onPressed: () {
                     
                       notes = cubit.sortNotesByModifiedTime(notes);
                     
                    },
                    padding: const EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: ColorUtility.mediumGrey.withOpacity(.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.sort,
                        color: ColorUtility.white,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            
            TextField(
              onChanged: cubit.onSearchTextChanged,
              style: const TextStyle(fontSize: 16, color: ColorUtility.white),
              cursorColor: ColorUtility.lightGrey,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search notes...",
                
                hintStyle: const TextStyle(color: ColorUtility.grey),
                prefixIcon: const Icon(
                  Icons.search,
                  color: ColorUtility.grey,
                ),
                fillColor: ColorUtility.mediumGrey,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child:tasksBuilder( notes:notes, iconIsEmpty: Icons.note_add_sharp,textIsEmpty: "NO notes yet, Please add some notes")

              )
          ],
                  ),
        );
          
      },
      
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const EditScreen(),
            ),
          );
 
        },
        elevation: 10,
        backgroundColor: ColorUtility.mediumGrey,
        child: const Icon(
          Icons.add,
          size: 38,
          color: ColorUtility.lightGrey,
        ),
      ),
    );
  }

}