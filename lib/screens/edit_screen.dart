import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_editing_app/widgets/image_text.dart';
import 'package:screenshot/screenshot.dart';
import '../widgets/edit_view_model.dart';
const SizedBox box =  SizedBox(width: 5,);
class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.selectedImage});
  final String selectedImage;

  @override
  State<EditScreen> createState() => _EditScreenState();
  
}

class _EditScreenState extends EditImageViewModel {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Stack(
            children: [
              _selectedImage,
              for (int i = 0; i < texts.length; i++)
                Positioned(
                    top: texts[i].top,
                    left: texts[i].left,
                    child: GestureDetector(
                      onLongPress: () => print('on long press'),
                      onTap: () => setCurrentIndex(context,i),
                      child: Draggable(
                        feedback: ImageText(textInfo: texts[i]),
                        onDragEnd: (drag) {
                          final renderBox =
                              context.findRenderObject() as RenderBox;
                          Offset off = renderBox.globalToLocal(drag.offset);
                          setState(() {
                            texts[i].top = off.dy -96;
                            texts[i].left = off.dx;
                          });
                        },
                        child: ImageText(textInfo: texts[i]),
                      ),
                    )),
              creatorText.text.isNotEmpty
                  ? Positioned(
                      left: 0,
                      bottom: 0,
                      child: Text(
                        creatorText.text,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.3)),
                      ))
                  : const SizedBox.shrink()
            ],
          ),
        )),
      ),
      floatingActionButton: _floatingbtn,
    );
  }

  Widget get _selectedImage => Center(
        child: Image.file(
          File(widget.selectedImage),
          fit: BoxFit.fill,
        ),
      );
  Widget get _floatingbtn => FloatingActionButton(
        onPressed: () => addNewDailog(context),
        tooltip: '',
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      );

AppBar get _appBar => AppBar(
  
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            IconButton(tooltip: 'Save Image',onPressed: ()=>saveToGallery(context), icon:const Icon(Icons.save,color: Colors.black,)),
            IconButton(tooltip: 'Delete text',onPressed: (){deletetext();}, icon:const Icon(Icons.delete,color: Colors.black,)),
            IconButton(tooltip: 'Increase font size',onPressed: ()=>increaseFontSize(), icon:const Icon(Icons.add,color: Colors.black,)),
            IconButton(tooltip: 'Decrease font size',onPressed: ()=>decreaseFontSize(), icon:const Icon(Icons.remove,color: Colors.black,)),
            IconButton(tooltip: 'Align left',onPressed:alignLeft, icon:const Icon(Icons.format_align_left,color: Colors.black,)),
            IconButton(tooltip: 'Align Center',onPressed:alignCenter, icon:const Icon(Icons.format_align_center,color: Colors.black,)),
            IconButton(tooltip: 'Align Right',onPressed:alignRight, icon:const Icon(Icons.format_align_right,color: Colors.black,)),
            IconButton(tooltip: 'Bold',onPressed: () => boldText(), icon:const Icon(Icons.format_bold,color: Colors.black,)),
            IconButton(tooltip: 'Italic',onPressed: () =>italictext(), icon:const Icon(Icons.format_italic,color: Colors.black,)),
            IconButton(tooltip: 'Add New Line',onPressed: ()=>addLinesToText (), icon:const Icon(Icons.space_bar,color: Colors.black,)),
            Tooltip(message: 'Red',child: GestureDetector(onTap: ()=>changeTextColor(Colors.red) ,child: const CircleAvatar(backgroundColor: Colors.red,)),),box,
            Tooltip(message: 'white',child: GestureDetector(onTap: () => changeTextColor(Colors.white),child: CircleAvatar(radius: 21,backgroundColor: Colors.black,child: const CircleAvatar(backgroundColor: Colors.white,))),),box,
            Tooltip(message: 'Black',child: GestureDetector(onTap: () => changeTextColor(Colors.black),child: const CircleAvatar(backgroundColor: Colors.black,)),),box,
            Tooltip(message: 'Blue',child: GestureDetector(onTap: () => changeTextColor(Colors.blue),child: const CircleAvatar(backgroundColor: Colors.blue,)),),box,
            Tooltip(message: 'Yellow',child: GestureDetector(onTap: () => changeTextColor(Colors.yellow),child: const CircleAvatar(backgroundColor: Colors.yellow,)),),box,
            Tooltip(message: 'Green',child: GestureDetector(onTap: () => changeTextColor(Colors.green),child: const CircleAvatar(backgroundColor: Colors.green,)),),box,
            Tooltip(message: 'Orange',child: GestureDetector(onTap: () => changeTextColor(Colors.orange),child: const CircleAvatar(backgroundColor: Colors.orange,)),),box,
            Tooltip(message: 'Pink',child: GestureDetector(onTap: () => changeTextColor(Colors.pink),child: const CircleAvatar(backgroundColor: Colors.pink,)),),box,
          ],
        ),
      ),
    );
    
}

