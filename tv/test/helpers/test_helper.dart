import 'package:http/io_client.dart';
import 'package:inti/inti.dart';
import 'package:tv/tv.dart';
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
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
