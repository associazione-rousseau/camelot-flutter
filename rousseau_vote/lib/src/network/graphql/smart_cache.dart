
import 'package:graphql_flutter/graphql_flutter.dart';

/// Workaround to avoid conflicts injecting the cache
class SmartCache extends OptimisticCache {
  SmartCache() : super(dataIdFromObject: typenameDataIdFromObject);
}