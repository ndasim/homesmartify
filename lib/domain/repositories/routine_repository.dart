import '../entities/routine.dart';

abstract class RoutineRepository{
  Future<List<Routine>> getRoutines();
  Future<void> addRoutine(Routine routine);
  Future<void> updateRoutine(Routine routine);
  Future<void> deleteRoutine(Routine routine);
}