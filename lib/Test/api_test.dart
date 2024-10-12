import 'package:flutter_test/flutter_test.dart';
import 'package:review888/apikey/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PopularMovieService {
  List<Map<String, dynamic>> popularmovie = [];
  var key;
  var popularmovieurl;
  PopularMovieService(String key) {
    this.key = key;
    popularmovieurl = 'https://api.themoviedb.org/3/movie/popular?api_key=$key';
  }

  Future<void> movieslist() async {
    var popularmovieresponse = await http.get(Uri.parse(popularmovieurl));
    if (popularmovieresponse.statusCode == 200) {
      var tempdata = jsonDecode(popularmovieresponse.body);
      var popularmoviejson = tempdata['results'];
      for (var i = 0; i < 10; i++) {
        popularmovie.add({
          'name': popularmoviejson[i]['title'],
          'poster_path': popularmoviejson[i]['poster_path'],
          'vote_average': popularmoviejson[i]['vote_average'],
          'Date': popularmoviejson[i]['release_date'],
          'id': popularmoviejson[i]['id'],
        });
      }
    } else {
      print(popularmovieresponse.statusCode);
    }
  }
}

void main() {
  group('Movies API Test', () {
    test('ทดสอบการ fetch ข้อมูลหนังยอดนิยมสำเร็จ', () async {
      // ใส่ api key จริงๆ
      var movieservice = PopularMovieService(apikey);
      await movieservice.movieslist(); // Fetch ข้อมูลจริงจาก API

      // ตรวจสอบว่า fetch ข้อมูลได้สำเร็จ
      expect(movieservice.popularmovie.isNotEmpty,
            true); // popularmovie ไม่ควรเป็นค่าว่าง
      for (var i = 0; i < 10; i++) {
        expect(movieservice.popularmovie[i]['name'], isNotNull);
        expect(movieservice.popularmovie[i]['poster_path'], isNotNull);
        expect(movieservice.popularmovie[i]['Date'], isNotNull);
        expect(movieservice.popularmovie[i]['id'], isNotNull); // ควรมีชื่อหนัง
        expect(movieservice.popularmovie[i]['vote_average'],
            isNotNull); // ควรมีคะแนนโหวต
      }
    });

    test('ทดสอบการ fetch ข้อมูลหนังยอดนิยมล้มเหลว', () async {
      // ลองใส่ api key มั่วๆ
      var movieservice = PopularMovieService('exampleapikey');
      await movieservice.movieslist(); // Fetch ข้อมูลจริงจาก API

      // ตรวจสอบว่าไม่มีข้อมูลถูกเพิ่มเข้ามาเมื่อการ fetch ล้มเหลว
      expect(movieservice.popularmovie.isEmpty,
          true); // popularmovie ควรเป็นค่าว่าง
    });
  });
}
