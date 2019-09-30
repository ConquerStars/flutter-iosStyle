// import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/service/custDio_config.dart';

void checkVersion(Function(CheckVersionData res) success, Function fail) async {
  try {
    final res = await custDio.get<Map>('http://10.168.1.107:8000/version.json');
    print('-----------getHttpService catch Respond ==== Start');
    // print(res);
    success(CheckVersionData.fromJson(res.data));
    print('-----------getHttpService catch Respond ==== End');
  } catch (e) {
    print('-----------getHttpService catch Error ==== Start');
    debugPrint(e.toString());
    fail();
    print('-----------getHttpService catch Error ==== End');
  }
}
class CheckVersionData {
  String version;
  String description;
  DateTime date;
  bool isnecessary;
  dynamic data;

  CheckVersionData({this.version, this.description, this.date, this.isnecessary, this.data});

  CheckVersionData.fromJson(Map<String, dynamic> json) {
    this.version = json['version'];
    this.description = json['description'];
    this.date = DateTime.fromMillisecondsSinceEpoch(json['date']);
    this.isnecessary = json['isnecessary'];
    this.data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['description'] = this.description;
    data['date'] = this.date;
    data['isnecessary'] = this.isnecessary;
    data['data'] = this.data;
    return data;
  }
}