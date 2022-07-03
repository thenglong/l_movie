import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:l_movie/blocs/blocs.dart';
import 'package:l_movie/blocs/movie_detail_bloc/movie_detail_event.dart';
import 'package:l_movie/blocs/movie_detail_bloc/movie_detail_state.dart';
import 'package:l_movie/cubits/expand_cubit.dart';
import 'package:l_movie/models/movie.dart';
import 'package:l_movie/models/movie_info.dart';
import 'package:l_movie/repository/movie_repository_impl.dart';
import 'package:l_movie/widgets/error_page.dart';
import 'package:l_movie/widgets/star_rating.dart';

class MovieInfoView extends StatelessWidget {
  final Movie movie;

  const MovieInfoView({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => MovieDetailBloc(MovieRepositoryImpl())
              ..add(GetMovieDetailEvent(movie.id))),
        BlocProvider(create: (_) => ExpandCubit()),
      ],
      child: _createMovieInfo(context),
    );
  }

  Widget _createMovieInfo(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is GetMovieDetailError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context
                  .watch<MovieDetailBloc>()
                  .add(GetMovieDetailEvent(movie.id));
            },
          );
        } else if (state is GetMovieDetailSuccess) {
          return _createMovieBody(context, state.movieInfo);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createMovieBody(BuildContext context, MovieInfo info) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
          child: Text(
            info.title,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black87,
              fontFamily: 'Muli',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
          child: Text(
            info.getCategories,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13.0,
              color: Colors.black45,
              fontFamily: 'Muli',
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: StarRating(
            size: 24.0,
            rating: info.voteAverage / 2,
            color: Colors.red,
            borderColor: Colors.black54,
            starCount: 5,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(''),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.year,
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.black45,
                      fontFamily: 'Muli',
                    ),
                  ),
                  Text(
                    info.year,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Muli',
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.country,
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.black45,
                      fontFamily: 'Muli',
                    ),
                  ),
                  Text(
                    info.country,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Muli',
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.length,
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.black45,
                      fontFamily: 'Muli',
                    ),
                  ),
                  Text(
                    info.runtime.toString(),
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Muli',
                    ),
                  )
                ],
              ),
              const Text(''),
            ],
          ),
        ),
        _createMovieOverview(context, info.overview),
      ],
    );
  }

  Widget _createMovieOverview(BuildContext context, String overview) {
    return BlocBuilder<ExpandCubit, bool>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<ExpandCubit>().toggle();
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0),
            child: Text(
              overview,
              textAlign: TextAlign.justify,
              maxLines: state ? 100 : 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black45,
                fontFamily: 'Muli',
              ),
            ),
          ),
        );
      },
    );
  }
}
