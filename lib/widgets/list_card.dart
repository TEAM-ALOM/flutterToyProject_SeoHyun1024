//홈화면 카드들
import 'package:flutter/material.dart';

class ListCard extends StatefulWidget {
  final String name;

  const ListCard({
    super.key,
    required this.name,
  });

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.name,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      initiallyExpanded: false,
      backgroundColor: const Color.fromARGB(255, 235, 238, 175),
      children: <Widget>[
        Column(
          children: [
            const Card(
              // margin: EdgeInsets.symmetric(
              //   vertical: 10,
              //   horizontal: 3,
              // ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 20,
                ),
                child: Text(
                  '할 일이 없습니다!! 그럴 리가 없을텐데!',
                  style: TextStyle(),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 3,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.1,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('아무거나'),
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
