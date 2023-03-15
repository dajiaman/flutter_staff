class FeedItemModel {
  final int? id;
  final String? title;
  final String? author;
  final int? likes;
  final String? cover;
  final String? avatar;

  FeedItemModel(
      {this.id, this.title, this.author, this.likes, this.cover, this.avatar});

  factory FeedItemModel.fromJson(Map<String, dynamic> json) => FeedItemModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        author: json['author'] as String?,
        likes: json['likes'] as int?,
        cover: json['cover'] as String?,
        avatar: json['cover'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'likes': likes,
        'cover': likes,
        'avatar': likes,
      };
}
