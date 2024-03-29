class AccountListChatResponse {
  String? id;
  String? timestamp;
  String? apiVersion;
  String? status;
  String? message;
  List<Data>? data;

  AccountListChatResponse(
      {this.id,
      this.timestamp,
      this.apiVersion,
      this.status,
      this.message,
      this.data});

  AccountListChatResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timestamp = json['timestamp'];
    apiVersion = json['apiVersion'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['timestamp'] = timestamp;
    data['apiVersion'] = apiVersion;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? fullname;
  String? email;
  String? username;
  String? password;
  String? phone;
  String? avatarUrl;

  Data(
      {this.id,
      this.fullname,
      this.email,
      this.username,
      this.password,
      this.phone,
      this.avatarUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    phone = json['phone'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    data['phone'] = phone;
    data['avatarUrl'] = avatarUrl;
    return data;
  }
}
