import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sporta/shared/styles/colors.dart';

Widget defaultButton({
  required Size size,
  Color? formFieldColor,
  Color? textColor,
  required Function onPressed,
  required String text,
  double height = 50,
  double width = 150,
  double? fontSize,
}) =>
    Container(
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width / 2.0),
      ),
      child: MaterialButton(
        color: formFieldColor ?? defaultColor,
        onPressed: () {
          onPressed();
        },
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize ?? size.height / 30.0,
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  required String hint,
  IconData? prefixIcon,
  required BuildContext context,
  required TextInputType type,
  required Function validator,
  required TextEditingController controller,
  bool isPassword = false,
  IconButton? suffixIcon,
  Function? onChange,
  Function? onSubmit,
  Color enabledBorder = Colors.white,
  bool readOnly = false,
}) =>
    Container(
      // height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blueGrey.withOpacity(0.1),
      ),
      child: TextFormField(
        textAlign: TextAlign.start,
        onFieldSubmitted: (s) {
          onSubmit!(s);
        },
        onChanged: (s) {
          onChange!(s);
        },
        controller: controller,
        validator: (value) {
          validator(value);
        },
        keyboardType: type,
        obscureText: isPassword,
        readOnly: readOnly,
        style: TextStyle(
          textBaseline: TextBaseline.alphabetic,
          color: defaultColor,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold,
        ),
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          hintTextDirection: TextDirection.rtl,
          suffix: suffixIcon,
          contentPadding: EdgeInsets.all(
            (MediaQuery.of(context).size.width) / 50.0,
          ),
          isCollapsed: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: enabledBorder,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: defaultColor,
              width: 1,
            ),
          ),
          prefixIcon: Icon(
            prefixIcon,
          ),
          labelText: hint,
        ),
      ),
    );

Card defaultLoading({
  required BuildContext context,
}) =>
    Card(
      child: Padding(
        padding: EdgeInsets.all(
          (MediaQuery.of(context).size.height) / 40.0,
        ),
        child: const CircularProgressIndicator(),
      ),
      elevation: 5,
    );
