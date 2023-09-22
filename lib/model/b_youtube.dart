class Youtube {
  String? url;
  String? toastName;

  Youtube.fromMap(Map<String?, dynamic> data) {
    url = data['url'];
    toastName = data['toastname'];
  }
}
