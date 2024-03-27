import 'package:flutter/material.dart';
import 'package:image_editing_app/model/text_info.dart';
import 'package:image_editing_app/widgets/default_btn.dart';

import '../screens/edit_screen.dart';

abstract class EditImageViewModel extends State<EditScreen> {
  TextEditingController textEditingController = TextEditingController();
  List<TextInfo> textlist =[];
  addNewDailog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
        title: const Text('Add New Text'),
        content: TextField(
        controller: textEditingController,
        maxLines: 5,
        decoration: const InputDecoration(
        suffixIcon: Icon(Icons.edit,),
        hintText: 'Your Text Here ...',
        filled: true,),),
        actions: [
        DefaultButton(onPressed:() =>Navigator.of(context).pop(),
        color: Colors.black,
        textcolor: Colors.white,
        child:const Text('Back')),
        DefaultButton(onPressed:() =>addNewText(context),
        color: Colors.red,
        textcolor: Colors.black,
        child:const Text('Add Text')),
        ],
   ));
  }
  
  addNewText(context){
    setState(() {
      textlist.add(TextInfo(
      text: textEditingController.text,
      left: 0,
      top: 0,
      color:Colors.black,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      fontSize: 20,
      textAlign: TextAlign.left
      ));
      Navigator.of(context).pop();
    });
  }
}
