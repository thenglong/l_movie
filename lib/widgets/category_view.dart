import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:l_movie/blocs/movie_bloc/movie_bloc.dart';
import 'package:l_movie/blocs/movie_bloc/movie_event.dart';
import 'package:l_movie/blocs/movie_bloc/movie_state.dart';
import 'package:l_movie/constants/movie_constants.dart';
import 'package:l_movie/models/movie.dart';
import 'package:l_movie/repository/movie_repository_impl.dart';
import 'package:l_movie/theme/colors.dart';
import 'package:l_movie/widgets/error_page.dart';
import 'package:l_movie/widgets/network_image_wrapper.dart';

class CategoryView extends StatelessWidget {
  final Function(Movie) actionOpenCategory;

  const CategoryView({Key? key, required this.actionOpenCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MovieBloc(MovieRepositoryImpl())
          ..add(FetchMovieWithType(MovieType.upcoming));
      },
      child: _createCategory(context),
    );
  }

  Widget _createCategory(BuildContext context) {
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
                  .add(FetchMovieWithType(MovieType.upcoming));
            },
          );
        } else if (state is MovieFetched) {
          return _createCategoryList(context, state.movies);
        } else {
          return Text(AppLocalizations.of(context)!.cannotSupport);
        }
      },
    );
  }

  Widget _createCategoryList(BuildContext context, List<Movie> movies) {
    return SizedBox(
      width: double.infinity,
      height: 96.0,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _createCategoryItem(context, movies[index]);
        },
        itemCount: movies.length,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const VerticalDivider(
          color: Colors.transparent,
          width: 6.0,
        ),
      ),
    );
  }

  Widget _createCategoryItem(BuildContext context, Movie movie) {
    final width = MediaQuery.of(context).size.width / 2.5;

    return InkWell(
      onTap: () {
        actionOpenCategory(movie);
      },
      child: Container(
        width: width,
        height: double.infinity,
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Card(
          elevation: 8.0,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SizedBox(
            width: width,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  NetworkImageWrapper(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                    width: width,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: width,
                    height: double.infinity,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          Color(0x99ff0000),
                          Color(0x66ff0000),
                          Color(0x66ff0000),
                          Color(0x99ff0000),
                        ],
                      ),
                    ),
                    child: Text(
                      movie.releaseDate,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontFamily: 'Muli',
                        color: white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
