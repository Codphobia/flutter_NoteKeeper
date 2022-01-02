import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:notekeeper/db/data_base_helper.dart';
import 'package:notekeeper/model/note_keeper.dart';

import 'description.dart';

class DataListView extends StatefulWidget {
  const DataListView({Key? key}) : super(key: key);

  @override
  _DataListViewState createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {
  var formkey = GlobalKey<FormState>();
  var title = '';
  var subTitle = '';
  var description = '';
  int? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.grey[500],
            elevation: 8,
            floating: true,
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Lottie.asset('assets/notekeeper.json'),
              title: const Text(
                'Note Keeper List',
                style: TextStyle(
                  letterSpacing: 2,
                  wordSpacing: 2,
                  fontSize: 15,
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              FutureBuilder<List<NoteKeeper>>(
                future: DatabaseHelper.instance.getAllRecord(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      const Center(
                        child: Text('Record not yet Stored'),
                      );
                    } else {
                      List<NoteKeeper> notekeepers = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: notekeepers.length,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          NoteKeeper noteKeeper = notekeepers[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return Description(noteKeeper: noteKeeper);
                                  },
                                ));
                              },
                              child: Card(
                                color: Colors.white,
                                child: Column(
                                  children: [

                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Text(
                                            noteKeeper.title,
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              letterSpacing: 3,
                                              fontSize: 15,
                                            ),
                                          ),
                                          subtitle: Text(
                                            noteKeeper.subTitle,
                                            style: const TextStyle(
                                              color: Colors.blueGrey,
                                              letterSpacing: 3,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: const Text(
                                                    'Conformation..!',
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 12,
                                                      wordSpacing: 2,
                                                      letterSpacing: 3,
                                                    ),
                                                  ),
                                                  content: const Text(
                                                    'Are You Sure Want to Delete This note..?',
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      wordSpacing: 2,
                                                      letterSpacing: 3,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () async {
                                                            await DatabaseHelper
                                                                .instance
                                                                .deleteNoteKeeperRecord(
                                                                noteKeeper
                                                                    .id!);
                                                            Navigator.of(
                                                                context)
                                                                .pop();
                                                            setState(() {});
                                                          },
                                                          child:
                                                          const Text('Yes'),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                            Colors.blueGrey,
                                                            onPrimary:
                                                            Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 25,
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                context)
                                                                .pop();
                                                          },
                                                          child:
                                                          const Text('No'),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                            Colors.blueGrey,
                                                            onPrimary:
                                                            Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  scrollable: true,
                                                  backgroundColor: Colors.white,
                                                  title: const Text(
                                                    'Update Note',
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                    ),
                                                  ),
                                                  actions: [
                                                    Form(
                                                      key: formkey,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                        children: [
                                                          TextFormField(
                                                              initialValue:
                                                              noteKeeper
                                                                  .title,
                                                              cursorColor:
                                                              Colors
                                                                  .blueGrey,
                                                              decoration:
                                                              const InputDecoration(
                                                                focusedBorder:
                                                                UnderlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .zero,
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                UnderlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                                hintText:
                                                                'Title',
                                                                hintStyle:
                                                                TextStyle(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              validator:
                                                                  (text) {
                                                                if (text!
                                                                    .isEmpty) {
                                                                  return 'please provide your title';
                                                                } else {
                                                                  title = text;
                                                                  return null;
                                                                }
                                                              }),
                                                          TextFormField(
                                                              initialValue:
                                                              noteKeeper
                                                                  .subTitle,
                                                              cursorColor:
                                                              Colors
                                                                  .blueGrey,
                                                              maxLength: 50,
                                                              maxLines: 2,
                                                              decoration:
                                                              const InputDecoration(
                                                                hintText:
                                                                'SubTitle',
                                                                hintStyle:
                                                                TextStyle(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  fontSize: 15,
                                                                ),
                                                                focusedBorder:
                                                                UnderlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .zero,
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                UnderlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                              ),
                                                              validator:
                                                                  (text) {
                                                                if (text!
                                                                    .isEmpty) {
                                                                  return 'please provide your SubTitle';
                                                                } else {
                                                                  subTitle =
                                                                      text;
                                                                  return null;
                                                                }
                                                              }),
                                                          TextFormField(
                                                              initialValue:
                                                              noteKeeper
                                                                  .description,
                                                              cursorColor:
                                                              Colors.blue,
                                                              maxLines: 6,
                                                              maxLength: 200,
                                                              decoration:
                                                              const InputDecoration(
                                                                hintText:
                                                                'Description',
                                                                hintStyle:
                                                                TextStyle(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  fontSize: 15,
                                                                ),
                                                                focusedBorder:
                                                                UnderlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .zero,
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                UnderlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                              ),
                                                              validator:
                                                                  (text) {
                                                                if (text!
                                                                    .isEmpty) {
                                                                  return 'please provide your description';
                                                                } else {
                                                                  description =
                                                                      text;
                                                                  return null;
                                                                }
                                                              }),
                                                          ElevatedButton(
                                                            style:
                                                            ElevatedButton
                                                                .styleFrom(
                                                              primary: Colors
                                                                  .blueGrey,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              if (formkey
                                                                  .currentState!
                                                                  .validate()) {
                                                                NoteKeeper nk = NoteKeeper(
                                                                    id: noteKeeper
                                                                        .id,
                                                                    title:
                                                                    title,
                                                                    subTitle:
                                                                    subTitle,
                                                                    description:
                                                                    description);
                                                                int result =
                                                                await DatabaseHelper
                                                                    .instance
                                                                    .updateNoteKeeperRecord(
                                                                    nk);
                                                                if (result >
                                                                    0) {
                                                                  Fluttertoast
                                                                      .showToast(
                                                                      msg:
                                                                      'update..');
                                                                  formkey
                                                                      .currentState!
                                                                      .reset();
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop();
                                                                } else {
                                                                  Fluttertoast
                                                                      .showToast(
                                                                      msg:
                                                                      'Failed');
                                                                }
                                                                setState(() {});
                                                              }
                                                            },
                                                            child: const Text(
                                                                'Update'),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }

                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 200,
                        ),
                        Text(
                          'Record not yet Stored',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
