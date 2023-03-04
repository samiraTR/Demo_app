import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:demo_app/Services/api_repository.dart';
import 'package:demo_app/models/dictionary_model.dart';

part 'dictionary_bloc_event.dart';
part 'dictionary_bloc_state.dart';

class DictionaryBlocBloc
    extends Bloc<DictionaryBlocEvent, DictionaryBlocState> {
  final queryController = TextEditingController();

  DictionaryBlocBloc() : super(DictionaryBlocInitial()) {
    final WordRepository repository = WordRepository();

    on<GetWordList>((event, emit) async {
      List<Dictionary> words = [];
      try {
        // emit(DictionaryBlocSearching());

        words = await repository.getWordsFromDictionary(event.query);

        Future.delayed(Duration(seconds: 3));
        emit(DictionaryBlocSearched(words));

        // if (words.isNotEmpty) {
        //   print("aftersearching +searching $words");

        // } else {
        //   print("aftersearching +searching $words");

        //   emit(DictionaryBlocInitial());
        // }

        // if (words == null) {
        //   emit(ErrorState("Words are not Found"));
        // } else {
        //   emit(DictionaryBlocSearched(words));
        // }
      } on Exception catch (e) {
        print(e);
        emit(ErrorState(e.toString));
      }
    });
  }
}
