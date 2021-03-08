import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ShareFunc extends StatelessWidget {
  ImagePicker imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton(
            child: Text("Text Share"),
            onPressed: () async => await Share.share("https://홈페이지.com", subject: "공유 내용"),
          ),
          ElevatedButton(
            child: Text("Img Share"),
            onPressed: () async {
              PickedFile? f = await this.imagePicker.getImage(source: ImageSource.gallery);
              if(f == null) return;
              await Share.shareFiles(
                [f.path],
                subject: "이미지 내용",
                text: "이미지 텍스트",
                sharePositionOrigin:Rect.fromPoints(Offset.zero, Offset.zero)
              );
            }
          ),
          OutlinedButton(
            child: Text("Img\'s Share"),
            onPressed: () async {
              List<String> imgs = [];
              PickedFile? f = await this.imagePicker.getImage(source: ImageSource.gallery);
              if(f == null) return;
              imgs.add(f.path);
              bool check = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text("추가하시겠습니까?"),
                  actions: [
                    TextButton(
                      child: Text("네"),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                    TextButton(
                      child: Text("닫기"),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ],
                )
              ) ?? false;
              if(!check) return;
              PickedFile? f2 = await this.imagePicker.getImage(source: ImageSource.gallery);
              if(f2 == null) return;
              imgs.add(f2.path);
              await Share.shareFiles(
                  imgs,
                  subject: "이미지 내용들",
                  text: "이미지 텍스트들",
                  sharePositionOrigin:Rect.fromPoints(Offset.zero, Offset.zero)
              );
            }
          )
        ],
      ),
    );
  }
}
