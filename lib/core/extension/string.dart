extension StringExt on String {
  String get jpg => 'assets/images/$this.jpg';
  String get png => 'assets/images/$this.png';
  String get icon => 'assets/icons/$this.svg';
  String get json => 'assets/$this.json';

  // get the first letter of every word
  String get initials => isNotEmpty
      ? trim().split(RegExp(' +')).map((String s) => s[0]).join()
      : '';
}
