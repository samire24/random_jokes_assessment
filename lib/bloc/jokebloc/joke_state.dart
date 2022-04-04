import 'package:equatable/equatable.dart';
import 'package:random_jokes_assessment/model/quote_response.dart';

class JokeState extends Equatable {
  @override
  List<Object?> get props => [props];
}

class JokeStateStarted extends JokeState {}

class JokeStateError extends JokeState {
  final String? errorMessage;

  JokeStateError([this.errorMessage]);
}

class JokeStateLoading extends JokeState {}

class JokeStateCompleted extends JokeState {
  final JokeResponse? jokeResponse;
  JokeStateCompleted({this.jokeResponse});

  @override
  List<Object?> get props => [JokeResponse];
}
