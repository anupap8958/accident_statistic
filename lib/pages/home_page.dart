import 'package:accident_statistic/models/accident_items_year.dart';
import 'package:accident_statistic/pages/accidentList_month.dart';
import 'package:accident_statistic/services/api.dart';
import 'package:ntp/ntp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/select';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime ntpTime = DateTime.now();
  late Future<List<Accident>> _accidentFuture;
  final _controller = TextEditingController();
  late String _year;
  var totalAccident = 0;
  var totalInjur = 0;
  var totalInjurMen = 0;
  var totalInjurFemale = 0;
  var totalDead = 0;
  var totalDeadMen = 0;
  var totalDeadFemale = 0;

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: GoogleFonts.mali(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            msg,
            style: GoogleFonts.mali(fontSize: 15.0, color: Colors.black),
          ),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<Accident>> _fetch(String _year) async {
    List list = await Api().fetch('EXAT_AccidentStat/${_year}');
    var accident = list.map((item) => Accident.fromJson(item)).toList();
    return accident;
  }

  void _loadNTPTime() async {
    ntpTime = await NTP.now();
  }

  @override
  void initState() {
    super.initState();
    _loadNTPTime();
    _year = '${ntpTime.year + 543}';
    _accidentFuture = _fetch(_year);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'อุบัติเหตุบนทางพิเศษในประเทศไทย',
          style: GoogleFonts.mali(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        backgroundColor: Color(0xFF1900b3),
      ),
      bottomNavigationBar: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                ListMonth.routeName,
                arguments: _year,
              );
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.all(10.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              backgroundColor: Color(0xFFff9d05),
            ),
            child: Text(
              'แสดงรายละเอียดแต่ละเดือน',
              style: GoogleFonts.mali(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo, Colors.red],
          ),
        ),
        child: FutureBuilder<List<Accident>>(
            future: _accidentFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                totalAccident = 0;
                totalInjur = 0;
                totalInjurMen = 0;
                totalInjurFemale = 0;
                totalDead = 0;
                totalDeadMen = 0;
                totalDeadFemale = 0;
                for (int index = 0; index < snapshot.data!.length; index++) {
                  var accidentList = snapshot.data![index];
                  totalAccident += accidentList.accident;
                  totalDead += accidentList.dead_man + accidentList.dead_femel;
                  totalDeadMen += accidentList.dead_man;
                  totalDeadFemale += accidentList.dead_femel;
                  totalInjur +=
                      accidentList.injur_man + accidentList.injur_femel;
                  totalInjurMen += accidentList.injur_man;
                  totalInjurFemale += accidentList.injur_femel;
                }
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: double.infinity,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildHeader(),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 10,
                        ),
                        _buildShowStatPanel(),
                        SizedBox(
                          width: double.infinity,
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: _buildInputPanel(),
                        ),
                      ],
                    ),
                  ),
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

  Widget _buildInputPanel() {
    return Column(
      children: [
        Container(
          width: 230.0,
          decoration: BoxDecoration(
            color: Colors.white70,
            border: Border.all(width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontFamily: 'PressStart2p',
                    color: Colors.black54,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  cursorColor: Colors.black,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    isDense: true,
                    // กำหนดลักษณะเส้น border ของ TextField ในสถานะปกติ
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    // กำหนดลักษณะเส้น border ของ TextField เมื่อได้รับโฟกัส
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      fontFamily: 'PressStart2p',
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    var tempYear = int.parse(_controller.text);
                    if (tempYear < 2546) {
                      _showMaterialDialog('Warning',
                          'กรุณาใส่จำนวนปีอยู่ในระหว่าง 2546 - ${_year} พ.ศ. โปรดลองใหม่อีกครั้ง');
                    } else if (tempYear > 2565) {
                      _showMaterialDialog('Warning',
                          'กรุณาใส่จำนวนปีอยู่ในระหว่าง 2546 - ${_year} พ.ศ. โปรดลองใหม่อีกครั้ง');
                    } else {
                      _year = _controller.text;
                      _accidentFuture = _fetch(_year);
                      totalAccident = 0;
                      totalInjur = 0;
                      totalInjurMen = 0;
                      totalInjurFemale = 0;
                      totalDead = 0;
                      totalDeadMen = 0;
                      totalDeadFemale = 0;
                    }
                  });
                },
                child: Text(
                  '| ยืนยัน',
                  style: GoogleFonts.mali(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '* ใส่ปี พ.ศ. ที่ต้องการ',
            style: GoogleFonts.mali(
              color: Colors.yellow.shade700,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'อุบัติเหตุทางพิเศษ',
                style: GoogleFonts.mali(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            'ในประเทศไทย',
            style: GoogleFonts.mali(
              color: Colors.white,
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'ประจำปี : ${_year}',
            style: GoogleFonts.mali(
              color: Colors.white70,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowStatPanel() {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.all(3.0),
      shadowColor: Colors.black.withOpacity(0.6),
      color: Colors.grey.withOpacity(0.6),
      child: Container(
        height: 350.0,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      //เกิดอุบัติเหตุ
                      width: double.infinity,
                      height: 180,
                      color: Colors.indigo,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'เกิดอุบัติเหตุ (ครั้ง)',
                              style: GoogleFonts.mali(
                                color: Colors.black,
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${totalAccident}',
                            style: GoogleFonts.mali(
                              color: Color(0xFFff9d05),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.yellow.shade700,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'บาดเจ็บ (คน)',
                              style: GoogleFonts.mali(
                                color: Colors.black87,
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${totalInjur}',
                              style: GoogleFonts.mali(
                                color: Colors.indigo,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          'ชาย',
                                          style: GoogleFonts.mali(
                                            color: Colors.black87,
                                            fontSize: 23.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${totalInjurMen}',
                                          style: GoogleFonts.mali(
                                            color: Colors.indigo,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          'หญิง',
                                          style: GoogleFonts.mali(
                                            color: Colors.black87,
                                            fontSize: 23.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${totalInjurFemale}',
                                          style: GoogleFonts.mali(
                                            color: Colors.indigo,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
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
            Expanded(
              child: Container(
                //เสียชีวิต
                color: Colors.red.shade700,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'เสียชีวิต (ราย)',
                      style: GoogleFonts.mali(
                        color: Colors.black87,
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${totalDead}',
                      style: GoogleFonts.mali(
                        color: Color(0xFFff9d05),
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  'ชาย',
                                  style: GoogleFonts.mali(
                                    color: Colors.black87,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${totalDeadMen}',
                                  style: GoogleFonts.mali(
                                    color: Color(0xFFff9d05),
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  'หญิง',
                                  style: GoogleFonts.mali(
                                    color: Colors.black87,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${totalDeadFemale}',
                                  style: GoogleFonts.mali(
                                    color: Color(0xFFff9d05),
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
    );
  }
}
