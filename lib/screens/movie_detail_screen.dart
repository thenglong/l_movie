import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:l_movie/models/movie.dart';
import 'package:l_movie/theme/colors.dart';
import 'package:l_movie/widgets/favorite_icon_widget.dart';
import 'package:l_movie/widgets/logo.dart';
import 'package:l_movie/widgets/movie_info_view.dart';
import 'package:l_movie/widgets/screenshot_view.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: _createDetailBody(context),
      ),
      onWillPop: () async => true,
    );
  }

  Widget _createDetailBody(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Column(
                  children: [
                    _createDetailHeader(context),
                    MovieInfoView(movie: movie),
                    const Divider(height: 8.0, color: Colors.transparent),
                    ScreenshotView(
                      movieId: movie.id,
                      actionOpenImage: (img) {},
                      actionLoadAll: () {},
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        _createAppbar(context),
      ],
    );
  }

  Widget _createDetailHeader(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      height: width + 56.0,
      child: Stack(
        children: [
          ShapeOfView(
            shape: ArcShape(
              direction: ArcDirection.Outside,
              height: 48,
              position: ArcPosition.Bottom,
            ),
            height: width,
            elevation: 24.0,
            child: SizedBox(
              width: double.infinity,
              height: width,
              child: _createHeaderImage(context),
            ),
          ),
          _createHeaderAction(context),
        ],
      ),
    );
  }

  Widget _createAppbar(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        elevation: 0.0,
        titleSpacing: 4.0,
        backgroundColor: Colors.transparent,
        // title: Image.asset(
        //   'assets/images/ic_netflix.png',
        //   height: 56.0,
        //   fit: BoxFit.fitHeight,
        // ),
        title: const LMovieLogo(),
        centerTitle: true,
        leading: Container(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: actionBarIconColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: FavoriteIconWidget(
                isFavorite: false, onFavoriteChanged: (checked) {}),
          ),
        ],
      ),
    );
  }

  Widget _createHeaderImage(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: movie,
          child: CachedNetworkImage(
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.5, 0.7, 0.9],
              colors: [
                white20,
                white10,
                white05,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _createHeaderAction(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 16.0,
          bottom: 8.0,
          child: SizedBox(
            width: 64.0,
            height: 64.0,
            child: FittedBox(
              child: IconButton(
                icon: const Icon(Icons.add_rounded, color: actionBarIconColor),
                onPressed: () {},
              ),
            ),
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 8.0,
          child: SizedBox(
            width: 64.0,
            height: 64.0,
            child: FittedBox(
              child: IconButton(
                icon:
                    const Icon(Icons.share_outlined, color: actionBarIconColor),
                onPressed: () {},
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 0.0,
          right: 0.0,
          child: FractionalTranslation(
            translation: const Offset(0.0, -0.2),
            child: SizedBox(
              width: 72.0,
              height: 72.0,
              child: FittedBox(
                child: FloatingActionButton(
                  elevation: 10.0,
                  onPressed: () {},
                  backgroundColor: white,
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
