// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'product.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.laundry}) : super(key: key);

  final Product laundry;

  @override
  State<DetailPage> createState() => _DetailPageState(laundry);
}

class _DetailPageState extends State<DetailPage> {
  Product laundry;
  _DetailPageState(this.laundry);
  double _y = 0;
  double _t = 0;
  double _p = 0;
  double _b = 0;

  Future order(BuildContext context) async {
    final DocumentReference doc = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('order')
        .doc();

    try {
      // 문서 작성
      await doc.set({
        'cleaner': laundry.cleaner,
        'price': (2500*_y+4000*_t+5000*_b+4000*_p).toInt(),
        'iconUrl': laundry.iconUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'progress': true,
      });
    } catch (e) {
      e == 'canceled';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Stack(
                  children: [
                    laundry.photoUrl != ''
                    ? Image.network(
                      laundry.photoUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                    : const SizedBox(
                      width: double.infinity,
                      height: 340,
                      child: Center(
                        child: Icon(
                          Icons.photo,
                          size: 100,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      laundry.cleaner,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < laundry.stars; i++)
                          Icon(Icons.star, color: Theme.of(context).primaryColor, size: 25),
                        const SizedBox(width: 10),
                        Text(
                          '${laundry.stars}',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '리뷰 수 ' + NumberFormat('###,###,###,###').format(laundry.reviews).replaceAll(' ', ''),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('전화번호 : ${laundry.telephone}')),
                            );
                          },
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          label: const Text(
                            '전화',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                          label: const Text(
                            '찜',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.ios_share,
                            color: Colors.black,
                          ),
                          label: const Text(
                            '공유',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 10,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '최소 금액        ' + NumberFormat('###,###,###,###').format(laundry.least).replaceAll(' ', '') + '원',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '예상 기간        ${laundry.expect}일 소요예상',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '배달팁             ' + NumberFormat('###,###,###,###').format(laundry.tips).replaceAll(' ', '') + '원',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '세탁 품목',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SpinBox(
                        max: 10,
                        value: _y,
                        decoration: const InputDecoration(
                          labelText: '와이셔츠 (2,500원)',
                        ),
                        onChanged: (count) => setState(() {
                          _y = count;
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SpinBox(
                        max: 10,
                        value: _t,
                        decoration: const InputDecoration(
                          labelText: '티셔츠 (4,000원)',
                        ),
                        onChanged: (count) => setState(() {
                          _t = count;
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SpinBox(
                        max: 10,
                        value: _b,
                        decoration: const InputDecoration(
                          labelText: '이불 (5,000원)',
                        ),
                        onChanged: (count) => setState(() {
                          _b = count;
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SpinBox(
                        max: 10,
                        value: _p,
                        decoration: const InputDecoration(
                          labelText: '바지 (4,000원)',
                        ),
                        onChanged: (count) => setState(() {
                          _p = count;
                        }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                if (2500*_y+4000*_t+5000*_b+4000*_p < laundry.least) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('최소 금액을 지켜주세요!')),
                  );
                }
                else {
                  order(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('주문되었습니다!')),
                  );
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                '주문하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
