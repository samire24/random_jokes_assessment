import 'package:equatable/equatable.dart';
import 'package:random_jokes_assessment/model/quote_response.dart';

class JokeEvent extends Equatable {
  const JokeEvent();
  @override
  List<Object?> get props => [];
}

class JokeFetchInitialPage extends JokeEvent {
  final JokeResponse? jokeResponse;

  const JokeFetchInitialPage({this.jokeResponse});

  @override
  List<Object?> get props => [jokeResponse];
}
