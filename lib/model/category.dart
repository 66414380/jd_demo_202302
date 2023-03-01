class Category {
  late String areaName;
  late List<Level1words> level1words;

  Category.fromJson(Map<String, dynamic> json) {
    areaName = json['areaName'];
    if (json['level1words'] != null) {
      level1words = <Level1words>[];
      json['level1words'].forEach((v) {
        level1words.add(Level1words.fromJson(v));
      });
    }
  }
}

class Level1words {
  late String keyword;
  late List<Level2words> level2words;

  Level1words.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
    if (json['level2words'] != null) {
      level2words = <Level2words>[];
      json['level2words'].forEach((v) {
        level2words.add( Level2words.fromJson(v));
      });
    }
  }
}

class Level2words {
  late String keyword;
  late String imageUrl;
  late String url;

  Level2words.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
    imageUrl = json['imageUrl'];
    url = json['url'];
  }
}