import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:l_movie/blocs/genre_bloc/genre_bloc.dart';
import 'package:l_movie/blocs/movie_bloc/movie_bloc.dart';
import 'package:l_movie/blocs/movie_bloc/movie_event.dart';
import 'package:l_movie/constants/movie_constants.dart';
import 'package:l_movie/models/genre.dart';
import 'package:l_movie/repository/genre_repository_impl.dart';
import 'package:l_movie/theme/colors.dart';
import 'package:l_movie/widgets/error_page.dart';
import 'package:l_movie/widgets/network_image_wrapper.dart';
import 'package:skeletons/skeletons.dart';

class GenreView extends StatelessWidget {
  final Function(Genre) actionOpenGenre;

  const GenreView({Key? key, required this.actionOpenGenre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GenreBloc(GenreRepositoryImpl())..add(const FetchGenresEvent());
      },
      child: _createGenre(context),
    );
  }

  Widget _createGenre(BuildContext context) {
    return BlocBuilder<GenreBloc, GenreState>(
      builder: (context, state) {
        if (state is GenreInitial) {
          return SizedBox(
            width: double.infinity,
            height: 96.0,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                final width = MediaQuery.of(context).size.width / 2.5;
                return Container(
                  width: width,
                  height: double.infinity,
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Card(
                    elevation: 0,
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: SizedBox(
                      width: width,
                      height: double.infinity,
                      child: SkeletonItem(
                        child: SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              width: double.infinity,
                              height: double.infinity,
                              borderRadius: BorderRadius.circular(12.0)),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 10,
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const VerticalDivider(
                color: Colors.transparent,
                width: 6.0,
              ),
            ),
          );
        } else if (state is GenresFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context
                  .watch<MovieBloc>()
                  .add(const FetchMovieWithType(MovieType.upcoming));
            },
          );
        } else if (state is GenresFetched) {
          return _createGenreList(context, state.genres);
        } else {
          return Text(AppLocalizations.of(context)!.cannotSupport);
        }
      },
    );
  }

  Widget _createGenreList(BuildContext context, List<Genre> genres) {
    return SizedBox(
      width: double.infinity,
      height: 96.0,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _createGenreItem(context, genres[index]);
        },
        itemCount: genres.length,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const VerticalDivider(
          color: Colors.transparent,
          width: 6.0,
        ),
      ),
    );
  }

  Widget _createGenreItem(BuildContext context, Genre genre) {
    final width = MediaQuery.of(context).size.width / 2.5;

    return InkWell(
      onTap: () {
        actionOpenGenre(genre);
      },
      child: Container(
        width: width,
        height: double.infinity,
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Card(
          elevation: 0,
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
                        'https://source.unsplash.com/random/300%C3%97150/?${genre.name}',
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
                      genre.name,
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
