import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walli/model/wallpaper_Model.dart';
import 'package:walli/views/imageView.dart';

Widget wallPapersList(List<wallpaperModel> wallpapers, context) {
  return Expanded(
    child: Container(
      color: Colors.grey.withOpacity(0.1),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.58,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: wallpapers.map((wallpaper) {
  if (wallpapers.length != null){
          return GridTile(
              child: GestureDetector(
              onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){return ImageView(imageUrl: wallpaper.src.portrait,);}));
          },
          child: Hero(
          tag: wallpaper.src.portrait,
          child: Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  wallpaper.src.portrait,
                  fit: BoxFit.cover,
                )),
          ))));}
  else {
    return Text("No images found");
  }
        }).toList(),
      ),
    ),
  );
}
