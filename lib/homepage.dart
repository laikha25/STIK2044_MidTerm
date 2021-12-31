import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentaroom/details.dart';
import 'package:rentaroom/room.dart';

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse = "";
  Map mapResponse = {};
  List listOfRooms = [];

  Future fetchData() async {
    http.Response response;
    response = await http
        .get(Uri.parse('https://slumberjer.com/rentaroom/php/load_rooms.php'));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listOfRooms = mapResponse['data']['rooms'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: listOfRooms.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              elevation: 5.0,
              child: InkWell(
                onTap: () => {_roomDetails(index)},
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 55,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://slumberjer.com/rentaroom/images/" +
                                    listOfRooms[index]['roomid'].toString() +
                                    "_" +
                                    "1.jpg",
                            imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            )),
                            placeholder: (context, url) =>
                                const LinearProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Text(
                          listOfRooms[index]['title'].toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("Price: " + "RM " + listOfRooms[index]['price']),
                        Text("Deposit: " +
                            "RM " +
                            listOfRooms[index]['deposit']),
                        Text("Area: " + listOfRooms[index]['area'])
                      ]),
                ),
              ));
        },
      ),
    );
  }

  _roomDetails(int index) async {
    Room room = Room(
      roomId: listOfRooms[index]['roomid'],
      contact: listOfRooms[index]['contact'],
      title: listOfRooms[index]['title'],
      description: listOfRooms[index]['description'],
      price: listOfRooms[index]['price'],
      deposit: listOfRooms[index]['deposit'],
      state: listOfRooms[index]['state'],
      area: listOfRooms[index]['area'],
      date: listOfRooms[index]['date_created'],
      latitude: listOfRooms[index]['latitude'],
      longitude: listOfRooms[index]['longitude'],
    );
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => GridDetails(user: room)));
  }
}
