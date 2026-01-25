extension ErrorMessage on Exception {
  String errorMessage() => toString().replaceFirst("Exception: ", "");
}
