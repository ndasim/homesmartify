import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:homesmartify/data/serializers/routine_model_serializer.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../../domain/entities/routine.dart';

import '../../core/error/failure.dart';
import '../../core/error/internal_exception.dart';
import '../../core/error/no_data_failure.dart';

import 'package:collection/collection.dart';

class RoutineLocalDataSource {
  static const String routinesKey = "routines";

  final SecureSharedPref secureSharedPref;

  RoutineLocalDataSource(this.secureSharedPref);

  Future<Either<Failure, List<Routine>>> getRoutines() async {
    try {
      // Get the list of routines from the secure shared preferences
      String? data = await secureSharedPref.getString(routinesKey);

      // If there is no data, return a NoDataFailure
      if (data == null) return Future.value(const Left(NoDataFailure()));

      // Decode the list of routines from JSON
      List<Map<String, dynamic>> rawRoutines = (jsonDecode(data) as List).cast<Map<String, dynamic>>();

      // Return the list of routines
      return Future.value(
        Right(
          rawRoutines.map((value) {
            return RoutineModelSerializer.fromJson(value);
          }).toList(),
        ),
      );
    } catch (e, s) {
      return Future.value(Left(InternalException(e, s)));
    }
  }

  Future<Either<Failure, Routine>> getRoutine(String id) async {
    try {
      // Get routine list
      Either<Failure, List<Routine>> result = await getRoutines();

      // If there are no failures, return the routine with the given id
      if (result.isRight()) {
        // Get the routine with the given id
        Routine? routine = ((result as Right).value as List).firstWhereOrNull((element) => element.id == id);

        // If the routine is null, return a NoDataFailure
        if (routine == null) return const Left(NoDataFailure());

        // Return the routine
        return Future.value(Right(routine));
      }

      // Return the failure
      return Left((result as Left).value);
    }
    catch (e, s) {
      return Future.value(Left(InternalException(e, s)));
    }
  }

  Future<Either<Failure, Routine>> addRoutine(Routine routine) async {
    try{
      // Get routine list
      Either<Failure, List<Routine>> result = await getRoutines();

      // If there are no failures, add the new routine to the list and save it
      if(result.isRight()){
        // Add the new routine to the list
        List<Routine> routines = (result as Right).value..add(routine);

        // Encode the list of routines to JSON
        String data = jsonEncode(routines.map((routine) => RoutineModelSerializer.toJson(routine)).toList());

        // Save the list of routines to the secure shared preferences
        await secureSharedPref.putString(routinesKey, data);

        // Return the new routine
        return Future.value(Right(routine));
      }

      // Return the failure
      return Left((result as Left).value);
    }
    catch(e, s){
      return Future.value(Left(InternalException(e, s)));
    }
  }
  
  Future<Either<Failure, Routine>> updateRoutine(Routine routine) async {
    try{
      // Get routine list
      Either<Failure, List<Routine>> result = await getRoutines();

      // If there are no failures, update the routine in the list and save it
      if(result.isRight()){
        // Update the routine in the list
        List<Routine> routines = (result as Right).value..removeWhere((element) => element.name == routine.name)..add(routine);

        // Encode the list of routines to JSON
        String data = jsonEncode(routines.map((routine) => RoutineModelSerializer.toJson(routine)).toList());

        // Save the list of routines to the secure shared preferences
        await secureSharedPref.putString(routinesKey, data);

        // Return the new routine
        return Future.value(Right(routine));
      }

      // Return the failure
      return Left((result as Left).value);
    }
    catch(e, s){
      return Future.value(Left(InternalException(e, s)));
    }
  }
  
  Future<Either<Failure, Routine>> deleteRoutine(Routine routine) async {
    try{
      // Get routine list
      Either<Failure, List<Routine>> result = await getRoutines();

      // If there are no failures, delete the routine from the list and save it
      if(result.isRight()){
        // Delete the routine from the list
        List<Routine> routines = (result as Right).value..removeWhere((element) => element.name == routine.name);

        // Encode the list of routines to JSON
        String data = jsonEncode(routines.map((routine) => RoutineModelSerializer.toJson(routine)).toList());

        // Save the list of routines to the secure shared preferences
        await secureSharedPref.putString(routinesKey, data);

        // Return the new routine
        return Future.value(Right(routine));
      }

      // Return the failure
      return Left((result as Left).value);
    }
    catch(e, s){
      return Future.value(Left(InternalException(e, s)));
    }
  }
}