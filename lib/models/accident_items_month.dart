class AccidentMonth {
  final int id;
  final String accident_date;
  final String accident_time;
  final String expw_step;
  final String weather_state;
  final int injur_man;
  final int injur_femel;
  final int dead_man;
  final int dead_femel;
  final String cause;

  AccidentMonth({
    required this.id,
    required this.accident_date,
    required this.accident_time,
    required this.expw_step,
    required this.weather_state,
    required this.injur_man,
    required this.injur_femel,
    required this.dead_man,
    required this.dead_femel,
    required this.cause,
  });

  factory AccidentMonth.fromJson(Map<String, dynamic> json) {
    return AccidentMonth(
      id: json["_id"],
      accident_date: json["accident_date"],
      accident_time: json["accident_time"],
      expw_step: json["expw_step"],
      weather_state: json["weather_state"],
      injur_man: json["injur_man"],
      injur_femel: json["injur_femel"],
      dead_man: json["dead_man"],
      dead_femel: json["dead_femel"],
      cause: json["cause"],
    );
  }
}
