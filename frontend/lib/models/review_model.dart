class ReviewModel {
  final double score;
  final String comment, nickname;
  ReviewModel.fromJson(Map<String, dynamic> json)
      : score = json['score'],
        comment = json['comment'],
        nickname = json['nickname'];
}
