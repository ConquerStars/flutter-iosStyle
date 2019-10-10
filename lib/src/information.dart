import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/service/information_service.dart';
import 'package:flutter_demo/utils/toast.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_demo/service/update_service.dart';

class TabInformation extends StatelessWidget {

  //是否有存储权限
  Future<bool> checkPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([
      // PermissionGroup.location,
      // PermissionGroup.camera,
      PermissionGroup.storage
    ]);
    //校验权限
    // if(permissions[PermissionGroup.camera] != PermissionStatus.granted){
    //   print('无照相权限);
    // }
    // if(permissions[PermissionGroup.location] != PermissionStatus.granted){
    //   print('无定位权限);
    // }
    return permissions[PermissionGroup.storage] != PermissionStatus.granted ? false : true;
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey containerKey = GlobalKey();
    final size = MediaQuery.of(context).size;
    String taskId;
    return ListView(
      key: containerKey,
      children: <Widget>[
        Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0x22000000), style: BorderStyle.solid)
            )
          ),
          child: Center(
            child: CircleAvatar(
              backgroundImage: AssetImage('lib/assets/img/xingba.jpg'),
              radius: 50,
            ),
          ),
        ),
        FlatButton(
          child: Text('checkSize'),
          onPressed: ()async{
            print(size.height);
            print(size.width);
            print(containerKey.currentContext.size.height);
            print(containerKey.currentContext.size.width);
          },
        ),
        FlatButton(
          child: Text('checkVersion'),
          onPressed: ()async{
            // 安装包信息
            await PackageInfo.fromPlatform().then((PackageInfo res) {
              print('++++++++++++++++++PackageInfo++++++++++++++++++++++');
              print(res.appName);
              print(res.packageName);
              print(res.version);
              print(res.buildNumber);
              print('++++++++++++++++++PackageInfo++++++++++++++++++++++');
              // 检查版本是否有更新
              checkVersion((CheckVersionData checkVersionData){
                print('----------success-----------');
                print(checkVersionData.version);
                if(checkVersionData.version != res.version){
                  print('版本号有变');
                  showCupertinoDialog(
                    context: context,
                    builder: (ctx) {
                      return CupertinoAlertDialog(
                        title: Text('发现新版本 v${checkVersionData.version}'),
                        content: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            checkVersionData.description,
                            textAlign: TextAlign.left,
                            maxLines: 8,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(height: 1.6)
                          ),
                        ),
                        actions:checkVersionData.isnecessary?<Widget>[
                          CupertinoDialogAction(
                            child: Text('立即更新'),
                            onPressed: (){
                              Navigator.maybePop(ctx);
                            },
                          ),
                        ]:<Widget>[
                          CupertinoDialogAction(
                            child: Text('稍后再说', style: TextStyle(color: Colors.grey)),
                            onPressed: (){
                              Navigator.maybePop(ctx);
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text('立即更新'),
                            onPressed: (){
                              print('taskId_--_--_--_--_--');
                              print(taskId);
                              print('taskId_--_--_--_--_--');
                              UpdateService().executeDownload(checkVersionData.data).then((id){
                                taskId = id;
                              });
                              Navigator.maybePop(ctx);
                              Toast.show('正在为您下载新版本...', ctx);
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showCupertinoDialog(
                    context: context,
                    builder: (ctx){
                      return CupertinoAlertDialog(
                        content: Text('已经是最新的了'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('知道了'),
                            onPressed: (){
                              Navigator.maybePop(ctx);
                            },
                          ),
                        ]
                      );
                    }
                  );
                }
              }, (){
                showCupertinoDialog(
                  context: context,
                  builder: (ctx){
                    return CupertinoAlertDialog(
                      content: Text('网络好像出了点问题'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text('知道了'),
                          onPressed: (){
                            Navigator.maybePop(ctx);
                          },
                        ),
                      ]
                    );
                  }
                );
              });
            });
          },
        ),
        FlatButton(
          child: Text('checkPermission'),
          onPressed: ()async{
            // 检查权限
            bool flag = await checkPermission();
            Toast.show(flag?'可使用存储权限':'没有使用存储权限', context);
          },
        ),
        FlatButton(
          child: Text('downloadTaskCancel'),
          onPressed: (){
            UpdateService().cancelDownload(taskId);
            Toast.show('取消当前下载任务', context);
          },
        ),
        FlatButton(
          child: Text('allDownloadTaskCancel'),
          onPressed: (){
            UpdateService().cancelAllDownload();
            Toast.show('取消全部下载任务', context);
          },
        ),
      ]
    );
  }
}