
String idFromObject(Object object) {
  if (object is Map<String, Object> &&
      object.containsKey('id')) {
    return object['id'];
  }
  return null;
}