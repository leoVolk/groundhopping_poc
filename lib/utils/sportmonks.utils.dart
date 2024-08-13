class SportMonksUtils {
  static bool checkIfGameIsCurrent(DateTime startAt) {
    var res = DateTime.now().isAfter(startAt) &&
        DateTime.now().isBefore(startAt.add(Duration(minutes: 90)));
    return res;
  }
}
