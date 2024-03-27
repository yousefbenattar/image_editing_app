import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/edit_view_model.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key,required this.selectedImage});
  final String selectedImage;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.file(File(widget.selectedImage)),
      floatingActionButton: floatingbtn(),
    );
  }
  Widget floatingbtn () =>
  FloatingActionButton(onPressed: () => addNewDailog(context),
  tooltip: '',
  backgroundColor: Colors.blue,
  child:const Icon(Icons.edit,color: Colors.white,),
  );
  
}

