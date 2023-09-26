import 'package:flutter/material.dart';

class AssetProvider extends StatelessWidget {
  final String asset;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  const AssetProvider(
      {Key? key,
      required this.asset,
      this.height,
      this.width,
      this.fit,
      this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      fit: fit,
      asset,
      color: color,
      height: height ?? 100,
      width: width ?? 100,
    );
  }
}
