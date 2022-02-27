import 'package:accident_statistic/models/accident_items_year.dart';
import 'package:accident_statistic/pages/accidentDetail_month.dart';
import 'package:accident_statistic/pages/home_page.dart';
import 'package:accident_statistic/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ListMonth extends StatefulWidget {
  static const routeName = '/listMonth';

  const ListMonth({Key? key}) : super(key: key);

  @override
  _ListMonthState createState() => _ListMonthState();
}

class _ListMonthState extends State<ListMonth> {
  late Future<List<Accident>> _accidentFuture;

  Future<List<Accident>> _fetch(String year) async {
    List list = await Api().fetch('EXAT_AccidentStat/${year}');
    var accident = list.map((item) => Accident.fromJson(item)).toList();
    return accident;
  }

  @override
  Widget build(BuildContext context) {
    final _year = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'อุบัติเหตุบนทางพิเศษรายเดือน',
          style: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1900b3),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  HomePage.routeName,
                );
              },
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.indigo, Colors.red],
          ),
        ),
        child: FutureBuilder<List<Accident>>(
            future: _fetch(_year),
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
                    var accidentList = snapshot.data![index];

                    return Card(
                      color: Colors.white.withOpacity(0.6),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.all(8.0),
                      elevation: 5.0,
                      shadowColor: Colors.black.withOpacity(0.2),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            var select = [
                              '${_year}',
                              '${accidentList.month_no}',
                              '${accidentList.month}'
                            ];
                            Navigator.pushNamed(
                              context,
                              AccidentDetailMonth.routeName,
                              arguments: select,
                            );
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Icon(
                                Icons.health_and_safety_sharp,
                                size: 40.0,
                                color: Colors.green.shade500,
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    '${accidentList.month}',
                                    style: GoogleFonts.notoSans(
                                      color: Colors.black87,
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.indigo.withOpacity(0.8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'จำนวนอุบัติเหตุ',
                                          style: GoogleFonts.notoSans(
                                            color: Colors.white70,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${accidentList.accident} ครั้ง',
                                          style: GoogleFonts.notoSans(
                                            color: Colors.white70,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.yellow.shade700.withOpacity(0.6),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.personal_injury_sharp,
                                            size: 30.0,
                                          ),
                                          Text(
                                            'จำนวนผู้บาดเจ็บ',
                                            style: GoogleFonts.notoSans(
                                              color: Colors.indigo.shade900,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.male_sharp,
                                                    size: 25.0,
                                                  ),
                                                  Text(
                                                    'ผู้ชาย',
                                                    style: GoogleFonts.notoSans(
                                                      color: Colors.white70,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '${accidentList.injur_man} ราย',
                                                style: GoogleFonts.notoSans(
                                                  color: Colors.white70,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.female_sharp,
                                                    size: 25.0,
                                                  ),
                                                  Text(
                                                    'ผู้หญิง',
                                                    style: GoogleFonts.notoSans(
                                                      color: Colors.white70,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '${accidentList.injur_femel} ราย',
                                                style: GoogleFonts.notoSans(
                                                  color: Colors.white70,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
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
                                color: Colors.red.shade700.withOpacity(0.6),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/grave.png',
                                        height: 30,
                                      ),
                                      Text(
                                        'จำนวนผู้เสียชีวิต',
                                        style: GoogleFonts.notoSans(
                                          color: Colors.yellow.shade700,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.male_sharp,
                                                    size: 25.0,
                                                  ),
                                                  Text(
                                                    'ผู้ชาย',
                                                    style: GoogleFonts.notoSans(
                                                      color: Colors.white70,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '${accidentList.dead_man} ราย',
                                                style: GoogleFonts.notoSans(
                                                  color: Colors.white70,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.female_sharp,
                                                  size: 25.0,
                                                ),
                                                Text(
                                                  'ผู้หญิง',
                                                  style: GoogleFonts.notoSans(
                                                    color: Colors.white70,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              '${accidentList.dead_femel} ราย',
                                              style: GoogleFonts.notoSans(
                                                color: Colors.white70,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                            _accidentFuture = _fetch(_year);
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
