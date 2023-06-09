class Details {
  String? title;
  String? thumbnail;
  List<String>? genre;
  String? synopsis;
  List<Chapters>? chapters;

  Details(
      {this.title, this.thumbnail, this.genre, this.synopsis, this.chapters});

  Details.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnail = json['thumbnail'];
    genre = json['genre'].cast<String>();
    synopsis = json['synopsis'];
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['genre'] = this.genre;
    data['synopsis'] = this.synopsis;
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapters {
  String? chapter;
  String? param;
  String? release;
  String? detailUrl;

  Chapters({this.chapter, this.param, this.release, this.detailUrl});

  Chapters.fromJson(Map<String, dynamic> json) {
    chapter = json['chapter'];
    param = json['param'];
    release = json['release'];
    detailUrl = json['detail_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter'] = this.chapter;
    data['param'] = this.param;
    data['release'] = this.release;
    data['detail_url'] = this.detailUrl;
    return data;
  }
}
