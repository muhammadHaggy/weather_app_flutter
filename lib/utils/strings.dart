class Strings {
  static String toTitleCase(String str) {
    return str
        .split(" ")
        .map((char) => char[0].toUpperCase() + char.substring(1))
        .join(" ");
  }
}
