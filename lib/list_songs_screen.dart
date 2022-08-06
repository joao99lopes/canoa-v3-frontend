import 'package:canoa_v3_frontend/models/search_song.dart';
import 'package:canoa_v3_frontend/models/song.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:canoa_v3_frontend/api.dart';

class ListSongsScreen extends StatefulWidget {
  const ListSongsScreen({Key? key}) : super(key: key);

  @override
  State<ListSongsScreen> createState() => _ListSongsScreenState();
}

class _ListSongsScreenState extends State<ListSongsScreen> {
  String dropdownValue = "Most Recent";
  Future<List<SearchSong>> futureSongs = API.fetchAvailableSongs();

  var items = [
    "Alphabetically",
    "Most Recent",
    "Oldest"
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("HELLO"),
      centerTitle: true,
    ),
    body: Row(
      children: [
        Expanded(
          child: Column(
            children: [
                Center(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: FutureBuilder<List<SearchSong>>(
                        future: futureSongs,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<SearchSong> songs = sortSongs(snapshot.data!, dropdownValue);
                            print("LENGTH - ${songs.length}");
                            return buildSongs(songs);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Align(
                alignment: Alignment.topRight,
                child: DropdownButton(
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget buildSongs(List<SearchSong> songs) => ListView.builder(
      itemCount: songs.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final song = songs[index];

        return Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(song.title),
            ],
          ),
          color: Colors.white,
          margin: EdgeInsets.all(8),

        );
      },
  );

  List<SearchSong> sortSongs(List<SearchSong> list, String sortBy) {
    List<SearchSong> res = list;
    if (sortBy == "Most Recent") {
      res.sort((a, b) => a.id.compareTo(b.id));
    }
    else if (sortBy == "Oldest") {
      res.sort((a, b) => (a.id*-1).compareTo(b.id*-1));
    }
    else if (sortBy == "Alphabetically") {
      res.sort((a, b) => a.title.compareTo(b.title));
    }
    return res;
  }
}

