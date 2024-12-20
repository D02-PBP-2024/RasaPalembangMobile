import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/size_constants.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';

class RPImagePicker extends StatefulWidget {
  final Function(File?) onImagePicked;
  final String? initialGambar;
  final String buttonLabel;
  final double imagePreviewWidth;
  final double imagePreviewHeight;
  final bool? rounded;

  const RPImagePicker({
    super.key,
    required this.onImagePicked,
    this.initialGambar,
    required this.buttonLabel,
    required this.imagePreviewWidth,
    required this.imagePreviewHeight,
    this.rounded = false,
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
        TextButton(
          onPressed: () => _showPickImageDialog(),
          child: Text(widget.buttonLabel),
        ),
      ],
    );
  }

  Widget _withImage() {
    return Image.file(
      _image!,
      height: widget.imagePreviewHeight,
      width: widget.imagePreviewWidth,
      fit: BoxFit.cover,
    );
  }

  Widget _withInitialImage() {
    return Image.network(
      widget.initialGambar!,
      height: widget.imagePreviewHeight,
      width: widget.imagePreviewWidth,
      fit: BoxFit.cover,
    );
  }

  Widget _withoutImage() {
    return Container(
      height: widget.imagePreviewHeight,
      width: widget.imagePreviewWidth,
      color: RPColors.textFieldBackground,
      child: Center(
        child: Icon(Icons.image_not_supported, color: RPColors.textFieldPlaceholder),
      ),
    );
  }

  Widget _getImageWidget() {
    if (_image != null) {
      if (widget.rounded == true) {
        return ClipOval(
          child: _withImage(),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(RPSize.cornerRadius), // Corner radius
          child: _withImage(),
        );
      }
    } else if (widget.initialGambar != null) {
      if (widget.rounded == true) {
        return ClipOval(
          child: _withInitialImage(),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(RPSize.cornerRadius), // Corner radius
          child: _withInitialImage(),
        );
      }
    } else {
      if (widget.rounded == true) {
        return ClipOval(
          child: _withoutImage(),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(RPSize.cornerRadius),
          child: _withoutImage(),
        );
      }
    }
  }

  void _showPickImageDialog() {
    RPBottomSheet(
      context: context,
      widgets: [
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('Ambil dari kamera'),
          onTap: () {
            Navigator.pop(context);
            _pickImage(ImageSource.camera);
          },
        ),
        ListTile(
          leading: Icon(Icons.image),
          title: Text('Pilih dari galeri'),
          onTap: () {
            Navigator.pop(context);
            _pickImage(ImageSource.gallery);
          },
        ),
      ],
    ).show();
  }
}
