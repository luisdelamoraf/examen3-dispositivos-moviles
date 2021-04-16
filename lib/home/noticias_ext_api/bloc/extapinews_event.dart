part of 'extapinews_bloc.dart';

abstract class ExtapinewsEvent extends Equatable {
  const ExtapinewsEvent();

  @override
  List<Object> get props => [];
}

class RequestFirstNewsEvent extends ExtapinewsEvent {
  @override
  List<Object> get props => [];
}

class RequestFilterNewsEvent extends ExtapinewsEvent {
  final String query;

  RequestFilterNewsEvent({@required this.query});

  @override
  List<Object> get props => [query];
}
