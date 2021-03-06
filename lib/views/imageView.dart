
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {
  final String imageUrl;

  ImageView({this.imageUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  var filepath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: widget.imageUrl,
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  )),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _save();
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 66,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.white60, width: 1),
                                borderRadius: BorderRadius.circular(30),
                              color: Color(0xff1c1b1b)
                                ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 66,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white60, width: 1),
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(colors: [
                                  Color(0x36ffffff),
                                  Color(0x0fffffff),
                                ])),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Set as Wallpaper",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Image will be saved in gallery",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .035,
                    ),
                    Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .06,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  _save() async {
     PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    var response = await Dio().get(widget.imageUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(permission);
    Navigator.pop(context);
  }

  /*_askPermission() async {
    /*if (Platform.isIOS) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
          .requestPermissions([PermissionGroup.photos]);
    } else {
      PermissionStatus permission = */
    await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    }*/

}
