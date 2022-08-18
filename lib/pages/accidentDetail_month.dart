import 'package:accident_statistic/models/accident_items_month.dart';
import 'package:accident_statistic/services/api.dart';
import 'package:accident_statistic/models/DateUtil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccidentDetailMonth extends StatefulWidget {
  static const routeName = '/detailMonth';

  const AccidentDetailMonth({Key? key}) : super(key: key);

  @override
  _AccidentDetailState createState() => _AccidentDetailState();
}

class _AccidentDetailState extends State<AccidentDetailMonth> {
  late Future<List<AccidentMonth>> _accidentFuture;

  Future<List<AccidentMonth>> _fetch(List<String> select) async {
    List list = await Api().fetch('EXAT_Accident/${select[0]}/${select[1]}');
    var accident = list.map((item) => AccidentMonth.fromJson(item)).toList();
    return accident;
  }

  @override
  Widget build(BuildContext context) {
    DateUtil _dateUtil = new DateUtil();
    final _select = ModalRoute.of(context)!.settings.arguments as List<String>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_select[2]}',
          style: GoogleFonts.mali(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        backgroundColor: Color(0xFF1900b3),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.indigo, Colors.red],
          ),
        ),
        child: FutureBuilder<List<AccidentMonth>>(
            future: _fetch(_select),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var accidentList = snapshot.data![snapshot.data!.length - index - 1];
                    return Card(
                      color: Colors.white.withOpacity(0.6),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.all(8.0),
                      elevation: 5.0,
                      shadowColor: Colors.black.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${_dateUtil.parseDateDay(accidentList.accident_date)} ที่ ${_dateUtil.dateDay(accidentList.accident_date)} ${_select[2]} ${_select[0]}',
                                    style: GoogleFonts.mali(
                                      color: Colors.black87,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'เวลาเกิดเหตุ : ${accidentList.accident_time} น.',
                                  style: GoogleFonts.mali(
                                    color: Colors.black87,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'สถานที่เกิดเหตุ : ${accidentList.expw_step}',
                                  style: GoogleFonts.mali(
                                    color: Colors.black87,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'สภาพอากาศ : ${accidentList.weather_state}',
                                  style: GoogleFonts.mali(
                                    color: Colors.black87,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'สาเหตุ : ${accidentList.cause}',
                                  style: GoogleFonts.mali(
                                    color: Colors.black87,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Card(
                                    color: Colors.yellow.shade700
                                        .withOpacity(0.6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .personal_injury_sharp,
                                                    size: 30.0,
                                                  ),
                                                  Text(
                                                    'จำนวนผู้บาดเจ็บ',
                                                    style: GoogleFonts.mali(
                                                      color: Colors
                                                          .indigo.shade900,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          5.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.male_sharp,
                                                        size: 25.0,
                                                      ),
                                                      Text(
                                                        'ผู้ชาย',
                                                        style:
                                                            GoogleFonts.mali(
                                                          color:
                                                              Colors.black87,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          5.0),
                                                  child: Text(
                                                    '${accidentList.injur_man}  ราย',
                                                    style: GoogleFonts.mali(
                                                      color: Colors.black87,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          5.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.female_sharp,
                                                        size: 25.0,
                                                      ),
                                                      Text(
                                                        'ผู้หญิง',
                                                        style:
                                                            GoogleFonts.mali(
                                                          color:
                                                              Colors.black87,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          5.0),
                                                  child: Text(
                                                    '${accidentList.injur_femel}  ราย',
                                                    style: GoogleFonts.mali(
                                                      color: Colors.black87,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    color:
                                        Colors.red.shade700.withOpacity(0.6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/grave.png',
                                                    height: 30,
                                                  ),
                                                  Text(
                                                    'จำนวนผู้เสียชีวิต',
                                                    style: GoogleFonts.mali(
                                                      color: Colors
                                                          .yellow.shade800,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          5.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.male_sharp,
                                                        size: 25.0,
                                                      ),
                                                      Text(
                                                        'ผู้ชาย',
                                                        style:
                                                            GoogleFonts.mali(
                                                          color:
                                                              Colors.black87,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          5.0),
                                                  child: Text(
                                                    '${accidentList.dead_man}  ราย',
                                                    style: GoogleFonts.mali(
                                                      color: Colors.black87,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          5.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.female_sharp,
                                                        size: 25.0,
                                                      ),
                                                      Text(
                                                        'ผู้หญิง',
                                                        style:
                                                            GoogleFonts.mali(
                                                          color:
                                                              Colors.black87,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          5.0),
                                                  child: Text(
                                                    '${accidentList.dead_femel}  ราย',
                                                    style: GoogleFonts.mali(
                                                      color: Colors.black87,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ผิดพลาด: ${snapshot.error}'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _accidentFuture = _fetch(_select);
                          });
                        },
                        child: const Text('ลองใหม่'),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}
