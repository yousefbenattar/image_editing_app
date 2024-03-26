import 'package:flutter/material.dart';
import 'package:image_editing_app/screens/edit_screen.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
            onPressed: () async {
              XFile? file =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (file != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditScreen(selectedImage: file.path)));
              }
            },
            icon: const Icon(Icons.upload_file)),
      ),
    );
  }
}
