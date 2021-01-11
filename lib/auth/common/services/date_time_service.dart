class DateTimeService {
  /// Transform string like '31/12/2020' to date
  static DateTime transformDate(String s) {
    try {
      String d = s.substring(0, s.indexOf('/'));
      int id = int.parse(d);
      if (id < 1 || id > 31) throw Exception();
      String m = s.substring(s.indexOf('/') + 1, s.lastIndexOf('/'));
      int im = int.parse(m);
      if (im < 1 || im > 12) throw Exception();
      String y = s.substring(s.lastIndexOf('/') + 1);
      if (y.length != 4) throw Exception();
      int iy = int.parse(y);
      if (iy < 1900 && iy > 2020) throw Exception();
      if (im == 2 && id > 29) throw Exception();
      if (im == 4 && id > 30) throw Exception();
      if (im == 6 && id > 30) throw Exception();
      if (im == 9 && id > 30) throw Exception();
      if (im == 11 && id > 30) throw Exception();
      return DateTime(iy, im, id);
    } catch (e) {
      return null;
    }
  }

  static DateTime addYears(DateTime dt, int years) {
    return DateTime(dt.year + years, dt.month, dt.day);
  }
}
