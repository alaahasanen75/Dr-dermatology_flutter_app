import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_detection/article_item.dart';
import 'package:skin_detection/cubit/skin_cubit.dart';

class ArticleBttom extends StatelessWidget {
  const ArticleBttom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SkinCubit, SkinState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => ArticleItem(context, index),
                separatorBuilder: (context, index) => SizedBox(
                      height: 8.0,
                    ),
                itemCount: 7),
          );
        });
  }

  Widget? ArticleItem(context, int index) {
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => Article(
                    index: index,
                  ))),
        );
      }),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 85,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          width: 70,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                SkinCubit().get(context).img[index],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              '${SkinCubit().get(context).articletitile[index]}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: SkinCubit().get(context).colorText()),
                              maxLines: 1,
                            ),
                            Text(
                              '${SkinCubit().get(context).articleinarabic[index]}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            Text(
                              'protection,reasons..........',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
