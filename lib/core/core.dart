import 'logging/logger.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Logger get logger => getIt.get<Logger>();