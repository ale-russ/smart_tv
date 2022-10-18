import 'package:get/get.dart';
import 'package:smart_tv/features/common/services/keys.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieService {
  final CommonKeys _commonKeys = Get.put(CommonKeys());
  TMDB fetchMovies() {
    TMDB tmdbWithCustomLogs = TMDB(
      // ApiKeys(apikey, readaccesstoken),
      ApiKeys(_commonKeys.apikey!, _commonKeys.readaccesstoken!),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    return tmdbWithCustomLogs;
  }
}
