import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notekeeper/model/note_keeper.dart';

class Description extends StatefulWidget {
  NoteKeeper noteKeeper;

  Description({Key? key, required this.noteKeeper}) : super(key: key);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
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
                'Description Screen',
                style: TextStyle(
                  letterSpacing: 2,
                  wordSpacing: 2,
                  fontSize: 15,
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                verticalDirection: VerticalDirection.down,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.noteKeeper.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(widget.noteKeeper.subTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(widget.noteKeeper.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
