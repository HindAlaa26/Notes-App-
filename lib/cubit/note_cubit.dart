import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/cubit/states.dart';
import 'package:notes_app/models/note.dart';
import 'package:sqflite/sqflite.dart';

class NotesCubit extends Cubit<NotesStates>
{
  NotesCubit() : super (NotesInitialState());
 static NotesCubit get(context) => BlocProvider.of(context);

  List<Note> filteredNotes = [];
  bool sorted = false;
  List<Note> sortNotesByModifiedTime(List<Note> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }

    sorted = !sorted;

    return notes;
  }

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

void onSearchTextChanged(String searchText) {
  filteredNotes = sampleNotes.where((note) =>
    note.content.toLowerCase().contains(searchText.toLowerCase()) ||
    note.title.toLowerCase().contains(searchText.toLowerCase())
  ).toList();
  emit(OnSearchTextChangedState());
}


  void deleteNote(int index) {
   
      Note note = filteredNotes[index];
      sampleNotes.remove(note);
      filteredNotes.removeAt(index);
   emit(DeleteNoteState());
  }
  
   late Database database;
  List<Map> notes = [];
 

  void createDatabase() async {
  try{
     database = await openDatabase(
      'notes.db',
      version: 1,
      onCreate: (db, version) {
        print("database created");
        db.execute('CREATE TABLE notes(id INTEGER PRIMARY KEY,title TEXT,subTitle TEXT,date TEXT, time TEXT, status TEXT)').then((value) {
          print("table created");
        }).catchError((error) {
          print("Error when creating table ${error.toString()}");
        });
      },
      onOpen: (db) {
        getDataFromDatabase(db);  
        print("database opened");
      },
    );
      emit(NotesCreateDatabaseState());
  }
  catch (error){
    print("Error when opening database ${error.toString()}");
  }
  }

   insertToDatabase({
    required String title,
    required String time,
    required String date,
    required String subTitle,
  }) async
  {
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO notes(title,subTitle,date,time,status) VALUES("$title","$subTitle","$date","$time","NEW")')
          .then((value) {
        print("$value inserted successfully");
        emit(NotesInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print("error when inserting new record ${error.toString()}");
      });
    });
  }

  void getDataFromDatabase(database)async
  {
    notes = [];

    emit(NotesGetDatabaseLoadingState());
   try{
     var value =  await database.rawQuery('SELECT * FROM notes');
     value.forEach((element) {
         if(element["status"] == 'NEW')
           {
             notes.add(element);
           }

       });
       
       emit(NotesGetDatabaseState());
   }
   catch (error){
    print("Error when getting data from database ${error.toString()}");
   }
  }

  void updateStatus({
    required String status,
    required int id,
})async
  {
    database.rawUpdate(
        'UPDATE notes SET status = ? WHERE id = ?',
        [status, id]).then((value) {
         getDataFromDatabase(database);
          emit(NotesUpdateStatusDatabaseState());

    });
  }

  void updateNoteData({
     required String title,
     required String subTitle,
     required String date,
     required String time,
    required int id,
  })async
  {
    database.rawUpdate(
        'UPDATE notes SET title = ?, subTitle = ?, date = ?, time = ? WHERE id = ?',
        [title, subTitle, date, time,id]).then((value) {
      getDataFromDatabase(database);
      emit(NotesUpdateTitleDatabaseState());

    });
  }

  void deleteData({
    required int id,
  })async
  {
    database.rawDelete(
        'DELETE FROM notes WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(NotesDeleteDatabaseState());

    });
  }

}