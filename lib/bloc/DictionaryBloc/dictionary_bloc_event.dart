part of 'dictionary_bloc_bloc.dart';

abstract class DictionaryBlocEvent extends Equatable {
  const DictionaryBlocEvent();

  @override
  List<Object> get props => [];
}

class GetWordList extends DictionaryBlocEvent {
  String query;
  GetWordList(this.query);
}
