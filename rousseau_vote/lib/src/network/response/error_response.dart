mixin ErrorResponse {
  List<String> errors;

  bool success() {
    return !hasErrors();
  }

  bool hasErrors() {
    return errors != null && errors.length > 0;
  }
}
