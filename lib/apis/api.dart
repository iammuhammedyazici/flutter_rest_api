import 'package:http/http.dart' as http;
// Web api bağlantı kodları
class Api {
  static Future getTodos(){
    return http.get("http://rest.virames.com.tr/GetVehicleList");
  }
}