import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail.dart';
import 'product.dart';

class Laundry extends StatefulWidget {
  const Laundry({Key? key}) : super(key: key);

  @override
  State<Laundry> createState() => _LaundryState();
}

class _LaundryState extends State<Laundry> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
    super.initState();
  }

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
          expect: doc['expect'] as String,
          least: doc['least'] as int,
          reviews: doc['reviews'] as int,
          telephone: doc['telephone'] as String,
          tips: doc['tips'] as int,
          stars: doc['stars'] as int,
          iconUrl: doc['iconUrl'] as String,
          photoUrl: doc['photoUrl'] as String,
        );

        return Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
                  Expanded(
                    child: Column(
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
                          'Tel. ' + current.telephone,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '최소주문 ${current.least}원  배달팁 ${current.tips}원',
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 7,
                child: TextButton(
                  child: const Text('more'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(laundry: current),
                      ),
                    );
                  },
                ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          TabBar(
            tabs: const [
              Text(
                '수거 & 배송',
              ),
              Text(
                '수거',
              ),
              Text(
                '배송',
              ),
              Text(
                '방문',
              ),
            ],
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey,
            controller: _tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20,20,20,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '우리 동네 인기 세탁소',
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('collect&logistics')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return _buildListCards(context, snapshot)[index];
                                },
                                itemCount: _buildListCards(context, snapshot).length,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20,20,20,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '우리 동네 인기 세탁소',
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('collect')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return _buildListCards(context, snapshot)[index];
                                },
                                itemCount: _buildListCards(context, snapshot).length,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20,20,20,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '우리 동네 인기 세탁소',
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('logistics')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return _buildListCards(context, snapshot)[index];
                                },
                                itemCount: _buildListCards(context, snapshot).length,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20,20,20,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '우리 동네 인기 세탁소',
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('visiting')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return _buildListCards(context, snapshot)[index];
                                },
                                itemCount: _buildListCards(context, snapshot).length,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}