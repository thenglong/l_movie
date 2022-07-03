import 'package:flutter/material.dart';
import 'package:l_movie/models/movie.dart';
import 'package:l_movie/screens/movie_detail_screen.dart';
import 'package:l_movie/theme/colors.dart';
import 'package:l_movie/widgets/custom_list_view.dart';
import 'package:l_movie/widgets/genre_view.dart';
import 'package:l_movie/widgets/logo.dart';
import 'package:l_movie/widgets/popular_view.dart';
import 'package:l_movie/widgets/slider_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeScreen>
    implements AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 4.0,
        backgroundColor: primaryColor,
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
            icon: const Icon(Icons.menu_rounded, color: actionBarIconColor),
            onPressed: () {
              print("Hello World");
            },
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.search, color: actionBarIconColor),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0.0,
      ),
      backgroundColor: backgroundColor,
      body: _createBody(context),
    );
  }

  Widget _createBody(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 6.0,
                ),
                SliderView(
                  actionOpenMovie: _openMovieDetail,
                ),
                const Divider(height: 16.0, color: Colors.transparent),
                GenreView(
                  actionOpenGenre: (genre) {
                    print(genre.name);
                    print(genre.id);
                  },
                ),
                const SizedBox(
                  height: 8.0,
                ),
                CustomListView(
                  actionOpenMovie: _openMovieDetail,
                  actionLoadAll: () {},
                ),
                const SizedBox(height: 8.0),
                PopularView(
                  actionOpenMovie: _openMovieDetail,
                  actionLoadAll: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openMovieDetail(Movie movie) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return MovieDetailScreen(movie: movie);
      }),
    );
  }

  @override
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;
}
