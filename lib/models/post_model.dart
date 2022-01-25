class PostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? postImage;
  String? text;
  bool? isTrainee;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.postImage,
    this.text,
    this.isTrainee,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    text = json['text'];
    isTrainee = json['isTrainee'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
      'text': text,
      'isTrainee': isTrainee,
    };
  }
}
