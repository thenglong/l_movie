import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_movie/blocs/movie_video_bloc/movie_video_bloc.dart';
import 'package:l_movie/models/movie.dart';
import 'package:l_movie/repository/movie_repository_impl.dart';
import 'package:l_movie/theme/colors.dart';
import 'package:l_movie/widgets/favorite_icon_widget.dart';
import 'package:l_movie/widgets/logo.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePlayerScreen extends StatelessWidget {
  final Movie movie;

  const MoviePlayerScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MovieVideoBloc(MovieRepositoryImpl())
          ..add(
            GetMovieVideosEvent(movie.id),
          );
      },
      child: WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            titleSpacing: 4.0,
            backgroundColor: Colors.transparent,
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
          body: BlocBuilder<MovieVideoBloc, MovieVideoState>(
            builder: (context, state) {
              if (state is MovieVideoInitial) {
                return Text("loading...");
              } else if (state is GetMovieVideosSuccess) {
                return YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: state.youtubePlayerController,
                    showVideoProgressIndicator: true,
                    progressColors: const ProgressBarColors(
                      playedColor: Colors.amber,
                      handleColor: Colors.amberAccent,
                    ),
                    progressIndicatorColor: Colors.amber,
                  ),
                  builder: (context, player) {
                    return Column(
                      children: [
                        player,
                      ],
                    );
                  },
                );
              } else {
                return Text("error");
              }
            },
          ),
        ),
        onWillPop: () async => true,
      ),
    );
  }
}
