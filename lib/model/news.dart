import 'package:ospace/model/publisher.dart';
import 'package:ospace/model/report.dart';

class LocalNews {
  int? id;
  String? title;
  String? content;
  String? coverImage;
  String? publisherUserName;
  String? publisherName;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Report?>? reports;
  Publisher? publisher;

  LocalNews(
      {this.id,
      this.title,
      this.content,
      this.coverImage,
      this.publisherUserName,
      this.publisherName,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.reports,
      this.publisher});

    LocalNews.fromLocalJson(Map<String, dynamic> json) {
      title = json['title'];
      content = json['content'];
      coverImage = json['coverImage'];
    }


    LocalNews.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      title = json['title'];
      content = json['content'];
      coverImage = json['coverImage'];
      publisherUserName = json['publisherUserName'];
      publisherName = json['publisherName'];
      status = json['status'];
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
      if (json['reports'] != null) {
        reports =[];
        json['reports'].forEach((v) {
          reports!.add(Report.fromJson(v));
        });
      }
      publisher = json['publisher'] != null
          ? Publisher.fromJson(json['publisher'])
          : null;
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = id;
      data['title'] = title;
      data['content'] = content;
      data['coverImage'] = coverImage;
      data['publisherUserName'] = publisherUserName;
      data['publisherName'] = publisherName;
      data['status'] = status;
      data['createdAt'] = createdAt;
      data['updatedAt'] = updatedAt;
      if (reports != null) {
        data['reports'] = reports!.map((v) => v!.toJson()).toList();
      }
      if (publisher != null) {
        data['publisher'] = publisher!.toJson();
      }
      return data;
      }
}
