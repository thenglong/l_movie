import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NetworkImageWrapper extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final BoxFit fit;
  final double placeholderSpinnerSize;
  final Color? placeholderSpinnerColor;

  const NetworkImageWrapper({
    Key? key,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
    this.height = double.infinity,
    this.placeholderSpinnerSize = 18.0,
    this.placeholderSpinnerColor,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => Center(
        child: SpinKitThreeBounce(
          color: placeholderSpinnerColor ?? Theme.of(context).hintColor,
          size: placeholderSpinnerSize,
        ),
      ),
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorWidget: (context, url, err) => Container(),
    );
  }
}
