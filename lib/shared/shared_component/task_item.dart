
import 'package:flutter/material.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/cubit/note_cubit.dart';
import 'package:notes_app/screens/edit.dart';


Widget buildTaskItem({required Map model,context, required int noteIndex}) {
 
NotesCubit cubit = NotesCubit.get(context);
 return Dismissible(
  key: Key(model["id"].toString()),
   background: Container(
    color: ColorUtility.main,
     child: const Padding(
       padding: EdgeInsets.all(30.0),
       child: Text("Delete",style: TextStyle(color: ColorUtility.white,
           
       ),),
     ),
   ),
  
  child: Padding(
    padding: const EdgeInsets.all(15.0),
    child:Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  color: cubit.getRandomColor(),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditScreen(note: cubit.notes[noteIndex]),
                          ),
                        );
                  
                        
                      },
                      title: RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: '${model['title']} \n',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 1.5),
                            children: [
                              TextSpan(
                                text: "${model['subTitle']}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    height: 1.5),
                              )
                            ]),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "${model['date']} , ${model['time']}",
                          style: TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade800),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          final result = await confirmDialog(context);
                          if (result != null && result) {
                           NotesCubit.get(context).deleteData(id: model["id"]);
                     
                          }
                        },
                        icon: const Icon(
                          Icons.delete,
                        ),
                      ),
                    ),
                  ),
                )),
                onDismissed: (direction){
  NotesCubit.get(context).deleteData(id: model["id"]);
  },

);

}

Widget tasksBuilder({
  required List<Map> notes,
  required IconData iconIsEmpty,
  required String textIsEmpty,
})
{

  return notes.isNotEmpty ? ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(model: notes[index],context : context, noteIndex : index),
      separatorBuilder: (context, index) => const SizedBox(
        height: 5,
      ),
      itemCount: notes.length) :  Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconIsEmpty,size: 90,color: ColorUtility.lightGrey.withOpacity(0.5)),
            const SizedBox(height: 30,),
            Text(textIsEmpty,style:  TextStyle(fontWeight:FontWeight.bold,fontSize: 20,color: ColorUtility.lightGrey.withOpacity(0.5),),textAlign: TextAlign.center,),
          ],
        );
}

Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            icon: const Icon(
              Icons.info,
              color: Colors.grey,
            ),
            title: const Text(
              'Are you sure you want to delete?',
              style: TextStyle(color: Colors.white),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'Yes',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'No',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ]),
          );
        });
  }
