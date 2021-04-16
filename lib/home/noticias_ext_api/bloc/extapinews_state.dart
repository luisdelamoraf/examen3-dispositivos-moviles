part of 'extapinews_bloc.dart';

abstract class ExtapinewsState extends Equatable {
  const ExtapinewsState();

  @override
  List<Object> get props => [];
}

class ExtapinewsInitial extends ExtapinewsState {}

class ExtapinewsLoadingState extends ExtapinewsState {}

class ExtapinewsLoadedState extends ExtapinewsState {
  final List<New> externalApiNewsList;

  ExtapinewsLoadedState({@required this.externalApiNewsList});

  @override
  List<Object> get props => [externalApiNewsList];
}

class ExtapinewsErrorState extends ExtapinewsState {
  final String error;

  ExtapinewsErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}
