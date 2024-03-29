import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_editing_app/model/text_info.dart';
import 'package:image_editing_app/utiles/utils.dart';
import 'package:image_editing_app/widgets/default_btn.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../screens/edit_screen.dart';

abstract class EditImageViewModel extends State<EditScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  List<TextInfo> texts=[];
  int currentIndex = 0 ;
  saveToGallery(BuildContext context){
    if(texts.isNotEmpty){
      screenshotController.capture().then((Uint8List? image){saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(content: Text('Image Saved',style: TextStyle(fontSize: 16),))
    );
    }
      ).catchError((error)=> print(error));
    }
  }
  saveImage(Uint8List bytes) async {
    final time = DateTime.now().toIso8601String().replaceAll('.', '-').replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes,name: name);
  }
  deletetext(){
    setState(() {
      texts.removeAt(currentIndex);
    });
     ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(content: Text('Text Deleted',style: TextStyle(fontSize: 16),))
    );
  }
  setCurrentIndex(BuildContext context,index){
    setState(() {currentIndex = index;});
    ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(content: Text('Selected For Styling',style: TextStyle(fontSize: 16),))
    );
  }
  addLinesToText (){
    setState(() {
      if(texts[currentIndex].text.contains('\n'))
      {
       texts[currentIndex].text = texts[currentIndex].text.replaceAll('\n', ' ');
      }
      else{
      texts[currentIndex].text =  texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }
  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italictext() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }
   addNewText(BuildContext context){
    setState(() {
      texts.add(TextInfo(
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
      textEditingController.clear();
    });
  }
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
        child:const Text('Back',style: TextStyle(color: Colors.white),)),
        DefaultButton(onPressed:() =>addNewText(context),
        color: Colors.blue,
        textcolor: Colors.white,
        child:const Text('Add Text',style: TextStyle(color: Colors.white),)),
        ],
   ));
  }
}
