class ReviewModel {
  final double score;
  final String comment, nickname;
  final int id;
  ReviewModel.fromJson(Map<String, dynamic> json)
      : score = json['score'],
        comment = json['comment'],
        nickname = json['nickname'],
        id = json['reviewId'];
}
