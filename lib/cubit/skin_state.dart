part of 'skin_cubit.dart';

@immutable
abstract class SkinState {}

class SkinInitialState extends SkinState {}

class BodyState extends SkinState {}

class SkinLoadingState extends SkinState {}

class SkinSuccessState extends SkinState {}

class SkinErrorState extends SkinState {}

class AppIniState extends SkinState {}

class AppChangeModeState extends SkinState {}

class ArticleLoadingState extends SkinState {}

class ArticleSuccessState extends SkinState {}

class ArticleErrorState extends SkinState {}

class SkinGetArticleLoadingState extends SkinState {}

class SkinGetArticleSuccessState extends SkinState {}

class SkinGetArticleErrorState extends SkinState {
  final error;
  SkinGetArticleErrorState(this.error);
}
