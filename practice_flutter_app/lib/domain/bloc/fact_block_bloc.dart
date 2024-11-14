import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:practice_flutter_app/data/fact_repository.dart';
import 'package:practice_flutter_app/data/model.dart';

part 'fact_block_event.dart';
part 'fact_block_state.dart';

class FactBlockBloc extends Bloc<FactBlockEvent, FactBlockState> {
  late HttpFactRepository _repository;

  FactBlockBloc() : super(FactBlockInitial()) {
    _repository = FactRepositoryProvider.instance;

    on<GetRandomFact>(_onLoadRandomFact);
    on<GetRandomFactByCategory>(_onLoadRandomFactByCategory);
    on<WriteNewFact>(_onSaveNewFact);
    on<LikeFact>(_onLikeFact);
    on<DislikeFact>(_onDislikeFact);
  }

  Future<void> _onLoadRandomFact(
    GetRandomFact event,
    Emitter<FactBlockState> emit,
  ) async {
    emit(FactLoading());
    try {
      final fact = await _repository.getRandomFact();
      emit(FactLoaded(fact: fact));
    } catch (e) {
      emit(FactLoadingError(errorMessage: 'Не удалось загрузить случайный факт $e'));
    }
  }

  Future<void> _onLoadRandomFactByCategory(
    GetRandomFactByCategory event,
    Emitter<FactBlockState> emit,
  ) async {
    emit(FactLoading());
    try {
      final fact = await _repository.getRandomFactByCategory(event.category);
      emit(FactLoaded(fact: fact));
    } catch (e) {
      emit(FactLoadingError(errorMessage: 'Не удалось загрузить случайный факт $e'));
    }
  }

  Future<void> _onSaveNewFact(
    WriteNewFact event,
    Emitter<FactBlockState> emit,
  ) async {
    emit(FactLoading());
    try {
      await _repository.newFact(Fact(title: event.title, body: event.body, category: event.category));
      emit(FactSaved());
    } catch (_) {
      emit(FactLoadingError(errorMessage: 'Не удалось сохранить новый факт'));
    }
  }

  Future<void> _onLikeFact(
    LikeFact event,
    Emitter<FactBlockState> emit,
  ) async {
    emit(FactLoading());
    try {
      final likedFact = await _repository.like(event.id);
      emit(FactLoaded(fact: likedFact, graduated: true));
    } catch (_) {
      emit(FactLoadingError(errorMessage: 'Не удалось отметить факт как понравившийся'));
    }
  }

  Future<void> _onDislikeFact(
    DislikeFact event,
    Emitter<FactBlockState> emit,
  ) async {
    emit(FactLoading());
    try {
      final likedFact = await _repository.dislike(event.id);
      emit(FactLoaded(fact: likedFact, graduated: true));
    } catch (_) {
      emit(FactLoadingError(errorMessage: 'Не удалось отметить факт как непонравившийся'));
    }
  }
}
