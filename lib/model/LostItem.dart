class LostItem {
  String id;
  String images;
  String userId;
  String type;
  bool isFound;
  String foundId;
  String createdAt;
  String modifiedAt;
  Map<String, dynamic> toJson() => {
        'id': id,
        'images': images,
        'userId': userId,
        'type': type,
        'isFound': isFound,
        'foundId': foundId,
        'createdAt': createdAt,
        'modifiedAt': modifiedAt
      };
  LostItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        images = json['images'],
        userId = json['userId'],
        type = json['type'],
        isFound = json['isFound'],
        foundId = json['foundId'],
        createdAt = json['createdAt'],
        modifiedAt = json['modifiedAt'];
}
