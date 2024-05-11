class Model {
  String? title;
  String? subtitle;
  Model({required this.title, required this.subtitle});
  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(title: map["title"], subtitle: map["subtitle"]);
  }
  Map<String, dynamic> toMap() {
    return {"title": title, "subtitle": subtitle};
  }
}
