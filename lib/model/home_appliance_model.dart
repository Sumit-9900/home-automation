class HomeModel {
  final List<Appliance> appliances;

  HomeModel({
    required this.appliances,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        appliances: List<Appliance>.from(
            json["appliances"].map((x) => Appliance.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "appliances": List<dynamic>.from(appliances.map((x) => x.toJson())),
      };
}

class Appliance {
  final String id;
  final String type;
  final String status;
  final String icon;
  final bool value;
  final List<String> params;
  final List<dynamic> paramsValue;
  final int initial;
  final int min;
  final int max;

  Appliance({
    required this.id,
    required this.type,
    required this.status,
    required this.icon,
    required this.value,
    required this.params,
    required this.paramsValue,
    required this.initial,
    required this.min,
    required this.max,
  });

  factory Appliance.fromJson(Map<String, dynamic> json) => Appliance(
        id: json["id"],
        type: json["type"],
        status: json["status"],
        icon: json["icon"],
        value: json["value"],
        params: List<String>.from(json["params"].map((x) => x)),
        paramsValue: List<dynamic>.from(json["params_value"].map((x) => x)),
        initial: json["initial"],
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "status": status,
        "icon": icon,
        "value": value,
        "params": List<dynamic>.from(params.map((x) => x)),
        "params_value": List<dynamic>.from(paramsValue.map((x) => x)),
        "initial": initial,
        "min": min,
        "max": max,
      };
}
