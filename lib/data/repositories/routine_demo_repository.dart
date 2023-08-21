import 'package:fpdart/fpdart.dart';
import 'package:homesmartify/domain/entities/routine.dart';
import 'package:homesmartify/domain/repositories/routine_repository.dart';

import '../../core/consts.dart';
import '../../core/error/failure.dart';
import '../data_sources/routine_local_data_source.dart';

class RoutineDemoRepository extends RoutineRepository{
  final RoutineLocalDataSource localDataSource;

  RoutineDemoRepository(this.localDataSource);

  @override
  Future<Either<Failure, List<Routine>>> getRoutines() async{
    Either<Failure, List<Routine>> routines = await localDataSource.getRoutines();

    if(routines.isLeft()){
      for (Routine routine in demoRoutines){
        localDataSource.addRoutine(routine);
      }
    }

    return await localDataSource.getRoutines();
  }

  @override
  Future<Either<Failure, Routine>> getRoutine(String id) {
    return localDataSource.getRoutine(id);
  }

  @override
  Future<Either<Failure, Routine>> addRoutine(Routine routine) {
    return localDataSource.addRoutine(routine);
  }

  @override
  Future<Either<Failure, Routine>> updateRoutine(Routine routine) {
    return localDataSource.updateRoutine(routine);
  }

  @override
  Future<Either<Failure, Routine>> deleteRoutine(Routine routine) {
    return localDataSource.deleteRoutine(routine);
  }
}