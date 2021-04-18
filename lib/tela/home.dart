import 'package:flutter/material.dart';
import 'package:hg/tela/model/data.dart';
import 'package:hg/tela/model/acoes.dart';
import 'package:hg/tela/secundaria.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController ob = TextEditingController();
  List<Item> data;
  final banco = Banco.instance;

  _HomeState() {
    data = new List<Item>();
    load();
  }

  Future load() async {
    final listatemp = await banco.getall();
    setState(() {
      data = listatemp;
    });
  }

  Future<void> add(String texto) async {
    if (ob.text.isEmpty) return;
    setState(() {
      Item item = Item(title: "${ob.text}");
      banco.insertItem(item.toJson());
      ob.clear();
    });
    await load();
  }

  Future<void> remove(id) async {
    await banco.deleteItem('$id');
    await load();
  }

  TimeOfDay tempoagora = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (tempoagora.minute != TimeOfDay.now().minute) {
        setState(() {
          tempoagora = TimeOfDay.now();
        });
      }
    });
  }

  // alert

  String selected; //mes
  String selected2; //dia

  showAlertDialog(BuildContext context) {
    AlertDialog alerta = AlertDialog(
      title: Text("Marcador Dia"),
      content: Container(
          height: 100,
          child: Expanded(
              child: Column(
            children: [
              TextField(
                controller: ob,
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Observações'),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selected,
                      items: [
                        "Jan",
                        "Fev",
                        "Mar",
                        "Abr",
                        "Mai",
                        "Jun",
                        "Jul",
                        "Ago",
                        "Set",
                        "Out",
                        "Nov",
                        "Dez"
                      ]
                          .map((label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => selected = value);
                      },
                    ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selected2,
                      items: [
                        "1",
                        "2",
                        "3",
                        "4",
                        "5",
                        "6",
                        "7",
                        "8",
                        "9",
                        "10",
                        "11",
                        "12",
                        "13",
                        "14",
                        "15",
                        "16",
                        "17",
                        "18",
                        "19",
                        "20",
                        "21",
                        "22",
                        "23",
                        "24",
                        "25",
                        "26",
                        "27",
                        "28",
                        "29",
                        "30",
                        "31"
                      ]
                          .map((label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => selected2 = value);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ))),
      actions: <Widget>[
        FlatButton(
          child: Text('Voltar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Salvar'),
          onPressed: () {
            add(ob.value.text);
            ob.clear();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime tempoagora2 = DateTime.now();
    String formatado = DateFormat('kk:mm').format(tempoagora2);
    String periodo = tempoagora.period == DayPeriod.am ? "AM" : "PM";
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.black26,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showAlertDialog(context);
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.red,
          ),
          body: SafeArea(
            child: TabBarView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            formatado,
                            style: TextStyle(color: Colors.white, fontSize: 80),
                          ),
                          SizedBox(width: 2),
                          RotatedBox(
                            quarterTurns: 3,
                            child: Text(periodo,
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 4, width: 50, color: Colors.red),
                    // start
                    Secundaria(),
                  ],
                ),
                ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    final datas = data[index];
                    return Column(
                      children: <Widget>[
                        Dismissible(
                          child: Expanded(
                            child: Container(
                              padding: EdgeInsets.all(15),
                              width: 380,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF0D0C0E),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "${datas.id}",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 25),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            data.removeAt(index);
                                            remove(datas.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "${datas.title}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          key: Key(datas.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              remove(datas.id);
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 70,
            child: TabBar(tabs: [
              Tab(
                icon: Icon(
                  Icons.alarm,
                  color: Colors.grey,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.alarm_add,
                  color: Colors.grey,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
