import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/service/information_service.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';

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
    return Column(
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
        Expanded(
          child: ListView(
            children: <Widget>[
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
                    String appName = res.appName;
                    String packageName = res.packageName;
                    String version = res.version;
                    String buildNumber = res.buildNumber;
                    print('++++++++++++++++++PackageInfo++++++++++++++++++++++');
                    print(appName);
                    print(packageName);
                    print(version);
                    print(buildNumber);
                    print('++++++++++++++++++PackageInfo++++++++++++++++++++++');
                    // 检查版本是否有更新
                    checkVersion((CheckVersionData res){
                      print('----------success-----------');
                      print(res.version);
                      if(res.version != version){
                        print('版本号有变');
                      }
                    }, (){
                      print('fail');
                    });
                  });
                },
              ),
              FlatButton(
                child: Text('checkPermission'),
                onPressed: ()async{
                  // 检查权限
                  bool flag = await checkPermission();
                  print(flag?'可使用存储权限':'无权限');
                },
              ),
            ],
          ),
        )
      ]
    );
  }
}