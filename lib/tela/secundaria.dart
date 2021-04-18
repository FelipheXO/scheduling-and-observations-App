import 'package:flutter/material.dart';
import 'package:hg/tela/model/data.dart';
import 'package:hg/tela/model/acoes.dart';

class Secundaria extends StatefulWidget {
  @override
  _SecundariaState createState() => _SecundariaState();
}

class _SecundariaState extends State<Secundaria> {
  List<Item> data;
  final banco = Banco.instance;

  _SecundariaState() {
    data = new List<Item>();
    load();
  }

  Future load() async {
    final listatemp = await banco.getall();
    setState(() {
      data = listatemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, int index) {
          final datas = data[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFF0D0C0E),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.red),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Expanded(
                        child: Text(
                          "${datas.title}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
