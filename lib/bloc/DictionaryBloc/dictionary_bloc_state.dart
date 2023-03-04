part of 'dictionary_bloc_bloc.dart';

abstract class DictionaryBlocState extends Equatable {
  const DictionaryBlocState();

  @override
  List<Object> get props => [];
}

class DictionaryBlocInitial extends DictionaryBlocState {}

class DictionaryBlocSearching extends DictionaryBlocState {}

class DictionaryBlocSearched extends DictionaryBlocState {
  final List<Dictionary> words;
  const DictionaryBlocSearched(this.words);
  List<Object> get props => [words];
}

class ErrorState extends DictionaryBlocState {
  final message;
  const ErrorState(this.message);
  List<Object> get props => [message];
}
