import 'package:fpdart/fpdart.dart';

import '../../core/error/failure.dart';
import '../entities/routine.dart';
import '../entities/smart_device.dart';

abstract class RoutineRepository{
  Future<Either<Failure, List<Routine>>> getRoutines();
  Future<Either<Failure, Routine>> getRoutine(String id);
  Future<Either<Failure, Routine>> addRoutine(Routine routine);
  Future<Either<Failure, Routine>> updateRoutine(Routine routine);
  Future<Either<Failure, Routine>> deleteRoutine(Routine routine);
}