import 'package:flutter/material.dart';
import 'package:notes_app/constants/colors.dart';

Widget defaultButton({
  required  BuildContext context,
  required VoidCallback onClick,
  required String title,
})
{
  return      MaterialButton(
              minWidth: 250,
              height: 45,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            
              onPressed: onClick,animationDuration:  const Duration(milliseconds: 3),
            color: ColorUtility.main,child:  Text(title,style: const TextStyle(color: Colors.white),),);
}