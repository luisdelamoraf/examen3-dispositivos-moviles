import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_login/models/new.dart';
import 'package:google_login/utils/news_repository.dart';

part 'extapinews_event.dart';
part 'extapinews_state.dart';

class ExtapinewsBloc extends Bloc<ExtapinewsEvent, ExtapinewsState> {
  ExtapinewsBloc() : super(ExtapinewsInitial());

  @override
  Stream<ExtapinewsState> mapEventToState(
    ExtapinewsEvent event,
  ) async* {
    // Primera carga de noticias
    if (event is RequestFirstNewsEvent) {
      yield ExtapinewsLoadingState();
      yield ExtapinewsLoadedState(
          externalApiNewsList:
              await NewsRepository().getAvailableNoticias("sports"));
    }
    // Noticias filtradas
    else if (event is RequestFilterNewsEvent) {
      yield ExtapinewsLoadedState(
          externalApiNewsList:
              await NewsRepository().getAvailableNoticias(event.query));
    }
  }
}
