import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class RPCache {
  static final CacheManager rpCacheManager = CacheManager(
    Config(
      'rpCacheManager',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 200,
    ),
  );
}
