import 'package:dartz/dartz.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';
import 'package:inti/inti.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
