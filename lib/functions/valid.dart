String? validinput(String value, int min, int max, String type ){
  if (value.isEmpty) {
    return "لا يمكن أن يكون هذا الحقل فارغاً";
  }

  if (type == "username") {
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return "اسم المستخدم يجب أن يحتوي على أحرف وأرقام فقط";                             
    }
  }

  if (type == "email") {
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "يرجى إدخال بريد إلكتروني صحيح";
    }
  }

  if (value.length < min) {
    return "لا يمكن أن يكون أصغر من $min أحرف";
  }

  if (value.length > max) {
    return "لا يمكن أن يكون أكبر من $max أحرف";
  }
  
  return null; // تعني أن الإدخال صحيح


}