import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_detection/cubit/skin_cubit.dart';
import 'package:skin_detection/shard_screen.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var FormKey = GlobalKey<FormState>();

    dynamic textController = TextEditingController();
    dynamic genderController = TextEditingController();
    dynamic colorController = TextEditingController();

    if (CachHelper.getDataOfTextFormFiled(key: 'data') != null) {
      textController.value = TextEditingValue(
          text: CachHelper.getDataOfTextFormFiled(key: 'data')!);
    }
    return BlocConsumer<SkinCubit, SkinState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CarouselSlider(
                      items: [
                        Image(
                          image: NetworkImage(
                              'https://media.istockphoto.com/id/637292158/photo/skin-anatomy.jpg?s=1024x1024&w=is&k=20&c=dok0XB7lCnfP3k-zZNu75alLdDOmSjk-riEc7xGrdQ8='),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Image(
                          image: NetworkImage(
                              'https://media.istockphoto.com/id/883793088/vector/layers-of-human.jpg?s=1024x1024&w=is&k=20&c=N2lFCB5B7G7x-jmdmtyx0fKIWlvzIs_mLGnHiYEgEmU='),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      ],
                      options: CarouselOptions(
                        height: 300.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        viewportFraction: 1.0,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: FormKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: SkinCubit()
                                            .get(context)
                                            .colorBotum()!,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    height: 40,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Text(
                                            'Enter When did the symptoms begin?',
                                            style: TextStyle(
                                                color: SkinCubit()
                                                    .get(context)
                                                    .colorBotum()!,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            color: SkinCubit()
                                                .get(context)
                                                .colorBotum()!,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          icon: Icon(Icons.person, size: 80),
                                          iconColor: Color(0xff205072),
                                          titlePadding: EdgeInsets.all(20),
                                          titleTextStyle: const TextStyle(
                                              color: Color(0xff205072),
                                              fontWeight: FontWeight.bold),
                                          content: TextFormField(
                                              controller: textController,
                                              decoration: const InputDecoration(
                                                focusColor: Colors.white,
                                                labelText: 'Date',
                                                border: OutlineInputBorder(),
                                              ),
                                              onChanged: (value) =>
                                                  print(value),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Name must not be empty ';
                                                } else {
                                                  CachHelper
                                                      .PutDataOfTextFormFiled(
                                                          value: value,
                                                          key: 'data');
                                                }
                                                return null;
                                              }),
                                          contentTextStyle: const TextStyle(
                                              color: Color(0xff205072)),
                                        );
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: SkinCubit()
                                            .get(context)
                                            .colorBotum()!,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    height: 40,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Text(
                                            'Enter Gender',
                                            style: TextStyle(
                                                color: SkinCubit()
                                                    .get(context)
                                                    .colorBotum()!,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            color: SkinCubit()
                                                .get(context)
                                                .colorBotum()!,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          icon: Icon(
                                              Icons.account_circle_outlined,
                                              size: 80),
                                          iconColor: Color(0xff205072),
                                          titlePadding: EdgeInsets.all(20),
                                          titleTextStyle: TextStyle(
                                              color: Color(0xff205072),
                                              fontWeight: FontWeight.bold),
                                          content: TextFormField(
                                              controller: genderController,
                                              decoration: const InputDecoration(
                                                focusColor: Colors.white,
                                                labelText: 'Gender',
                                                border: OutlineInputBorder(),
                                              ),
                                              onChanged: (value) =>
                                                  print(value),
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Gender must not be empty ';
                                                } else {
                                                  CachHelper
                                                      .PutDataOfTextFormFiled(
                                                          value: value,
                                                          key: 'gender');
                                                }
                                                return null;
                                              }),
                                          contentTextStyle: TextStyle(
                                              color: Color(0xff205072)),
                                        );
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: SkinCubit()
                                            .get(context)
                                            .colorBotum()!,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    height: 40,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Text(
                                            'Enter Skin Color',
                                            style: TextStyle(
                                                color: SkinCubit()
                                                    .get(context)
                                                    .colorBotum()!,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            color: SkinCubit()
                                                .get(context)
                                                .colorBotum()!,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          icon: Icon(
                                              Icons.accessibility_new_sharp,
                                              size: 80),
                                          iconColor: Color(0xff205072),
                                          titlePadding: EdgeInsets.all(20),
                                          titleTextStyle: TextStyle(
                                              color: Color(0xff205072),
                                              fontWeight: FontWeight.bold),
                                          content: TextFormField(
                                              controller: colorController,
                                              decoration: const InputDecoration(
                                                focusColor: Colors.white,
                                                labelText: 'Skin Color',
                                                border: OutlineInputBorder(),
                                              ),
                                              onChanged: (value) =>
                                                  print(value),
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Skin Color must not be empty ';
                                                } else {
                                                  CachHelper
                                                      .PutDataOfTextFormFiled(
                                                          value: value,
                                                          key: 'color');
                                                }
                                                return null;
                                              }),
                                          contentTextStyle: TextStyle(
                                              color: Color(0xff205072)),
                                        );
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  height: 80,
                                  width: 80,
                                  child: Image(
                                    image: NetworkImage(
                                        'https://th.bing.com/th/id/R.cd742b441b1a8b2384faaecae8062f00?rik=Xgcu1hsgda6WUQ&pid=ImgRaw&r=0'),
                                    width: double.infinity,
                                    // fit: BoxFit.cover,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )),
              ]),
            ),
          );
        });
  }
}
