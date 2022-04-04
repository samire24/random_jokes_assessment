import 'package:random_jokes_assessment/http/http_service.dart';
import 'package:random_jokes_assessment/model/quote_response.dart';
import 'package:tuple/tuple.dart';

class JokeServices {
  static Future<Tuple2<JokeResponse?, String?>> getRandomJokes() async {
    HttpService _httpService = HttpService();
    try {
      final response = await _httpService.get("https://joke.api.gkamelo.xyz/random");
      JokeResponse quoteResponse = JokeResponse.fromJson(response!);
      return Tuple2(quoteResponse, null);
    } on Exception catch (e) {
      return Tuple2(null, e.toString());
    }
  }
}
