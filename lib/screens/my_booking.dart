import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/bookingModel.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  Future<List<Bookings>> fetchRecords() async {
    var records = await FirebaseFirestore.instance.collection('booking').get();
    return mapRecords(records);
  }

  List<Bookings> mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map(
          (booking) => Bookings(
            id: booking.id,
            From: booking['From'],
            To: booking['To'],
            Date: booking['Date'],
            Time: booking['Time'],
            Amount: booking['Amount'],
          ),
        )
        .toList();

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              //chip words
              children: <Widget>[
                const SizedBox(height: 10),
                SizedBox(
                    width: width * 0.94,
                    height: height * 0.90,
                    child: FutureBuilder<List<Bookings>>(
                        future: fetchRecords(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<Bookings> data = snapshot.data ?? [];

                            return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return (SizedBox(
                                    height: 100,
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          leading: Text(data[index].From),
                                          title: Text(data[index].To),
                                          subtitle: Text(data[index].Date),
                                          trailing: Text(data[index].Amount),
                                        )
                                      ],
                                    ),
                                  ));
                                });
                          }
                        }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
