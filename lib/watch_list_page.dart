import 'package:flutter/material.dart';
import 'film.dart';
import 'horizontal_card.dart';
import 'main.dart';

class WatchListPage extends StatefulWidget {
  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  String dropdownvalue = 'Default';

  @override
  Widget build(BuildContext context) {
    List<Film> sortedWatchList = [];

    return Scaffold(
      appBar: AppBar(
        title:
            Align(alignment: Alignment.center, child: const Text('Watch List')),
        titleTextStyle: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
      ),
      body: FutureBuilder<List<Film>>(
          future: filmDao.findAllFilms(),
          builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                sortedWatchList = snapshot.data!;
                switch (dropdownvalue) {
                  case 'Title':
                    sortedWatchList.sort((a, b) => a.title.compareTo(b.title));
                  case 'Release date':
                    sortedWatchList
                        .sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
                }
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: const Text('Sort by',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black))),
                            Spacer(),
                            Align(
                                alignment: Alignment.centerRight,
                                child: DropdownButton<String>(
                                  value: dropdownvalue,
                                  items: <String>[
                                    'Default',
                                    'Title',
                                    'Release date'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                    });
                                  },
                                )),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text('You have '
                          '${sortedWatchList.length} in watch list:'),
                    ),
                    for (var film in sortedWatchList)
                      HorizontalCard(film: film),
                  ],
                );
            }
          }),
    );
  }
}
