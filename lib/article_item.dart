import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/skin_cubit.dart';

class Article extends StatelessWidget {
  final int index;
  Article({Key? key, required this.index});
  @override
  Widget build(context) {
    return BlocConsumer<SkinCubit, SkinState>(
        listener: (context, state) {},
        builder: (context, state) {
          SkinCubit cubit = SkinCubit().get(context);

          return Scaffold(
              appBar: AppBar(
                backgroundColor: cubit.colorBackGround(),
                elevation: 4,
                title: Text(
                  'Article',
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Card(
                          color:
                              SkinCubit().get(context).colorBackGroundArticle(),
                          elevation: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              '${cubit.articles[index]["name"]}',
                              style: Theme.of(context).textTheme.bodyLarge,
                              textDirection: TextDirection.rtl,
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${cubit.articles[index]["img"]}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        color:
                            SkinCubit().get(context).colorBackGroundArticle(),
                        elevation: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                "${cubit.articles[index]["intro"]}",
                                style: Theme.of(context).textTheme.bodyLarge,
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "الأعراض:",
                                style: Theme.of(context).textTheme.bodyLarge,
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                '${cubit.articles[index]["symptoms"]}',
                                style: Theme.of(context).textTheme.bodyLarge,
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "الأسباب:",
                                style: Theme.of(context).textTheme.bodyLarge,
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                '${cubit.articles[index]["reasons"]}',
                                style: Theme.of(context).textTheme.bodyLarge,
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "طرق الحماية:",
                                style: Theme.of(context).textTheme.bodyLarge,
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                '${cubit.articles[index]["protection"]}',
                                style: Theme.of(context).textTheme.bodyLarge,
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "العلاج:",
                                style: Theme.of(context).textTheme.bodyLarge,
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                '${cubit.articles[index]["treatment"]}',
                                style: Theme.of(context).textTheme.bodyLarge,
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
