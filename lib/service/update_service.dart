import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:install_plugin/install_plugin.dart';
///后台下载
class UpdateService{
  
  String taskId;
  /// 下载
  Future<String> executeDownload(String url) async {
    final path = await _apkLocalPath();

    //发起请求
    String taskId = await FlutterDownloader.enqueue(
        url: url,
        fileName: 'flutter_demo',
        savedDir: path,
        showNotification: true,
        openFileFromNotification: false);

    FlutterDownloader.registerCallback((id, status, progress) {
      //更新下载进度

      // 当下载完成时，调用安装
      if (taskId == id && status == DownloadTaskStatus.complete) {
        //安装下载完的apk
        _installApk();
      }
    });

    return taskId;
  }
  ///取消下载
  cancelDownload(taskId) async{
    if(taskId != null) {
      FlutterDownloader.cancel(taskId: taskId);
    }
  }
  ///取消全部下载
  cancelAllDownload(){
    FlutterDownloader.cancelAll();
  }

  /// 安装
  Future<Null> _installApk() async {
    try {
      final path = await _apkLocalPath();

      InstallPlugin.installApk(path + '/flutter_demo.apk', 'com.example.flutter_demo')
          .then((result) {
        print('install apk $result');
      }).catchError((error) {
        print('install apk error: $error');
      });
    } on PlatformException catch (_) {}
  }

  /// 获取存储路径
  Future<String> _apkLocalPath() async {
    //获取根目录地址
    final dir = await getExternalStorageDirectory();
    //自定义目录路径(可多级)
    String path = dir.path+'/appUpdateDemo';
    var directory = await Directory(path).create(recursive: true);
    return directory.path;
  }
}