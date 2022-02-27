class Accident {
  final int id;
  final int year;
  final String month;
  final int month_no;
  final int accident;
  final int injur_man;
  final int injur_femel;
  final int dead_man;
  final int dead_femel;

  Accident({
    required this.id,
    required this.year,
    required this.month,
    required this.month_no,
    required this.accident,
    required this.injur_man,
    required this.injur_femel,
    required this.dead_man,
    required this.dead_femel,
  });

  factory Accident.fromJson(Map<String, dynamic> json) {
    return Accident(
      id: json["_id"],
      year: json["year"],
      month: json["month"],
      month_no: json["month_no"],
      accident: json["accident"],
      injur_man: json["injur_man"],
      injur_femel: json["injur_femel"],
      dead_man: json["dead_man"],
      dead_femel: json["dead_femel"],
    );
  }
}
