

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task_interview/Ui/HotelDetails.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{

  String searchQueryUser = "Search query";
  TextEditingController _searchQueryUser;
  Future<List> data;
  Future<List> filterdata;
  Future<List> getdata() async{
    var response = await http.get(
        Uri.parse('https://leejaew-hotels-in-singapore-v1.p.rapidapi.com/hotels?country=Singapore'),
        headers: {
          "x-rapidapi-key": "8a337c62a8msh554a3016611ef31p171028jsn3219f3779edc",
          "x-rapidapi-host" : "leejaew-hotels-in-singapore-v1.p.rapidapi.com"
        }
    );
    if(response.statusCode==200)
      {
        var jsondata = jsonDecode(response.body);
        return jsondata;
      }
  }
  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQueryUser = newQuery;
        if(_searchQueryUser.toString().length>0) {
          Future<List> items=data;
          List filter=new List();
          items.then((result){
            for(var record in result) {
              if(record["name"].toLowerCase().toString().contains(searchQueryUser.toLowerCase())) {
                filter.add(record);
              }
            }
            filterdata=Future.value(filter);
          });
        }
        else {
          filterdata=data;
        }
      }
    );
    print("search query1 " + newQuery);
  }

  @override
  void initState() {
    super.initState();
    data = getdata();
    filterdata=data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 10,
              right: 10
            ),
            child: TextFormField(
              controller: _searchQueryUser,
              onChanged: updateSearchQuery,
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: new BorderSide(
                    color: Colors.black,
                  )
                ),
                prefixIcon: Icon(Icons.search,color: Colors.black,),
                hintText: "Search Hotels Here"
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: filterdata,
                builder: (context,snapshot){
                  if(snapshot.hasData)
                  {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,position){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: InkWell(
                              child: Column(
                                  children : [
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:Text("Hotel Name : "+snapshot.data[position]["name"].toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:Text("Hotel Address : "+snapshot.data[position]["address"]["street"].toString()
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Hotel Phone No. : "+snapshot.data[position]["phone"].toString()),
                                    ),
                                  ]
                              ),
                              onTap: (){
                                var name = snapshot.data[position]["name"].toString();
                                var address = snapshot.data[position]["address"]["street"].toString();
                                var postalcode = snapshot.data[position]["address"]["postalcode"].toString();
                                var phone = snapshot.data[position]["phone"].toString();
                                var totalrooms = snapshot.data[position]["totalrooms"].toString();
                                var country = snapshot.data[position]["country"].toString();
                                var instagram = snapshot.data[position]["social"]["instagram"].toString();
                                var facebook = snapshot.data[position]["social"]["facebook"].toString();
                                var latitude = snapshot.data[position]["location"]["latitude"].toString();
                                var longitude = snapshot.data[position]["location"]["longitude"].toString();
                                Navigator.pushNamed(context,
                                    "HotelDetail",
                                    arguments: {
                                  "name":name,"address":address,"postalcode":postalcode,"totalrooms":totalrooms,"phone":phone,"country":country,
                                      "instagram":instagram,"facebook":facebook,"latitude":latitude,"longitude":longitude
                                     }
                                    );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                  else
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
            )
          ),
        ],
      )

    );
  }

}