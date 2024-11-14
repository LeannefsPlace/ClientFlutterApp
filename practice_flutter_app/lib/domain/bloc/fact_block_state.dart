part of 'fact_block_bloc.dart';

@immutable
sealed class FactBlockState {}

final class FactBlockInitial extends FactBlockState {}

final class FactLoading extends FactBlockState{}

final class FactLoaded extends FactBlockState{
  final Fact fact;
  final bool graduated;

  FactLoaded({required this.fact, this.graduated = false});
}

final class FactLoadingError extends FactBlockState{
  final String errorMessage;

  FactLoadingError({required this.errorMessage});
}

final class FactSaved extends FactBlockState{
}