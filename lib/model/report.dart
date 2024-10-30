class Report {
  int? newsId;
  String? reason;
  String? description;

  Report(
      {this.newsId,
      this.reason,
      this.description});

  Report.fromJson(Map<String, dynamic> json) {
    newsId = json['newsId'];
    reason = json['reason'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newsId'] = newsId;
    data['reason'] = reason;
    data['description'] = description;
    return data;
  }
}
