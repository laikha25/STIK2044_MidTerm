import 'dart:convert';

class Room {
  String roomId;
  String contact;
  String title;
  String description;
  String price;
  String deposit;
  String state;
  String area;
  String date;
  String latitude;
  String longitude;

  Room({
    required this.roomId,
    required this.contact,
    required this.title,
    required this.description,
    required this.price,
    required this.deposit,
    required this.state,
    required this.area,
    required this.date,
    required this.latitude,
    required this.longitude,
  });

  // Return object from JSON //
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json['roomid'],
      contact: json['contact'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      deposit: json['deposit'],
      state: json['state'],
      area: json['area'],
      date: json['date_created'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  static List<Room> parseRoom(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Room>((json) => Room.fromJson(json)).toList();
  }
}
