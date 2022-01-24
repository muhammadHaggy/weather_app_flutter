class Strings {
  static String toTitleCase(String str) {
    return str.split(" ").map((char) => char.toUpperCase()).join(" ");
  }
}
