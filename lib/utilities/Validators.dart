class Validators {
  static String validateMobile(String value) {
    String patttern = r'(^\(?([0-9]{3})\)?[-.●]?([0-9]{3})[-.●]?([0-9]{4,5})$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Phone number is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Phone number is not valid (Minimum 10 digits)";
    }
    return null;
  }

  static String validateEmpty(String value) {
    if (value.trim().length == 0) return 'Cannot be empty';
  }
}
