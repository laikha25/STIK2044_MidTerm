import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rentaroom/room.dart';
import 'package:http/http.dart' as http;

class GridDetails extends StatefulWidget {
  final Room user;
  const GridDetails({Key? key, required this.user}) : super(key: key);

  @override
  GridDetailsState createState() => GridDetailsState();
}

class GridDetailsState extends State<GridDetails> {
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.user.title),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
              flex: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.network(
                          'https://slumberjer.com/rentaroom/images/2_1.jpg'),
                      Image.network(
                          'https://slumberjer.com/rentaroom/images/2_2.jpg'),
                      Image.network(
                          'https://slumberjer.com/rentaroom/images/2_3.jpg')
                    ],
                  ))
                ],
              )),
          Flexible(
            flex: 50,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  const Text(""),
                  const Text("DESCRIPTION",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text(""),
                  Table(
                    columnWidths: const {0: FractionColumnWidth(.35)},
                    children: [
                      TableRow(children: [
                        const Text("Contact No.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(widget.user.contact,
                            style: const TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.normal,
                                color: Colors.black)),
                      ]),
                      TableRow(children: [
                        const Text("Description",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(widget.user.description,
                            style: const TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.normal,
                                color: Colors.black))
                      ]),
                      TableRow(children: [
                        const Text("Price",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Text("RM " + widget.user.price,
                            style: const TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.normal,
                                color: Colors.black))
                      ]),
                      TableRow(children: [
                        const Text("Deposit",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Text("RM " + widget.user.deposit,
                            style: const TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.normal,
                                color: Colors.black))
                      ]),
                      TableRow(children: [
                        const Text("State",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(widget.user.state,
                            style: const TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.normal,
                                color: Colors.black))
                      ]),
                      TableRow(children: [
                        const Text('Area',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(widget.user.area,
                            style: const TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.normal,
                                color: Colors.black))
                      ]),
                      TableRow(children: [
                        const Text("Date Created",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(widget.user.date,
                            style: const TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.normal,
                                color: Colors.black))
                      ]),
                      TableRow(children: [
                        const Text('Latitude',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(widget.user.latitude,
                            style: const TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.normal,
                                color: Colors.black))
                      ]),
                      TableRow(children: [
                        const Text("Longitude",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(widget.user.longitude,
                            style: const TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.normal,
                                color: Colors.black))
                      ]),
                      TableRow(children: [
                        const Text("Longitude",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.transparent)),
                        Text(widget.user.longitude,
                            style: const TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.normal,
                                color: Colors.transparent))
                      ])
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
