import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hairmarket/pages/index.dart';
import 'package:hairmarket/pages/registerScreens/sign_up.dart';
import 'package:hairmarket/providers/userProvider.dart';
import 'package:hairmarket/utils/widgets.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String username;
  String password;
  String error;
  bool autoValidate = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false);

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
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Consumer<UserProvider>(builder: (context, userProvider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtil().setHeight(60)),
                  Text('Welcome,',
                      style: TextStyle(
                          color: Color(0xFF2A3A64),
                          fontSize: ScreenUtil().setSp(22),
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: ScreenUtil().setHeight(7)),
                  Text(
                    'Login to continue ',
                    style: TextStyle(
                      color: Color(0xFF2A3A64),
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(50)),
                  Form(
                      autovalidate: autoValidate,
                     key: formKey,
                      child: Column(
                        children: [
                          appTextField(
                              null,
                              null,
                              null,
                              'E.g plumber22',
                              (val) => username = val,
                              !userProvider.isLoading(), (value) {
                            if (value.isEmpty) {
                              return 'Please enter username';
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
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Container(
                                      child: SvgPicture.asset(
                                          'assets/images/user.svg'))),
                              null),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          appTextField(
                              null,
                              null,
                              null,
                              'Password',
                              (val) => password = val,
                              !userProvider.isLoading(), (value) {
                            if (value.isEmpty || value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                              TextStyle(fontSize: ScreenUtil().setSp(14)),
                              obscureText,
                              false,
                              false,
                              TextInputType.text,
                              null,
                              GestureDetector(
                                  onTap: _toggle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      obscureText ? "Show" : "Hide",
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Container(
                                    child: SvgPicture.asset(
                                        'assets/images/lock.svg')),
                              ),
                              null),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text("Forgot Password ?",
                                  style: TextStyle(
                                    color: Color(0xFF7B8295),
                                    fontSize: ScreenUtil().setSp(11),
                                  ))),
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
                                        : Text('Login',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    ScreenUtil().setSp(14))))),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignUp()));
                            },
                            child: RichText(
                                text: TextSpan(
                                    text: "Don't have an account ?",
                                    style: TextStyle(color: Color(0xFF687593)),
                                    children: <TextSpan>[
                                  TextSpan(
                                      text: ' Sign up',
                                      style: TextStyle(fontSize: 14))
                                ])),
                          ),
                        ],
                      ))
                ],
              );
            })));
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  _submit() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final form = formKey.currentState;
    if (form.validate()) {
      userProvider.setLoading(true);
      form.save();
          await userProvider.login(username, password).catchError((e) {
        setState(() {
          error = userProvider.errorMessage;
        });
      });
      if (userProvider.getMessage() == "Success") {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Index()));
      } else {
        userProvider.getErrorMessage();
        _showCupertinoDialog(context);
      }
    } else {
      print('form didnt validate');
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
                      return Text(userProvider.errorMessage);
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
