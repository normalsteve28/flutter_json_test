class Class {
  int sys;
  int dia;
  int hr;
  DateTime dt;

  Class(this.sys, this.dia, this.hr);

  Map<String, dynamic> toJson() => {
        'sys': sys,
        'dia': dia,
        'hr': hr,
      };

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(json['sys'], json['dia'], json['hr']);
  }
}
