class Comics {
  String? title;
  String? description;
  String? latestChapter;
  String? thumbnail;
  String? param;
  String? detailUrl;

  Comics(
      {this.title,
      this.description,
      this.latestChapter,
      this.thumbnail,
      this.param,
      this.detailUrl});

  Comics.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    latestChapter = json['latest_chapter'];
    thumbnail = json['thumbnail'];
    param = json['param'];
    detailUrl = json['detail_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['latest_chapter'] = this.latestChapter;
    data['thumbnail'] = this.thumbnail;
    data['param'] = this.param;
    data['detail_url'] = this.detailUrl;
    return data;
  }
}
