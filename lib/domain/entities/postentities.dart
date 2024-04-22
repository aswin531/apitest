class PostModel {
  String? title;
  String? body;
  int? userId;
  int? id;

  PostModel({
    this.title,
    this.body,
    this.userId,
    this.id,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      title: json['title'] as String,
      body: json['body'] as String,
      id: json['id'] ,
      userId: json['userId'] ,
    );
  }
}
