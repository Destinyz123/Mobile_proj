import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:review888/function/slider.dart';
import 'package:network_image_mock/network_image_mock.dart'; // ใช้สำหรับ mock network image

void main() {
  testWidgets('SliderList test', (WidgetTester tester) async {
    // ตัวอย่างข้อมูลที่ใช้ในการทดสอบ
    List testData = [
      {
        'id': 1,
        'poster_path': '/path_to_poster1.jpg',
        'vote_average': 7.8,
      },
      {
        'id': 2,
        'poster_path': '/path_to_poster2.jpg',
        'vote_average': 9.0,
      }
    ];
    // ใช้ mockNetworkImagesFor เพื่อ mock NetworkImage
    await mockNetworkImagesFor(() async {
      // สร้าง widget สำหรับการทดสอบ
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: sliderlist(
                testData, 'Popular Movies', 'movie', testData.length),
          ),
        ),
      );

      // ทดสอบว่า widget มีการแสดงผลตามที่ต้องการ
      expect(find.text('Popular Movies'), findsOneWidget);
      expect(find.text('7.8'), findsOneWidget);
      expect(find.text('9.0'), findsOneWidget);

      // ทดสอบ gesture การคลิก
      // await tester.tap(find.byType(GestureDetector).first);
      // await tester.pumpAndSettle();
    });
  });
}
