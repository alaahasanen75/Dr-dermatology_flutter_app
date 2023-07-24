import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skin_detection/article_item.dart';
import 'package:skin_detection/cubit/skin_cubit.dart';
import 'package:skin_detection/utilites/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final picker = ImagePicker();
  File? image;

  Future pickImageGallery() async {
    XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    Navigator.pop(context);
    setState(() {
      image = File(pickedFile!.path);
    });
  }

  GlobalKey<ScaffoldState> scafold = new GlobalKey<ScaffoldState>();
  Future pickImageCamera() async {
    PickedFile? pickedFile = await picker.getImage(
      source: ImageSource.camera,
    );
    Navigator.pop(context);
    setState(() {
      image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SkinCubit, SkinState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: scafold,
            body: Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: SkinCubit().get(context).colorBackGround()),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Welcome to Dr Dermatology app !',
                        textStyle: const TextStyle(
                          fontSize: 30.0,
                          color: Colors.white54,
                          fontWeight: FontWeight.w700,
                        ),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    pause: const Duration(milliseconds: 1000),
                  )),
              Container(
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                height: 510.h,
                decoration: BoxDecoration(
                  color: SkinCubit().get(context).colorMode(),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0)),
                ),
                child: BlocProvider(
                  create: (context) => SkinCubit(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        image == null
                            ? CircleAvatar(
                                radius: 100.r,
                                backgroundImage: NetworkImage(
                                    "https://media.istockphoto.com/id/1186895279/photo/human-skin-cross-section-and-hair.jpg?s=1024x1024&w=is&k=20&c=0-CcEmNFXhmNqPkMGMzgaor3_X0AJoxkpodHY_6pNDI="))
                            : CircleAvatar(
                                radius: 100.r,
                                backgroundImage: FileImage(
                                  File(image!.path),
                                ),
                              ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        Container(
                          height: 50.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                              color: SkinCubit().get(context).colorBackGround(),
                              borderRadius: BorderRadius.circular(15)),
                          child: MaterialButton(
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Take Image",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      true, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Choose image'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            OutlinedButton(
                                                onPressed: () {
                                                  pickImageGallery();
                                                },
                                                child: const Text("Gallery")),
                                            OutlinedButton(
                                                onPressed: () {
                                                  pickImageCamera();
                                                },
                                                child: const Text("Camera")),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        state is SkinLoadingState
                            ? const CircularProgressIndicator()
                            : Container(
                                height: 50.h,
                                width: 200.w,
                                decoration: BoxDecoration(
                                    color: image != null
                                        ? SkinCubit()
                                            .get(context)
                                            .colorBackGround()
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: MaterialButton(
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Result",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    onPressed: () {
                                      image != null
                                          ? SkinCubit()
                                              .get(context)
                                              .upload(image: image)
                                          : null;

                                      SkinCubit().get(context).msg == null &&
                                              SkinCubit().get(context).score !=
                                                  '23%'
                                          ? ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: SkinCubit()
                                                      .get(context)
                                                      .colorMode(),
                                                  duration: Duration(
                                                      milliseconds: 5000),
                                                  content: Card(
                                                      elevation: 2,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Container(
                                                        height: 55.h,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            width: 2,
                                                            color: Colors.red
                                                                .withOpacity(
                                                                    .6),
                                                          ),
                                                          color: Colors.amber
                                                              .withOpacity(.4),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                              ' 😥😓Ooh !! So Sorry get well soon',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  fontSize: 19,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ))))
                                          : ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: SkinCubit()
                                                      .get(context)
                                                      .colorMode(),
                                                  duration: Duration(
                                                      milliseconds: 5000),
                                                  content: Card(
                                                      elevation: 2,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Container(
                                                        height: 70.h,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            width: 2,
                                                            color: Colors.red
                                                                .withOpacity(
                                                                    .6),
                                                          ),
                                                          color: Colors.amber
                                                              .withOpacity(.4),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                              '${SkinCubit().get(context).msg} 😍🤩  ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  fontSize: 19,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ))));
                                    }),
                              ),
                        SkinCubit().get(context).result != null
                            ? Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Container(
                                          height: 122.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent
                                                .withOpacity(.3),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  SkinCubit()
                                                      .get(context)
                                                      .result!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    ' Score : ${SkinCubit().get(context).score} ',
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        )),
                                    TextButton(
                                      onPressed: (() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) => Article(
                                                    index: SkinCubit()
                                                        .get(context)
                                                        .BadgeDesease(
                                                            SkinCubit()
                                                                .get(context)
                                                                .result!),
                                                  ))),
                                        );
                                      }),
                                      child: Text(
                                        ' Learn More About This Disease??',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    )
                                  ],
                                ))
                            : Container(
                                height: 1.h,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          );
        });
  }
}
