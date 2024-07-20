import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SportmonkService {
  static final url = dotenv.env['API_ROUTE_SPORTMONKS'];
  static final token = dotenv.env['API_TOKEN_SPORTMONKS'];

  Future<List<dynamic>> getLeagues() async {
    final response = await http.get(Uri.parse(
        '${url!}/leagues?api_token=${token!}&include=seasons;currentseason'));

    var result = jsonDecode(response.body);

    return result['data'] != null ? List.from(result['data']) : List.empty();
  }

  Future<List<dynamic>> getSeasonStandings(int seasonId) async {
    final response = await http.get(Uri.parse(
        '${url!}/standings/seasons/$seasonId?api_token=${token!}&include=participant;form'));

    var result = jsonDecode(response.body);

    return result['data'] != null ? List.from(result['data']) : List.empty();
  }

  Future<List<dynamic>> getSeasonSchedule(int seasonId) async {
    final response = await http.get(
        Uri.parse('${url!}/schedules/seasons/$seasonId?api_token=${token!}'));

    var result = jsonDecode(response.body);

    return result['data'] != null ? List.from(result['data']) : List.empty();
  }
}
