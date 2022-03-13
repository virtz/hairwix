import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hairmarket/providers/orderServiceProvider.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  final int serviceid;
  final String servicename;

  const Order({Key key, this.serviceid, this.servicename}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final formKey = GlobalKey<FormState>();
  String description;
  String password;
  String error;
  bool autoValidate = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> sf = GlobalKey<ScaffoldState>();

    _submit() async {
      final orderServiceProvider =
          Provider.of<OrderServiceProvider>(context, listen: false);
      final form = formKey.currentState;
      if (form.validate()) {
        orderServiceProvider.setLoading(true);
        form.save();
        await orderServiceProvider
            .orderService(description, widget.serviceid)
            .catchError((e) {
          setState(() {
            error = orderServiceProvider.errorMessage;
          });
        });
        // orderServiceProvider.setLoading(false);
        if (orderServiceProvider.getMessage() == "Success") {
          Flushbar(
            flushbarStyle: FlushbarStyle.FLOATING,
            titleText:Text('Success',style:GoogleFonts.montserrat(
                                      fontSize: 15.0, color: Colors.blue)),
            messageText: Text("Your order was successful",style:GoogleFonts.montserrat(
                                      fontSize: 14.0, color: Colors.blue)),
            duration: Duration(seconds:6),
          )..show(context);
          // Navigator.of(context).pop();
        } else {
          orderServiceProvider.getErrorMessage();
          _showCupertinoDialog(context);
        }
      } else {
        print('form didnt validate');
        setState(() {
          autoValidate = true;
        });
      }
    }

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);
    var size = MediaQuery.of(context).size;

    return Scaffold(
        key: sf,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.servicename,
              style: GoogleFonts.montserrat(fontSize: 15.0, color: Colors.black
                  // color:Colors.grey,
                  )),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().setHeight(40)),
              Form(
                autovalidate: autoValidate,
                key: formKey,
                child: Consumer<OrderServiceProvider>(
                    builder: (context, orderServiceProvider, _) {
                  return Column(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(ScreenUtil.defaultWidth),
                        // height: ScreenUtil().setHeight(defaultScreenHeight-270),
                        // height: size.height <= 1000 ? 400 : 200,

                        child: TextFormField(
                            onSaved: (val) => description = val,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Sorry, this field can not be blank";
                              }
                              return null;
                            },
                            enabled: !orderServiceProvider.isLoading(),
                            maxLength: 1000,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            autocorrect: true,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: ScreenUtil().setSp(15.0),
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "Describe how you'll like our service rendered to you")),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(30)),
                      Container(
                        height: ScreenUtil().setHeight(50),
                        width: size.width,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.green,
                          onPressed: _submit,
                          child: orderServiceProvider.isLoading()
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.white, strokeWidth: 2)
                              : Text('Complete Order',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15.0, color: Colors.white)),
                        ),
                      )
                    ],
                  );
                }),
              )
            ],
          ),
        ));
  }

  _showCupertinoDialog(BuildContext context) {
    Provider.of<OrderServiceProvider>(context, listen: false);
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
                  child: Consumer<OrderServiceProvider>(
                    builder: (context, orderServiceProvider, _) {
                      // print(orderServiceProvider.getErrorMessage());
                      return Text(orderServiceProvider.getErrorMessage());
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
