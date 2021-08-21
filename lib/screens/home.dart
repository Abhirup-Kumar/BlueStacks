import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  static const String path = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<JsonData> ftrValue;
  String globalCursor = "";

  @override
  void initState() {
    super.initState();
    ftrValue = fetchData(globalCursor);
  }

  Container buildContainer(String score, String text1, String text2, Color clr,
      double tl, double bl, double tr, double br) {
    return Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: clr,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(tl),
            bottomLeft: Radius.circular(bl),
            topRight: Radius.circular(tr),
            bottomRight: Radius.circular(br),
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                score,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(text1,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15)),
            Text(text2,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15)),
          ],
        ));
  }

  Padding buildPadding(Padding forchild, BorderRadius br) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        width: double.infinity,
        height: 35.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: br,
        ),
        child: forchild,
      ),
    );
  }

  Text buildText(String text, Color clr, double fz, bool fw) {
    return Text(
      text,
      style: TextStyle(
          color: clr, fontSize: fz, fontWeight: fw ? FontWeight.w500 : null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () => null,
        ),
        title: Text(
          'Flyingwolf',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        elevation: 0, //remove the elevation
        backgroundColor: Colors.blueGrey.shade50,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset('assets/images/profile.jpg'),
                  ),
                  radius: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildText('Simon Baker', Colors.black, 22, true),
                      Container(
                          height: 43,
                          width: 160,
                          margin: EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: buildText('2250', Colors.blue, 20, true),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: buildText(
                                    'Elo rating', Colors.black, 15, false),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(30.0),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 90,
            width: double.infinity,
            margin: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: buildContainer(
                    '34',
                    'Tournaments',
                    'played',
                    Colors.yellow.shade700,
                    30,
                    30,
                    0,
                    0,
                  ),
                ),
                SizedBox(
                  width: 1,
                ),
                Expanded(
                  child: buildContainer(
                    '09',
                    'Tournaments',
                    'won',
                    Colors.purple,
                    0,
                    0,
                    0,
                    0,
                  ),
                ),
                SizedBox(
                  width: 1,
                ),
                Expanded(
                  child: buildContainer(
                    '26%',
                    'Winning',
                    'percentage',
                    Colors.redAccent,
                    0,
                    0,
                    30,
                    30,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Recommended for you',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: FutureBuilder<JsonData>(
              future: ftrValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  JsonData data = snapshot.data as JsonData;

                  return ListView.builder(
                      itemCount:
                          100, //in the api call, there were 100 game-names.
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        globalCursor = data.cursor;

                        return Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            height: 150,
                            color: Colors.blueGrey[50],
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Container(
                                    height: 85,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(data.results
                                            .elementAt(index)
                                            .coverUrl),
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: buildPadding(
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          data.results.elementAt(index).name,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15)),
                                    ),
                                    BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(0.0),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: buildPadding(
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        data.results.elementAt(index).gameName,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                    ),
                                    BorderRadius.only(
                                      bottomLeft: Radius.circular(30.0),
                                      bottomRight: Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<JsonData> fetchData(String cursor) async {
  final response = await http.get(Uri.parse(
      'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=100&status=all'));
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    JsonData val = JsonData.fromJson(data);
    return val;
  } else {
    throw Exception('Network Error!');
  }
}

class JsonData {
  final List<Values> results;
  String cursor = "";

  JsonData({required this.results, required this.cursor});

  factory JsonData.fromJson(Map<String, dynamic> data) {
    var list = data['data']['tournaments'] as List;
    List<Values> valuesList = list.map((e) => Values.fromJson(e)).toList();

    return JsonData(results: valuesList, cursor: data['data']['cursor']);
  }
}

class Values {
  final String gameName;
  final String name;
  final String coverUrl;

  Values({required this.gameName, required this.name, required this.coverUrl});

  factory Values.fromJson(Map<String, dynamic> loaded) {
    return Values(
        gameName: loaded['game_name'],
        name: loaded['name'],
        coverUrl: loaded['cover_url']);
  }
}
