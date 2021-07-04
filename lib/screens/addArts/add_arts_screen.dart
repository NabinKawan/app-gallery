import 'dart:io';

import 'package:art_manager/components/form_errors.dart';
import 'package:art_manager/config/size_config.dart';
import 'package:art_manager/database/db_operation.dart';
import 'package:art_manager/models/art.dart';
import 'package:art_manager/models/art_operation.dart';
import 'package:art_manager/themes.dart';
import 'package:art_manager/validation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class AddArtsScreen extends StatefulWidget {
  // routeName of AddArts
  static String routeName = '/addArts';
  @override
  _AddArtsScreenState createState() => _AddArtsScreenState();
}

class _AddArtsScreenState extends State<AddArtsScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DbOperation _dbOp = ArtOperation();
  List<String> errors = [];
  File _image;
  String _artName;
  String _description;
  String _imagePath;
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: buildAppBar(context, "Add Art"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        width: double.infinity,
        child: KeyboardAvoider(
          autoScroll: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100 / 6.04 * SizeConfig.heightMultiplier,
              ),
              _buildForm(),
              SizedBox(height: 10 / 6.04 * SizeConfig.heightMultiplier),
              FormErrors(
                errors: errors,
              ),
              SizedBox(height: 30 / 6.04 * SizeConfig.textMultiplier),
              _buildButton(),
              SizedBox(
                height: 20 / 6.04 * SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: TextFormField(
                autofocus: true,
                textAlignVertical: TextAlignVertical.center,
                style: buildFormTextStyle(),
                keyboardType: TextInputType.name,
                cursorColor: kprimaryColor,
                decoration: buildFormDecoration(
                    labelText: "Art Name", hintText: "Enter art name"),
                onSaved: (newValue) => _artName = newValue,
                onChanged: (value) {
                  if (value.isNotEmpty && errors.contains(kNameNullError)) {
                    setState(() {
                      errors.remove(kNameNullError);
                    });
                  }
                  _artName = value;
                  return null;
                },
                validator: (value) {
                  if (value.isEmpty && !errors.contains(kNameNullError)) {
                    setState(() {
                      errors.add(kNameNullError);
                    });
                  }

                  return null;
                },
              ),
            ),
            SizedBox(
              height: 15 / 6.04 * SizeConfig.heightMultiplier,
            ),
            Container(
              width: double.infinity,
              child: TextFormField(
                autofocus: true,
                textAlignVertical: TextAlignVertical.center,
                style: buildFormTextStyle(),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: kprimaryColor,
                decoration: buildFormDecoration(
                    labelText: "Description",
                    hintText: "Enter art description"),
                onChanged: (value) {
                  _description = value;
                },
              ),
            ),
            SizedBox(
              height: 15 / 6.04 * SizeConfig.heightMultiplier,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      child: Text(
                        _imagePath == null ? "Select image" : _imagePath,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: kfontFamily,
                            color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.image_outlined),
                    onPressed: () async {
                      // ignore: invalid_use_of_visible_for_testing_member
                      PickedFile pickedImage = await ImagePicker.platform
                          .pickImage(source: ImageSource.gallery);
                      setState(() {
                        _image = File(pickedImage.path);
                        _imagePath = _image.path;
                        if (errors.contains(kImageNullError)) {
                          errors.remove(kImageNullError);
                        }
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _upload() async {
    Art art =
        Art(name: _artName, description: _description, imagePath: _imagePath);
    await _dbOp.add(art);
    setState(() {
      isUploading = false;
      Navigator.pop(context, art);
    });
  }

  Container _buildButton() {
    return Container(
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
          }

          if (_imagePath == null) {
            setState(() {
              if (!errors.contains(kImageNullError)) {
                errors.add(kImageNullError);
              }
            });
          }

          if (errors.isEmpty) {
            setState(() {
              isUploading = true;
              _upload();
            });
          }
        },
        style: ElevatedButton.styleFrom(
          primary: kprimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Center(
          child: isUploading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
              : Text('Save',
                  style: TextStyle(
                      color: Colors.white, fontSize: 15, letterSpacing: 0.2)),
        ),
      ),
    );
  }
}
