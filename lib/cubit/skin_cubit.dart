import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skin_detection/article_screen.dart';
import 'package:skin_detection/home_screen.dart';
import 'package:skin_detection/profile_screen.dart';
import 'package:skin_detection/utilites/app_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:skin_detection/shard_screen.dart';

part 'skin_state.dart';

class SkinCubit extends Cubit<SkinState> {
  SkinCubit() : super(SkinInitialState());

  SkinCubit get(context) => BlocProvider.of(context);

  String? result;
  String? score;
  String? msg = ' Tap Again On Result 😊';

  bool isDark = true;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;

      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CachHelper.PutData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  Color? colo = HexColor('333739');
  Color? colorMode() {
    if (isDark) {
      return AppColors.lightgray;
    } else {
      return AppColors.white;
    }
  }

  Color? colorBackGround() {
    if (isDark) {
      return colo;
    } else {
      return AppColors.primaryColor;
    }
  }

  Color? colorBackGroundArticle() {
    if (isDark) {
      return colo;
    } else {
      return Colors.white;
    }
  }

  int currentIndex = 1;
  List<Widget> bottomScreen = [
    const Profile(),
    const HomeScreen(),
    const ArticleBttom(),
  ];

  void ChangeBottomNav(int index) {
    currentIndex = index;
    emit(BodyState());
  }

  List<String> tittle = [
    'Home',
    '',
    'General information',
  ];
  List<String> img = [
    'https://eng.caterieng.com/storage/diseases/1.png',
    "https://eng.caterieng.com/storage/diseases/2.jpg",
    "https://eng.caterieng.com/storage/diseases/3.jpg",
    "https://eng.caterieng.com/storage/diseases/4.jpg",
    "https://eng.caterieng.com/storage/diseases/5.jpg",
    "https://eng.caterieng.com/storage/diseases/6.jpg",
    "https://eng.caterieng.com/storage/diseases/7.jpg",
  ];

  List<String> articletitile = [
    'Actinic keratosis(AKIEC)',
    'Basal Cell Carcinoma(BCC)',
    'Benign Keratosis(BKL)',
    'Dermatofibroma(DF)',
    'Melanoma(MEL)',
    'melanocytic nevi (NV)',
    'Vascular Lesions(VASC) ',
  ];
  List<String> articleinarabic = [
    'تقرن الجلد السفعي',
    'سرطان الخلايا القاعدية',
    'التقرن المثني',
    'الورم الليفي الجلدي',
    'الورم الميلانيني',
    'وحمة الخلايا الصبغية',
    'آفات الأوعية الدموية ',
  ];
  Color? colorBotum() {
    if (isDark) {
      return Colors.white;
    } else {
      return AppColors.primaryColor;
    }
  }

  Color? colorText() {
    if (isDark) {
      return Colors.black;
    } else {
      return Colors.blueGrey;
    }
  }

  int BadgeDesease(String desease) {
    switch (desease) {
      case "تقرن الجلد السفعي | Actinic keratosis(AKIEC)":
        return 0;

      case "سرطان الخلايا القاعدية | Basal Cell Carcinoma(BCC)":
        return 1;

      case "التقرن المثني | Benign Keratosis(BKL)":
        return 2;

      case "الورم الليفي الجلدي | Dermatofibroma(DF)":
        return 3;

      case "وحمة الخلايا الصبغية | melanocytic nevi (NV)":
        return 5;

      case "آفات الأوعية الدموية | Vascular Lesions(VASC)":
        return 6;

      case "الورم الميلانيني | Melanoma(MEL)":
        return 4;

      default:
        return 0;
    }
  }

  upload({File? image}) async {
    emit(SkinLoadingState());

    final request = http.MultipartRequest(
        "POST", Uri.parse('https://eng.caterieng.com/api/classify'));
    final header = {"Content_type": "multipart/form-data"};
    request.files.add(http.MultipartFile(
        'image', image!.readAsBytes().asStream(), image.lengthSync(),
        filename: image.path.split('/').last));
    request.headers.addAll(header);
    final myRequest = await request.send();
    http.Response res = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      final resJson = jsonDecode(res.body);
      result = resJson['disease'];
      score = resJson['score'];
      msg = resJson['msg'];

      emit(SkinSuccessState());
    } else {
      emit(SkinErrorState());
      print("Error ${myRequest.statusCode}");
    }
  }

  List<dynamic> articles = [];
  void getData() async {
    emit(SkinGetArticleLoadingState());
    var respons =
        await Dio().get('https://eng.caterieng.com/api/diseases').then((value) {
      articles = value.data['data'];

      emit(SkinGetArticleSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SkinGetArticleErrorState(error.toString()));
    });
  }
}
