class CustomPoisModel {
  String? name;
  CustomPoiType? customPoiType;
  List<Details>? details;
  AddressDetail? addressDetail;
  // List<PoiStructures>? poiStructures;
  List<String>? documentPaths;
  String? parentId;
  String? id;
  bool? isDeleted;
  String? description;

  CustomPoisModel(
      {this.name,
      this.customPoiType,
      this.details,
      this.addressDetail,
      // this.poiStructures,
      this.documentPaths,
      this.parentId,
      this.id,
      this.isDeleted,
      this.description});

  CustomPoisModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customPoiType = json['customPoiType'] != null ? CustomPoiType.fromJson(json['customPoiType']) : null;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    addressDetail = json['addressDetail'] != null ? AddressDetail.fromJson(json['addressDetail']) : null;
    if (json['poiStructures'] != null) {
      // poiStructures = <PoiStructures>[];
      json['poiStructures'].forEach((v) {
        // poiStructures!.add(PoiStructures.fromJson(v));
      });
    }
    documentPaths = json['documentPaths'].cast<String>();
    parentId = json['parentId'];
    id = json['id'];
    isDeleted = json['isDeleted'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (customPoiType != null) {
      data['customPoiType'] = customPoiType!.toJson();
    }
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    if (addressDetail != null) {
      data['addressDetail'] = addressDetail!.toJson();
    }
    // if (poiStructures != null) {
    //   data['poiStructures'] = poiStructures!.map((v) => v.toJson()).toList();
    // }
    data['documentPaths'] = documentPaths;
    data['parentId'] = parentId;
    data['id'] = id;
    data['isDeleted'] = isDeleted;
    data['description'] = description;
    return data;
  }
}

class CustomPoiType {
  String? color;
  String? id;
  String? name;

  CustomPoiType({this.color, this.id, this.name});

  CustomPoiType.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Details {
  int? id;
  String? name;
  String? nameTr;
  String? type;
  String? value;
  List<String>? dataSource;

  Details({this.id, this.name, this.nameTr, this.type, this.value, this.dataSource});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameTr = json['name_Tr'];
    type = json['type'];
    value = json['value'];
    dataSource = json['dataSource'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_Tr'] = nameTr;
    data['type'] = type;
    data['value'] = value;
    data['dataSource'] = dataSource;
    return data;
  }
}

class AddressDetail {
  List<AddressLevels>? addressLevels;
  String? note;
  double? longitude;
  double? latitude;
  String? iconType;
  String? iconColor;

  AddressDetail({this.addressLevels, this.note, this.longitude, this.latitude, this.iconType, this.iconColor});

  AddressDetail.fromJson(Map<String, dynamic> json) {
    if (json['addressLevels'] != null) {
      addressLevels = <AddressLevels>[];
      json['addressLevels'].forEach((v) {
        addressLevels!.add(AddressLevels.fromJson(v));
      });
    }
    note = json['note'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    iconType = json['iconType'];
    iconColor = json['iconColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addressLevels != null) {
      data['addressLevels'] = addressLevels!.map((v) => v.toJson()).toList();
    }
    data['note'] = note;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['iconType'] = iconType;
    data['iconColor'] = iconColor;
    return data;
  }
}

class AddressLevels {
  int? typeId;
  String? id;
  String? name;

  AddressLevels({this.typeId, this.id, this.name});

  AddressLevels.fromJson(Map<String, dynamic> json) {
    typeId = json['typeId'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeId'] = typeId;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
