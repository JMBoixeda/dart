import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  final _picker = ImagePicker();

  Future<void> _takePicture() async {
    final imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }

    final imageFileStored = File(imageFile.path);
    setState(() {
      _storedImage = imageFileStored;
    });

    final fileName = path.basename(imageFileStored.path);
    final appDir = await syspaths.getApplicationSupportDirectory();
    final savedImage = await imageFileStored.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 230,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No hay fotografia de factura eléctrica',
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(
          height: 20.0,
        ),
        FlatButton.icon(
          icon: Icon(Icons.camera),
          label: Text(
            'Añada una Foto de su Factura eléctrica',
            overflow: TextOverflow.clip,
          ),
          textColor: Theme.of(context).primaryColor,
          onPressed: _takePicture,
        ),
      ],
    );
  }
}
