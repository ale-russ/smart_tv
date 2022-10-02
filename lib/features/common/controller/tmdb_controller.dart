import 'package:get/get.dart';
import 'package:smart_tv/features/common/services/keys.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TmdbController extends GetxController {
  CommonKeys _commonKeys = Get.find();

  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys('f8242645e5c75f1aa66afeaeb47494e3',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODI0MjY0NWU1Yzc1ZjFhYTY2YWZlYWViNDc0OTRlMyIsInN1YiI6IjYzMTY0ZWU3YmExMzFiMDA4MWQxYWMwMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0rthKmQIVTLgh9wFN7qkpMcmacpy1Juxib-KhJKXtEw'),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );
}
