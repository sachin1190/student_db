import 'package:flutter/material.dart';
import 'Validators.dart';
import 'appConstants.dart';

Widget getTextFieldLarge(TextEditingController controller, String hinTxt) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextFormField(
      cursorColor: AppConstants.primaryCol,
      controller: controller,
      validator: (val) => Validators.validateEmpty(val),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          errorBorder: InputBorder.none,
          errorStyle: TextStyle(color: AppConstants.secondaryCol),
          focusedBorder: InputBorder.none,
          fillColor: AppConstants.secondaryCol,
          filled: true,
          hintText: hinTxt,
          focusColor: AppConstants.secondaryCol),
    ),
  );
}

Widget getPhoneField(TextEditingController controller, String hintTxt) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextFormField(
      cursorColor: AppConstants.primaryCol,
      controller: controller,
      validator: (val) => Validators.validateMobile(val),
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
          prefixText: '+91',
          errorBorder: InputBorder.none,
          errorStyle: TextStyle(color: AppConstants.secondaryCol),
          focusedBorder: InputBorder.none,
          fillColor: AppConstants.secondaryCol,
          filled: true,
          hintText: hintTxt,
          focusColor: AppConstants.secondaryCol),
    ),
  );
}

Widget getTextFieldSmall(TextEditingController controller, String hintTxt,
    TextInputType textInputType) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      width: 120,
      child: TextFormField(
        cursorColor: AppConstants.primaryCol,
        controller: controller,
        validator: (val) => Validators.validateEmpty(val),
        keyboardType: textInputType,
        decoration: InputDecoration(
            errorBorder: InputBorder.none,
            errorStyle: TextStyle(color: AppConstants.secondaryCol),
            focusedBorder: InputBorder.none,
            fillColor: AppConstants.secondaryCol,
            filled: true,
            hintText: hintTxt,
            focusColor: AppConstants.secondaryCol),
      ),
    ),
  );
}

Widget getPasswordField(TextEditingController controller, Function onTap,
    String hintTxt, bool obs) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextFormField(
      cursorColor: AppConstants.primaryCol,
      controller: controller,
      obscureText: obs,
      validator: (val) => Validators.validateEmpty(val),
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: AppConstants.primaryCol,
              ),
              onPressed: onTap),
          errorBorder: InputBorder.none,
          errorStyle: TextStyle(color: AppConstants.secondaryCol),
          focusedBorder: InputBorder.none,
          fillColor: AppConstants.secondaryCol,
          filled: true,
          hintText: 'Password',
          focusColor: AppConstants.secondaryCol),
    ),
  );
}
