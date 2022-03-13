import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle bigtextStyle() {
  return GoogleFonts.montserrat(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
}

Widget appTextField(
  TextEditingController controller,
  String initialValue,
  String labelText,
  String hintText,
  void Function(String) onsaved,
  bool enabled,
  String Function(String) validator,
  TextStyle style,
  bool obscureText,
  bool autoValidate,
  bool enableSuggestions,
  TextInputType keyboardType,
  List<TextInputFormatter> inputFormatters,
  Widget suffix,
  Widget prefix,
  double textfieldBorder,
) {
  return TextFormField(
    controller: controller,
    initialValue: initialValue,
    onSaved: onsaved,
    enabled: enabled,
    validator: validator,
    obscureText: obscureText,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    autovalidate: autoValidate,
    enableSuggestions: enableSuggestions,
    style: style,
    cursorColor: Colors.green,
    decoration: InputDecoration(
      fillColor: Color(0xFFFFFFFFF),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
      hintText: hintText,
      hintStyle: TextStyle(fontSize: ScreenUtil().setSp(11)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Color(0xFFD8D8DF), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Color(0xFFD8D8DF), width: 1),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFFD8D8DF), width: 1)),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Container(child: prefix),
      ),
      prefixIconConstraints: BoxConstraints(maxHeight: 20.0),
      suffix: suffix,
    ),
  );
}
