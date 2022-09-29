import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api.dart';
import 'models/song.dart';

class ShowSongScreen extends StatefulWidget {
  final int songId;
  final String songTitle;
  const ShowSongScreen({Key? key, required this.songId, required this.songTitle}) : super(key: key);

  @override
  State<ShowSongScreen> createState() => _ShowSongScreenState();
}


class _ShowSongScreenState extends State<ShowSongScreen> {
  late Future<Song> futureSong;

  @override
  Widget build(BuildContext context) {
    futureSong = API().fetchSongByID(widget.songId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scoutify",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                child: Text(
                  widget.songTitle,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                padding: EdgeInsets.fromLTRB(10, 8, 5, 8),

              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    FutureBuilder<Song>(
                      future: futureSong,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Song song = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: song.lyrics.length,
                            itemBuilder: (context, index) {
                              return Text(
                                song.lyrics[index],
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              );
                            }
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
