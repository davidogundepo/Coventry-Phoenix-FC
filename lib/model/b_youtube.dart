class YouTube {
  String? toastName;
  String? yid;
  dynamic id;

  YouTube.fromMap(Map<String?, dynamic> data) {
    toastName = data['toast_name'];
    yid = data['yid'];
    id = data['id'];
  }
}
