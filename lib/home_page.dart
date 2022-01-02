import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:notekeeper/db/data_base_helper.dart';
import 'package:notekeeper/model/note_keeper.dart';
import 'package:notekeeper/screens/data_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var formkey = GlobalKey<FormState>();
  late String title, subTitle, description;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[500],
          centerTitle: true,
          title: const Text(
            'Note Keeper ',
            style: TextStyle(
              letterSpacing: 5,
              wordSpacing: 5,
              fontSize: 20,
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[500],
        body: Column(
          children: [
            Divider(
              height: 2,
              color: Colors.grey[700],
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
                flex: 10,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Lottie.asset('assets/notekeeper.json'),
                )),
            Expanded(
              flex: 12,
              child: Container(
                alignment: Alignment.topCenter,
                color: Colors.blue[800],
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -28.0,
                      width: 350,
                      child: FloatingActionButton(
                        heroTag: const Text("btn1"),
                        elevation: 15,
                        backgroundColor: Colors.grey[500],
                        child: const Icon(
                          Icons.add,
                          size: 25,
                        ),
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                scrollable: true,
                                backgroundColor: Colors.white,
                                title: const Text(
                                  'Add Note',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 20,
                                  ),
                                ),
                                actions: [
                                  Form(
                                    key: formkey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        TextFormField(
                                            cursorColor: Colors.blueGrey,
                                            decoration: const InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderRadius: BorderRadius.zero,
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              hintText: 'Title',
                                              hintStyle: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 15,
                                              ),
                                            ),
                                            validator: (text) {
                                              if (text!.isEmpty) {
                                                return 'please provide your title';
                                              } else {
                                                title = text;
                                                return null;
                                              }
                                            }),
                                        TextFormField(
                                            cursorColor: Colors.blueGrey,
                                            maxLength: 50,
                                            maxLines: 2,
                                            decoration: const InputDecoration(
                                              hintText: 'SubTitle',
                                              hintStyle: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 15,
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderRadius: BorderRadius.zero,
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            validator: (text) {
                                              if (text!.isEmpty) {
                                                return 'please provide your SubTitle';
                                              } else {
                                                subTitle = text;
                                                return null;
                                              }
                                            }),
                                        TextFormField(
                                            cursorColor: Colors.blue,
                                            maxLines: 6,
                                            maxLength: 200,
                                            decoration: const InputDecoration(
                                              hintText: 'Description',
                                              hintStyle: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 15,
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderRadius: BorderRadius.zero,
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            validator: (text) {
                                              if (text!.isEmpty) {
                                                return 'please provide your description';
                                              } else {
                                                description = text;
                                                return null;
                                              }
                                            }),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blueGrey,
                                          ),
                                          onPressed: () async {
                                            if (formkey.currentState!
                                                .validate()) {
                                              NoteKeeper noteKeeper =
                                                  NoteKeeper(
                                                      title: title,
                                                      subTitle: subTitle,
                                                      description: description);
                                              int result = await DatabaseHelper
                                                  .instance
                                                  .insertNoteKeeperRecord(
                                                      noteKeeper);
                                              if (result > 0) {
                                                Fluttertoast.showToast(
                                                    msg: 'Saved..');
                                                formkey.currentState!.reset();
                                                Navigator.of(context).pop();
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: 'Failed');
                                              }
                                            }
                                          },
                                          child: const Text('Saved'),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: -14.0,
                      width: 350,
                      child: FloatingActionButton(
                          heroTag: const Text("btn2"),
                          elevation: 15,
                          backgroundColor: Colors.grey[500],
                          child: const Icon(
                            Icons.arrow_forward,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return const DataListView();
                                },
                              ));
                            });
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.grey[500],
            ))
          ],
        ),
      ),
    );
  }
}
