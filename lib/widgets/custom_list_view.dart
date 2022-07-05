import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:l_movie/blocs/movie_bloc/movie_bloc.dart';
import 'package:l_movie/blocs/movie_bloc/movie_event.dart';
import 'package:l_movie/blocs/movie_bloc/movie_state.dart';
import 'package:l_movie/constants/movie_constants.dart';
import 'package:l_movie/models/movie.dart';
import 'package:l_movie/repository/movie_repository_impl.dart';
import 'package:l_movie/screens/photo_gallery_screen.dart';
import 'package:l_movie/theme/colors.dart';
import 'package:l_movie/widgets/error_page.dart';
import 'package:l_movie/widgets/network_image_wrapper.dart';

class CustomListView extends StatelessWidget {
  final Function(Movie) actionOpenMovie;
  final void actionLoadAll;

  const CustomListView(
      {Key? key, required this.actionOpenMovie, required this.actionLoadAll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MovieBloc(MovieRepositoryImpl())
          ..add(
            const FetchMovieWithType(MovieType.topRated),
          );
      },
      child: _createMyList(context),
    );
  }

  Widget _createMyList(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieInit) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context
                  .watch<MovieBloc>()
                  .add(const FetchMovieWithType(MovieType.topRated));
            },
          );
        } else if (state is MovieFetched) {
          return _createMyListView(context, state.movies);
        } else {
          return Text(AppLocalizations.of(context)!.cannotSupport);
        }
      },
    );
  }

  Widget _createMyListView(BuildContext context, List<Movie> movies) {
    final contentHeight = 4.0 * (MediaQuery.of(context).size.width / 2.4) / 3;

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20.0, right: 16.0),
          height: 48.0,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  AppLocalizations.of(context)!.myList,
                  style: const TextStyle(
                    color: groupTitleColor,
                    fontSize: 16.0,
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward, color: groupTitleColor),
                onPressed: () {
                  return actionLoadAll;
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: contentHeight,
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return _createMyListItem(context, movies[index], movies, index);
            },
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const VerticalDivider(
              color: Colors.transparent,
              width: 6.0,
            ),
            itemCount: movies.length,
          ),
        ),
      ],
    );
  }

  Widget _createMyListItem(
      BuildContext context, Movie movie, List<Movie> allMovies, int index) {
    final width = MediaQuery.of(context).size.width / 2.6;
    return InkWell(
      onTap: () {
        actionOpenMovie(movie);
      },
      child: Container(
        width: width,
        height: double.infinity,
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Card(
          elevation: 10.0,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SizedBox(
            width: width,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: GestureDetector(
                // onTap: () => openGallery(context,
                //     allMovies.map((e) => e.posterPath).toList(), index),
                child: Hero(
                  tag: movie,
                  child: NetworkImageWrapper(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    width: width,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void openGallery(BuildContext context, List<String> images, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoGalleryScreen(
          images: images,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
