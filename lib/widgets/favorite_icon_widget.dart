import 'package:flutter/material.dart';
import 'package:l_movie/theme/colors.dart';

class FavoriteIconWidget extends StatefulWidget {
  final void Function(bool isFavorite) onFavoriteChanged;
  final bool isFavorite;

  const FavoriteIconWidget({
    Key? key,
    required this.isFavorite,
    required this.onFavoriteChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIconWidget> {
  late bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: actionBarIconColor,
      ),
      onPressed: () {
        toggleFavorite();
      },
    );
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      widget.onFavoriteChanged(isFavorite);
    });
  }

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }
}
