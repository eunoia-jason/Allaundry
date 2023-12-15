import 'package:flutter/material.dart';

import 'login.dart';

class My extends StatefulWidget {
  const My({Key? key}) : super(key: key);

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(url),
              ),
              const SizedBox(width: 20),
              Text(
                name + ' 님',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.paid_outlined,
                            size: 30,
                          ),
                        ),
                        const Text(
                          '포인트',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.money,
                            size: 30,
                          ),
                        ),
                        const Text(
                          '쿠폰함',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.wallet_giftcard,
                            size: 30,
                          ),
                        ),
                        const Text(
                          '선물함',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 30,
                          ),
                        ),
                        const Text(
                          '찜',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: (() {}),
                          icon: const Icon(
                            Icons.description_outlined,
                            size: 30,
                          ),
                        ),
                        const Text(
                          '주문통계',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.stars_outlined,
                            size: 30,
                          ),
                        ),
                        const Text(
                          '리뷰관리',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          Row(
            children: const [
              Expanded(
                child:Text(
                  '공지사항',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 35,
                color: Colors.grey,
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          const SizedBox(height: 10),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          Row(
            children: const [
              Expanded(
                child:Text(
                  '이벤트',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 35,
                color: Colors.grey,
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          const SizedBox(height: 10),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          Row(
            children: const [
              Expanded(
                child:Text(
                  '환경설정',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 35,
                color: Colors.grey,
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}