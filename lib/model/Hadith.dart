import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Hadith {

  late String _hadithJson = "";

  Future<String> fetchHadith() async {

    if(_hadithJson==""){
      try{
        final response = await http.get(Uri.parse('https://api.sunnah.com/v1/hadiths/random'),
              headers: {'X-API-Key': "SqD712P3E82xnwOAEOkGd5JZH8s9wRR24TqNFzjk"});
        final jsonData = jsonDecode(response.body);
        final sanitized = parse(jsonData["hadith"][0]["body"]);
        final parsedString = parse(sanitized.body!.text).documentElement!.text;
        _hadithJson = parsedString;
        return _hadithJson;
      } catch(e){
        print(e);
        var err = e.toString();
        return err;
      }
    } else {
      return "No data";
    }}}