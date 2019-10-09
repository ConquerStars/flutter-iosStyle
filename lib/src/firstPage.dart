
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/src/appBar.dart';
import 'package:flutter_demo/src/secondPage.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class FirstPage extends StatefulWidget {
  @override
  FirstPageState createState() => new FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  File _img;
  File _video;
  VideoPlayerController _controller;
  ChewieController _chewieController;
  Future getCameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _img = image;
    });
  }
  Future getGalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _img = image;
    });
  }
  Future getVideo() async {
    var video = await ImagePicker.pickVideo(source: ImageSource.camera);
    if(video != null){
      setState(() {
        _video = video;
      });
      _controller = VideoPlayerController.file(_video);
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true,
      );
    }
  }
  
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('https://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: Column(
        children: <Widget>[
          MyAppBar('FirstPage'),
          Expanded(
            child: ListView(
              children: <Widget>[
                // _img == null ? Text('未选择图片'):Image.file(_img),
                _img == null ? Text('未选择图片'):Image.asset('${_img.path}'),
                Chewie(controller: _chewieController,),
                CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: Text('goSecondPage',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                  onPressed: (){
                    _chewieController.pause();
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> SecondPage()));
                  },
                  pressedOpacity: 0.9,
                ),
                CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: Text('PickImageByCamera',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                  onPressed: getCameraImage,
                  pressedOpacity: 0.9,
                ),
                CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: Text('PickImageByGallery',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                  onPressed: getGalleryImage,
                  pressedOpacity: 0.9,
                ),
                CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: Text('PickVideo',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                  onPressed: (){
                    _chewieController.pause();
                    getVideo();
                  },
                  pressedOpacity: 0.9,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
    _controller.dispose();
    _video = null;
    _img = null;
  }
}

