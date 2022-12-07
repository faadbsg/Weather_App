import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/failure.dart';

abstract class Usecase<TypeReturn, Param> {
  Future<Either<Failure, TypeReturn>> call(Param param);
}

class NoParam extends Equatable {
  @override
  List<Object?> get props => [];
}
