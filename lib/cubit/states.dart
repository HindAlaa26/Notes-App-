abstract class NotesStates {}

 class NotesInitialState extends NotesStates {}

 class NotesCreateDatabaseState extends NotesStates {}
 class NotesInsertDatabaseState extends NotesStates {}
 class NotesGetDatabaseState extends NotesStates {}
 class NotesDeleteDatabaseState extends NotesStates {}
 class NotesGetDatabaseLoadingState extends NotesStates {}

 class NotesUpdateTitleDatabaseState extends NotesStates {}
 class NotesUpdateSubTitleDatabaseState extends NotesStates {}
 class NotesUpdateStatusDatabaseState extends NotesStates {}


 class OnSearchTextChangedState extends NotesStates {}
 class DeleteNoteState extends NotesStates {}
 class NotesUpdateDateDatabaseState extends NotesStates {}
 class NotesUpdatetimeDatabaseState extends NotesStates {}
