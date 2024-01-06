// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class ModelChat {
  String? image;
  String? about;
  String? name;
  String? createdAt;
  String? id;
  bool? isOnline;
  String? lastActive;
  String? pushToken;
  String? email;

  ModelChat(
      {this.image,
      this.about,
      this.name,
      this.createdAt,
      this.id,
      this.isOnline,
      this.lastActive,
      this.pushToken,
      this.email});

  ModelChat.fromJson(Map<String, dynamic> json) {
    image = json['image'] ??"";
    about = json['about']??"";
    name = json['name']??"";
    createdAt = json['created_at']??"";
    id = json['id']??"";
    isOnline = json['is_online']??"";
    lastActive = json['last_active']??"";
    pushToken = json['push_token']??"";
    email = json['email']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['about'] = this.about;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['is_online'] = this.isOnline;
    data['last_active'] = this.lastActive;
    data['push_token'] = this.pushToken;
    data['email'] = this.email;
    return data;
  }

  toList() {}
}