class Todo{
  String cId;
  String cPlate;
  String cGroup;
  String cIdentNumber;
  String instutionNumber;
  int cKmHour;

  Todo(String cId,
  String cPlate,
  String cGroup, 
  String cIdentNumber, 
  String instutionNumber,
  int cKmHour,
  ){
    this.cId = cId;
    this.cPlate = cPlate;
    this.cGroup = cGroup;
    this.cIdentNumber = cIdentNumber;
    this.instutionNumber=instutionNumber;
    this.cKmHour;
  }

  Todo.fromJson(Map json){
    cId = json["Oid"];
    cPlate = json["LicensePlate"];
    cGroup = json["VehicleGroup"];
    cIdentNumber = json["VehicleIdentificationNumber"];
    instutionNumber=json["InstitutionNumber"];
    cKmHour=json["CurrentKmHour"];
  }

  Map toJson(){
    return {"Oid":cId, "LicensePlate":cPlate, 
    "VehicleGroup":cGroup, "VehicleIdentificationNumber":cIdentNumber, 
    "InstitutionNumber":instutionNumber,"CurrentKmHour":cKmHour};
  }
}