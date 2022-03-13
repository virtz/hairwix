import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hairmarket/providers/userProvider.dart';
import 'package:hairmarket/utils/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
  String username;
  String password;
  String usertype;
  String fullname;
  String phone;
  String email;
  String profilepic;

  EditProfile(
      {this.username,
      this.fullname,
      this.password,
      this.usertype,
      this.phone,
      this.profilepic,
      this.email});
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();

  bool autoValidate = false;
  File _image;
  String imageS;

  @override
  void initState() {
    // getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(50),
            ),
            Align(
              child: CircleAvatar(
                radius: 72,
                backgroundColor: Colors.lightGreenAccent,
                child: CircleAvatar(
                  backgroundImage: _image != null?FileImage(_image):null,
                  radius: 70,
                 
                ),
              ),
            ),
            FlatButton(
              child: Text('Edit profile picture',
                  style: GoogleFonts.montserrat(
                    fontSize: 13.0,
                  )),
              onPressed: () {
                _showPicker(context);
              },
            ),
            SizedBox(height: ScreenUtil().setHeight(50)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                  autovalidate: autoValidate,
                  key: formKey,
                  child: Column(
                    children: [
                      appTextField(
                          null,
                          widget.username,
                          null,
                          null,
                          (val) => widget.username = val,
                          !userProvider.isLoading(), (value) {
                        if (value.isEmpty) {
                          return 'Please enter new username';
                        }

                        return null;
                      },
                          TextStyle(fontSize: ScreenUtil().setSp(14)),
                          false,
                          autoValidate,
                          false,
                          TextInputType.text,
                          null,
                          null,
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Container(
                                  child: SvgPicture.asset(
                                      'assets/images/user.svg'))),
                          null),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      appTextField(
                          null,
                          widget.fullname,
                          null,
                          null,
                          (val) => widget.fullname = val,
                          !userProvider.isLoading(), (value) {
                        if (value.isEmpty) {
                          return 'Please enter new fullname';
                        }

                        return null;
                      },
                          TextStyle(fontSize: ScreenUtil().setSp(14)),
                          false,
                          autoValidate,
                          false,
                          TextInputType.text,
                          null,
                          null,
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Container(
                                  child: SvgPicture.asset(
                                      'assets/images/user-check.svg'))),
                          null),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      appTextField(
                          null,
                          widget.email,
                          null,
                          null,
                          (val) => widget.email = val,
                          !userProvider.isLoading(), (value) {
                        if (value.isEmpty) {
                          return 'Please enter new fullname';
                        }

                        return null;
                      },
                          TextStyle(fontSize: ScreenUtil().setSp(14)),
                          false,
                          autoValidate,
                          false,
                          TextInputType.text,
                          null,
                          null,
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Container(
                                  child: SvgPicture.asset(
                                      'assets/images/mail.svg'))),
                          null),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      appTextField(
                          null,
                          widget.phone,
                          null,
                          null,
                          (val) => widget.phone = val,
                          !userProvider.isLoading(), (value) {
                        if (value.isEmpty) {
                          return 'Please enter new fullname';
                        }

                        return null;
                      },
                          TextStyle(fontSize: ScreenUtil().setSp(14)),
                          false,
                          autoValidate,
                          false,
                          TextInputType.text,
                          null,
                          null,
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Container(
                                  child: SvgPicture.asset(
                                      'assets/images/phone.svg'))),
                          null),
                      SizedBox(height: ScreenUtil().setHeight(40)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: MaterialButton(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            height: ScreenUtil().setHeight(50),
                            onPressed: _submit,
                            color: Colors.green,
                            child: Center(
                                child: userProvider.isLoading()
                                    ? CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        strokeWidth: 2)
                                    : Text('Save Changes',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                ScreenUtil().setSp(15))))),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _submit() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final form = formKey.currentState;
    if (form.validate()) {
      // userProvider.setLoading(true);
      form.save();
      var imageFilename = "UserAvatar" + DateTime.now().toString();

      final StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(imageFilename);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      if (uploadTask.isComplete) {
       widget.profilepic = downloadUrl.toString();
      }
      // print(widget.profilepic);
      await userProvider
          .updateProfile(widget.username, widget.password, widget.usertype,
              widget.fullname, widget.phone, widget.email, widget.profilepic)
          .catchError((e) {});
      if (userProvider.message == "Profile updated successfully") {
        Navigator.of(context).pop();
      } else if (userProvider.message == null) {
        setState(() {
          userProvider.errorMessage = "Sorry an error occurred";
        });
        userProvider.getErrorMessage();
        // _showCupertinoDialog(context);
      } else {
        userProvider.getErrorMessage();
        _showCupertinoDialog(context);
      }
    } else {
      setState(() {
        autoValidate = true;
      });
    }
  }

  _showCupertinoDialog(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => CupertinoAlertDialog(
              title: new Text(
                "Error",
                style: TextStyle(color: Colors.red),
              ),
              content: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Consumer<UserProvider>(
                    builder: (context, userProvider, _) {
                      return Text(userProvider.getErrorMessage());
                    },
                  )),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
