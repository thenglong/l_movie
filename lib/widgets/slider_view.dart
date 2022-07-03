import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:l_movie/blocs/movie_bloc/movie_bloc.dart';
import 'package:l_movie/blocs/movie_bloc/movie_event.dart';
import 'package:l_movie/blocs/movie_bloc/movie_state.dart';
import 'package:l_movie/constants/movie_constants.dart';
import 'package:l_movie/models/movie.dart';
import 'package:l_movie/repository/movie_repository_impl.dart';
import 'package:l_movie/theme/colors.dart';
import 'package:l_movie/widgets/error_page.dart';
import 'package:l_movie/widgets/network_image_wrapper.dart';

class SliderView extends StatefulWidget {
  final Function(Movie) actionOpenMovie;

  const SliderView({Key? key, required this.actionOpenMovie}) : super(key: key);

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  final _movieBloc = MovieBloc(MovieRepositoryImpl());

  @override
  void initState() {
    _movieBloc.add(FetchMovieWithType(MovieConstants.nowPlaying));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _movieBloc,
      child: _createSlider(context),
    );
  }

  Widget _createSlider(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieInit) {
          return CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Card(
                  elevation: 10.0,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Stack(
                        children: [
                          SpinKitThreeBounce(
                            color: Theme.of(context).hintColor,
                            size: 18.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: true,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
            ),
          );
        } else if (state is MovieFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context
                  .watch<MovieBloc>()
                  .add(FetchMovieWithType(MovieConstants.nowPlaying));
            },
          );
        } else if (state is MovieFetched) {
          final movies = state.movies;
          return CarouselSlider.builder(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return _createMovieSliderItem(context, movies[index]);
            },
            options: CarouselOptions(
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: true,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
            ),
          );
        } else {
          return const Spacer();
        }
      },
    );
  }

  Widget _createMovieSliderItem(BuildContext context, Movie movie) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        widget.actionOpenMovie(movie);
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
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  Hero(
                    tag: movie,
                    child: NetworkImageWrapper(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                      width: width,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: width,
                    height: double.infinity,
                    padding: const EdgeInsets.only(left: 16.0, bottom: 20.0),
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
        ),
      ),
    );
  }
}
