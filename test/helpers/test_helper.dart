import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:inti/inti.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  // MovieRepository,
  // MovieRemoteDataSource,
  // MovieLocalDataSource,
  DatabaseHelper,
  TvRepository,
  TvRepositoryImpl,
  TvRemoteDataSource,
  TvLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
