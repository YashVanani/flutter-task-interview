import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelDetails extends StatefulWidget{
  @override
  HotelDetailsState createState() => HotelDetailsState();
}

class HotelDetailsState extends State<HotelDetails> {
  String name="";
  String address="";
  String postalcode="";
  String phone="";
  String totalrooms="";
  String country="";
  String instagram="";
  String facebook="";
  double latitude=0;
  double longitude=0;

  List<Marker> allMarkers = [];
  Map<MarkerId,Marker> markers = {};
  MarkerId markerId1 = MarkerId("1");
  LatLng _initialcameraposition;
  GoogleMapController _controller;
  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    allMarkers.add(Marker(
        markerId: MarkerId('mymarker'),
        draggable: false,
        infoWindow: InfoWindow(
          title: "Welcome To",
          snippet: name,
        ),
        position: LatLng(
          latitude,longitude
        )
     ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map args=ModalRoute.of(context).settings.arguments;
    if(args!=null)
    {
      setState(() {
        name=args["name"].toString();
        address=args["address"].toString();
        postalcode=args["postalcode"].toString();
        phone=args["phone"].toString();
        totalrooms=args["totalrooms"].toString();
        country=args["country"].toString();
        instagram=args["instagram"].toString();
        facebook=args["facebook"].toString();
        latitude=double.parse(args["latitude"]);
        longitude=double.parse(args["longitude"]);
        _initialcameraposition = LatLng(latitude,longitude);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            (_initialcameraposition!=null)?Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              color: Colors.black12,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialcameraposition,
                  zoom: 15.0,
                ),
                markers: Set.from(allMarkers),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,

              ),
            ):Text("Loading..."),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: new BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Hotel Name : " + name, style: TextStyle(
                        fontWeight: FontWeight.bold),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Hotel Address : " + address),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Hotel Postal Code : " + postalcode),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Hotel Phone No. : " + phone),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Hotel Total Rooms : " + totalrooms),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Hotel Country : " + country),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 150,
                        bottom: 5
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              child: Image.network(
                                "https://www.pngfind.com/pngs/m/30-307198_circle-fb-logo-sticker-facebook-png-transparent-png.png",
                                  height: 35,),
                                  onTap: () async {
                                    await launch(facebook);
                                  },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              child: Image.network(
                                "https://www.freepnglogos.com/uploads/instagram-logo-png-transparent-0.png",
                                  height: 35,),
                                  onTap: () async {
                                    await launch(instagram);
                                  },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
