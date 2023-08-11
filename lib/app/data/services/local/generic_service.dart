class GenericService {
  String encodeString(String s, int k) {
    String enc = "";
    String str = s.toString();

    //print("F -> $str");

    for (int i = 0; i < s.length; i++) {
      int a = s.codeUnitAt(i);
      int b = a ^ k;

      // print("a -> $a, b -> $b, k -> $k");
      enc = enc + String.fromCharCode(b);

//print("enc -> $enc");
    }

    return enc;
  }

  String cleanString(String st) {
    String r = st;

    r = r.replaceAll('ñ', 'n');
    r = r.replaceAll('Ñ', 'N');

    return r;
  }

  String replaceAll(String input, String str1, String str2, [String? ignore]) {
    RegExp regex = RegExp(
      RegExp.escape(str1).replaceAll(
          RegExp(r'([\/\,\!\\\^\$\{\}\[\]\(\)\.\*\+\?\|\<\>\-\&])'), r'\\$&'),
      caseSensitive: ignore != null ? !ignore.contains('i') : true,
      multiLine: ignore != null ? !ignore.contains('m') : false,
    );

    String replacedString = input.replaceAllMapped(regex, (match) {
      String replacement =
          (str2 is String) ? str2.replaceAll(r'$', r'$$') : str2;
      return replacement;
    });

    return replacedString;
  }
}
