part of 'fact_block_bloc.dart';

@immutable
sealed class FactBlockEvent {}

class GetRandomFact extends FactBlockEvent{}

class GetRandomFactByCategory extends FactBlockEvent{
  final String category;

  GetRandomFactByCategory({required this.category});
}

class WriteNewFact extends FactBlockEvent{
  final String title;
  final String body;
  final String category;

  WriteNewFact({required this.title, required this.body, required this.category});
}

class LikeFact extends FactBlockEvent{
  final int id;

  LikeFact({required this.id});
}

class DislikeFact extends FactBlockEvent{
  final int id;

  DislikeFact({required this.id});
}