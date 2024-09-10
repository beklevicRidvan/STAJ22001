class MoneyModel {
  String? code;
  String? name;
  dynamic rate;
  String? calculatedStr;
  String? lastUpdate;
  dynamic calculated;
  String iconUrl;

  MoneyModel({required this.code, required this.name, required this.rate, required this.calculatedStr, required this.lastUpdate, this.calculated,required this.iconUrl});

  factory MoneyModel.fromMap(Map<String, dynamic> data, String? dlastUpdate) {
    return MoneyModel(
        code: data['code'] ?? 'null',
        name: data['name'] ?? 'null',
        rate: data['rate'] ?? 0.0,
        calculatedStr: data['calculatedStr'] ?? 'null',
        lastUpdate: dlastUpdate ?? 'null',
        calculated: data['calculated'] ?? 0.0,
        iconUrl: data['iconUrl']
    );
  }
}
