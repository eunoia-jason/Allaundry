import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class UsageDetails extends StatefulWidget {
  const UsageDetails({Key? key}) : super(key: key);

  @override
  State<UsageDetails> createState() => _UsageDetailsState();
}

class _UsageDetailsState extends State<UsageDetails> {
  List<Card> _buildListCards(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    var ss = snapshot.data;
    List<Card> result = [];

    if (ss != null) {
      if (ss.docs.isEmpty) {
        return const <Card>[];
      }
    }

    if (ss != null) {
      result = ss.docs.map((doc) {
        Product current = Product(
          cleaner: doc['cleaner'] as String,
          price: double.parse(doc['price'].toString()),
          iconUrl: doc['iconUrl'] as String,
          timestamp: doc['timestamp'] as Timestamp,
          progress: doc['progress'] as bool,
        );

        // List<Icon> stars = [];
        // for (int i=0;i<product.star;i++) {
        //   stars.add(const Icon(Icons.star, color: Colors.yellow, size: 15));
        // }

        return Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  DateFormat('M/dd (E) ').format(current.timestamp
                      .toDate()) +
                      (current.progress == true ? '진행중' : '완료'),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(width: 40),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    width: 100,
                    height: 100,
                    child: AspectRatio(
                      aspectRatio: 1.0 / 1.0,
                      child: Image.network(
                        current.iconUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        current.cleaner,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        NumberFormat('###,###,###,###').format(current.price).replaceAll(' ', '') + '원',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList();
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('order').orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _buildListCards(context, snapshot)[index];
            },
            itemCount: _buildListCards(context, snapshot).length,
          ),
        );
      }
    );
  }
}

class Product {
  const Product({
    required this.cleaner,
    required this.price,
    required this.iconUrl,
    required this.timestamp,
    required this.progress,
  });

  final String cleaner;
  final double price;
  final String iconUrl;
  final Timestamp timestamp;
  final bool progress;
}