import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_jokes_assessment/bloc/jokebloc/joke_event.dart';
import 'package:random_jokes_assessment/model/quote_response.dart';
import 'package:random_jokes_assessment/splashscreen.dart';

import 'bloc/jokebloc/joke_bloc.dart';
import 'bloc/jokebloc/joke_state.dart';

class JokeScreen extends StatelessWidget {
  const JokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<JokeBloc>(
          create: (BuildContext context) {
            return JokeBloc(JokeStateStarted())..add(const JokeFetchInitialPage());
          },
        ),
      ],
      child: const JokePage(),
    );
  }
}

class JokePage extends StatefulWidget {
  const JokePage({Key? key}) : super(key: key);

  @override
  _JokePageState createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  JokeResponse? jokeResponse;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Random Joke',
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<JokeBloc, JokeState>(
          builder: (BuildContext context, JokeState state) {
            if (state is JokeStateStarted || state is JokeStateLoading) {
              return Center(
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
                  child: const Center(
                    child: SpinKitFadingCircle(color: Colors.blueAccent),
                  ),
                ),
              );
            } else if (state is JokeStateCompleted) {
              jokeResponse = state.jokeResponse;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisible = true;
                          Future.delayed(
                              const Duration(seconds: 3),
                              () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SplashScreen()),
                                  ));
                        });
                      },
                      child: Center(
                        child: Text(
                          "${jokeResponse?.setup}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Center(
                        child: Text(
                          "${jokeResponse?.punchline}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is JokeStateError) {
              String? error = state.errorMessage;
              print(error);
            }
            return Container();
          },
        ));
  }
}
