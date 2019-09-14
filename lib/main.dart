import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http_demo/apis/api.dart';
import 'package:http_demo/models/todo.dart';

void main() => runApp(TodoApp()); //Uygulamam TodoApp

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListApp(), //Ana Ekran TodoListApp()
    );
  }
}

class TodoListApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListAppState(); //State oluşturma
}

class TodoListAppState extends State {
  List<Todo> list =
      new List<Todo>(); //todo.dart içerisinde ki verileri List den nesne üret

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Genel
      appBar: AppBar(
        //header kısmı
        title: Text(
          "----->Car List<-----",
          style: TextStyle(color: Colors.black),
        ), //header başlık - renk ayarı
        backgroundColor: Colors.grey, //header arka plan renk ayarı
        centerTitle: true, // header yazıyı ortalama
      ),
      body: ListView.builder(
          itemCount: list.length, // liste  uzunluğunu alıyoruz.
          itemBuilder: (context, position) => Column(
                //kolonlama yapıyoruz
                children: <Widget>[
                  Divider(
                    //her biri bir kutu şeklinde
                    height: 10.0, //yükseklik
                    color: Colors.black, //arada ki çizgi
                  ),
                  Container(
                    child: ListTile(
                      title: RaisedButton(
                        color: Colors.white,
                        // Raised buton oluşumu
                        child: Text(list[position].cPlate +
                            "/" +
                            list[position]
                                .cGroup), //Araç plakası ve grubunu yazdırma
                        onPressed: () {
                          //Buttona tıklandıgında
                          var route = new MaterialPageRoute(
                            //Route oluşturma
                            builder: (BuildContext context) => new CarDetails(
                              id: list[position]
                                  .cId, //Verileri diğer sayfaya gönderme
                              plate: list[position].cPlate,
                              group: list[position].cGroup,
                              identiNumber: list[position].cIdentNumber,
                              instituNumber: list[position].instutionNumber,
                              kmHour: list[position].cKmHour,
                            ),
                          );
                          Navigator.of(context).push(
                              route); //oluşturdugumuz route yönlendiriyoruz
                        },
                      ),
                    ),
                  )
                ],
              )),
    );
  }

  getTodos() {
    Api.getTodos().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.list = list
            .map((todo) => Todo.fromJson(todo))
            .toList(); // listeyi mapliyoruz
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }
}

class CarDetails extends StatefulWidget {
  //Araç detay sayfasını oluşturuyoruz
  //İkinci ekran
  final String id; //bu sayfaya gelen verilerin aktarılacağı değişkenler
  String plate;
  String group;
  String identiNumber;
  String instituNumber;
  int kmHour;

  CarDetails({
    //yapıcı method
    Key key,
    this.id,
    this.plate,
    this.group,
    this.identiNumber,
    this.instituNumber,
    this.kmHour,
  }) : super(key: key);
  @override
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Car Details -> ${widget.plate} ",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey, //2. sayfa arka plan rengi
        ),
        body: Container(
            padding:
                EdgeInsets.only(left: 20.0, top: 20.0), // Soldan 20 px boşluk
            child: Column(
              children: <Widget>[
                Text(
                  // idye göre gelen verileri 2.ekrana basıyoruz
                  "Oid    : ${widget.id}",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ), //renk ve yazı boyutu ayarlandı
                Divider(
                  // yazılar arası boyut ayarlama ve çizgi koyma
                  height: 10.0,
                  color: Colors.black,
                ),
                Text(
                  "LicensePlate : ${widget.plate}",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                Divider(
                  height: 10.0,
                  color: Colors.black,
                ),

                Text(
                  "VehicleGroup  : ${widget.group}",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                Divider(
                  height: 10.0,
                  color: Colors.black,
                ),
                Text(
                  "VehicleIdentificationNumber : ${widget.identiNumber}",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                Divider(
                  height: 10.0,
                  color: Colors.black,
                ),
                Text(
                  "CurrentKmHour : ${widget.kmHour}",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                Divider(
                  height: 10.0,
                  color: Colors.black,
                ),
                Text(
                  "InstitutionNumber : ${widget.instituNumber}",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ],
            )));
  }
}
