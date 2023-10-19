import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@module
abstract class AbstractComponentsModule {
  @lazySingleton
  EventBus get eventBus => EventBus();

  @lazySingleton
  Uuid get uuid => const Uuid();
}
