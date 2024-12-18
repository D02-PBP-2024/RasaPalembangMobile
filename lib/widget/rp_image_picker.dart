import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/size_constants.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_squared_image_button.dart';

class RPImagePicker extends StatefulWidget {
  final Function(File?) onImagePicked;
  final String? initialGambar;
  final String buttonLabel;

  const RPImagePicker({
    super.key,
    required this.onImagePicked,
    this.initialGambar,
    required this.buttonLabel,
  });

  @override
  _RPImagePickerState createState() => _RPImagePickerState();
}

class _RPImagePickerState extends State<RPImagePicker> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImagePicked(_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getImageWidget(),
        SizedBox(height: 20),
        RPButton(
          onPressed: () => _showPickImageDialog(),
          label: widget.buttonLabel,
        ),
      ],
    );
  }

  Widget _getImageWidget() {
    if (_image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(RPSize.cornerRadius), // Corner radius
        child: Image.file(
          _image!,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
      );
    } else if (widget.initialGambar != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(RPSize.cornerRadius), // Corner radius
        child: Image.network(
          widget.initialGambar!,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(RPSize.cornerRadius),
        child: Container(
          width: 200,
          height: 200,
          color: RPColors.textFieldBackground,
          child: Center(
            child: Icon(Icons.image_not_supported, color: RPColors.textFieldPlaceholder),
          ),
        ),
      );
    }
  }


  void _showPickImageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'PILIH GAMBAR',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RpSquaredImageButton(
                label: 'Kamera',
                icon: Icons.camera_alt,
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              SizedBox(width: 16.0),
              RpSquaredImageButton(
                label: 'Galeri',
                icon: Icons.image,
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
