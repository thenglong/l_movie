import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_movie/blocs/blocs.dart';
import 'package:l_movie/blocs/movie_bloc/movie_event.dart';
import 'package:l_movie/blocs/movie_bloc/movie_state.dart';
import 'package:l_movie/repository/movie_repository_impl.dart';
import 'package:l_movie/theme/colors.dart';
import 'package:l_movie/widgets/favorite_icon_widget.dart';
import 'package:l_movie/widgets/logo.dart';
import 'package:l_movie/widgets/network_image_wrapper.dart';

class MovieListScreen extends StatelessWidget {
  final MovieEvent movieEvent;

  const MovieListScreen({Key? key, required this.movieEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: BlocProvider(
        create: (context) {
          return MovieBloc(MovieRepositoryImpl())
            ..add(
              movieEvent,
            );
        },
        child: Scaffold(
          appBar: AppBar(
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
          body: _createListBody(context),
        ),
      ),
      onWillPop: () async => true,
    );
  }

  Widget _createListBody(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieFetched) {
          return LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return GridView.builder(
                itemCount: state.movies.length, // TODO
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? 3
                      : 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: (2 / 1),
                ),
                itemBuilder: (
                  context,
                  index,
                ) {
                  final movie = state.movies[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigator.of(context)
                      //     .pushNamed(RouteName.GridViewCustom);
                    },
                    child: Card(
                      elevation: 0,
                      borderOnForeground: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Stack(
                          children: [
                            Hero(
                              tag: movie,
                              child: NetworkImageWrapper(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: double.infinity,
                              padding: const EdgeInsets.only(
                                  left: 16.0, bottom: 20.0),
                              alignment: Alignment.bottomLeft,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  stops: [0.1, 0.5, 0.7, 0.9],
                                  colors: [
                                    Color(0x00000000),
                                    Color(0x00000000),
                                    Color(0x22000000),
                                    Color(0x66000000),
                                  ],
                                ),
                              ),
                              child: Text(
                                movie.title.toUpperCase(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  fontFamily: 'Muli',
                                  color: white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          print(state);
          return Text("error");
        }
      },
    );
  }
}
