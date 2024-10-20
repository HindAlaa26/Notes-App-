abstract class NotesStates {}

 class NotesInitialState extends NotesStates {}

// database
 class NotesCreateDatabaseState extends NotesStates {}
 class NotesInsertDatabaseState extends NotesStates {}
 class NotesGetDatabaseState extends NotesStates {}
 class NotesDeleteDatabaseState extends NotesStates {}
 class NotesGetDatabaseLoadingState extends NotesStates {}

// update database
 class NotesUpdateTitleDatabaseState extends NotesStates {}
 class NotesUpdateSubTitleDatabaseState extends NotesStates {}
 class NotesUpdateDateDatabaseState extends NotesStates {}
 class NotesUpdatetimeDatabaseState extends NotesStates {}

// delete note from database
 class DeleteNoteState extends NotesStates {}

// sort notes by time
 class NotesSortState extends NotesStates {}

// search for note
 class OnSearchTextChangedState extends NotesStates {}
 
