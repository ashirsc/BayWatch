import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'constants.dart';
import 'dart:typed_data';

class SpotImage extends StatefulWidget {
  SpotImage({Key key}) : super(key: key);

  @override
  _SpotImageState createState() => _SpotImageState();
}

class _SpotImageState extends State<SpotImage>
    with SingleTickerProviderStateMixin {
  AnimationController rotationController;
  Widget carImage;

  void fetchSpotImage() async {
    print('gettign storage stuff');
    firebase_storage.Reference imagesRef =
        firebase_storage.FirebaseStorage.instance.ref('SpotPics/latest.jpeg');
    Uint8List data = await imagesRef.getData();

    setState(() {
      carImage = Image.memory(data);
    });
  }

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
        duration: const Duration(seconds: 500), vsync: this);
    carImage = RotationTransition(
        turns: Tween(begin: 0.0, end: 50.0).animate(rotationController),
        child: Padding(
          child: Image.asset('assets/icons/neptune.png'),
          padding: EdgeInsets.all(40),
        ));
    rotationController.forward(from: 0.0); // it starts the animation
    fetchSpotImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(28.0)),
            color: kColors["black1"],
            boxShadow: [BoxShadow()]),
        child: carImage);
  }
}
