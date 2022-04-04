import 'package:bloc/bloc.dart';
import 'package:random_jokes_assessment/bloc/jokebloc/joke_event.dart';
import 'package:random_jokes_assessment/bloc/jokebloc/joke_state.dart';
import 'package:random_jokes_assessment/joke_service.dart';
import 'package:random_jokes_assessment/model/quote_response.dart';
import 'package:tuple/tuple.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  JokeBloc(JokeState initialState) : super(initialState);

  JokeState get initialState => JokeStateStarted();

  @override
  Stream<JokeState> mapEventToState(JokeEvent event) async* {
    if (event is JokeFetchInitialPage) {
      yield JokeStateLoading();
      Tuple2<JokeResponse?, String?> response = await JokeServices.getRandomJokes();

      if (response.item1 is JokeResponse) {
        yield JokeStateCompleted(jokeResponse: response.item1);
      } else if (response.item2 is String) {
        yield JokeStateError(response.item2);
      }
    }
  }
}
