class ProfileGetModel {
  String? username;
  String? appLang;
  String? image;
  String? thumbnail;
  String? password;
  String? name;
  String? lastName;
  String? idNumber;
  Foundation? foundation;
  AddressDetail? addressDetail;
  List<String>? phoneNumber;
  String? email;
  List<String>? permissions;
  String? id;
  bool? isDeleted;
  String? description;

  ProfileGetModel(
      {this.username,
      this.appLang,
      this.image,
      this.thumbnail,
      this.password,
      this.name,
      this.lastName,
      this.idNumber,
      this.foundation,
      this.addressDetail,
      this.phoneNumber,
      this.email,
      this.permissions,
      this.id,
      this.isDeleted,
      this.description});

  ProfileGetModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    appLang = json['appLang'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    password = json['password'];
    name = json['name'];
    lastName = json['lastName'];
    idNumber = json['idNumber'];
    foundation = json['foundation'] != null ? new Foundation.fromJson(json['foundation']) : null;
    addressDetail = json['addressDetail'] != null ? new AddressDetail.fromJson(json['addressDetail']) : null;
    phoneNumber = json['phoneNumber'].cast<String>();
    email = json['email'];
    permissions = json['permissions'].cast<String>();
    id = json['id'];
    isDeleted = json['isDeleted'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['appLang'] = this.appLang;
    data['image'] = this.image;
    data['thumbnail'] = this.thumbnail;
    data['password'] = this.password;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['idNumber'] = this.idNumber;
    if (this.foundation != null) {
      data['foundation'] = this.foundation!.toJson();
    }
    if (this.addressDetail != null) {
      data['addressDetail'] = this.addressDetail!.toJson();
    }
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['permissions'] = this.permissions;
    data['id'] = this.id;
    data['isDeleted'] = this.isDeleted;
    data['description'] = this.description;
    return data;
  }
}

class Foundation {
  String? id;
  String? name;

  Foundation({this.id, this.name});

  Foundation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
        addressLevels!.add(new AddressLevels.fromJson(v));
      });
    }
    note = json['note'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    iconType = json['iconType'];
    iconColor = json['iconColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressLevels != null) {
      data['addressLevels'] = this.addressLevels!.map((v) => v.toJson()).toList();
    }
    data['note'] = this.note;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['iconType'] = this.iconType;
    data['iconColor'] = this.iconColor;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeId'] = this.typeId;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
