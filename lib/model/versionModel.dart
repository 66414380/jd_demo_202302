class VersionModel {
  late String version;
  late bool mandatory;
  late List<String> updateContent;
  late Uri iosAddress;
  late String androidAddress;

  VersionModel.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    mandatory = json['mandatory'];
    updateContent = List.from(json['updateContent']);
    iosAddress = Uri.https(json['iosAddress1'], json['iosAddress2']);
    androidAddress = json['androidAddress'];
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'mandatory': mandatory,
      'updateContent': updateContent,
      'iosAddress': iosAddress,
      'androidAddress': androidAddress,
    };
  }
}

/**
 * version在pubspec.yaml version: 1.0.0+1 修改
 * {
    "version": "1.0.1",
    "mandatory": false,
    "updateContent": ["1、修复了一些显示问题", "2、新增搜索页面", "3、项目管理可切换成员搜索", "4、项目过期显示橙色"],
    "iosAddress1": "apps.apple.com",
    "iosAddress2": "/cn/app/tasktodo/id1498326734",
    "androidAddress": "http://192.168.0.105/app-release.apk"
    }
 */