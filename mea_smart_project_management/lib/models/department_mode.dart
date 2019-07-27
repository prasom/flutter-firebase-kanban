class Department {
  final String key;
  String value;

  Department.fromJson(this.key, Map data) {
    value = data['name'];
    if (value == null) {
      value = '';
    }
  }
}