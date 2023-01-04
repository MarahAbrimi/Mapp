import 'dart:developer';
import 'package:map/helper/exported_packages.dart';



class Mapbox extends StatefulWidget {
  const Mapbox({Key? key}) : super(key: key);

  @override
  State<Mapbox> createState() => _MapboxState();
}

class _MapboxState extends State<Mapbox> {
  late double latitude;
  late double longitude;
  late MapboxMapController mapController;
  TextEditingController controller = TextEditingController(); 

  void _onMapCreated(MapboxMapController controller) {
    log("created");
    mapController = controller;
  }

  @override
  void initState() {
    latitude = 31.3237107014793;
    longitude = 36.822971823353086;
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("THE CURENT VALUE IS --- -> " + latitude.toString());
    log("THE CURENT VALUE IS --- -> " + longitude.toString());

    return Scaffold(
      appBar: AppBar(title:const Text("Map"),backgroundColor: const Color.fromARGB(255, 7, 26, 43),centerTitle: true,),
      body: Column(children: [
      Container(
        height: 540,
        child: MapboxMap(
            accessToken:'pk.eyJ1IjoibWFyYWhoIiwiYSI6ImNsY2czZ2lmNjdtemwzcWtlb3RiNzE2ZGcifQ.IVUXm7b7ZdiiBpMrwC4u1A',
            styleString: "mapbox://styles/marahh/clcg55sja000215o36sjjawzl",
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: () => addCircle(mapController),
            initialCameraPosition:  CameraPosition(zoom: 5, target: LatLng(latitude, longitude))),
      ),
      
     const SizedBox(height: 8,),
      Center(
        child: AnimationSearchBar(
          searchBarWidth:500,
          searchBarHeight: 40,
          closeIconColor: const Color.fromARGB(255, 7, 26, 43),
          searchIconColor:const Color.fromARGB(255, 7, 26, 43),
          backIconColor:  const Color.fromARGB(255, 7, 26, 43),
          centerTitle: 'search',
          centerTitleStyle:const TextStyle(color: Color.fromARGB(255, 7, 26, 43),fontSize: 20 ),
          onChanged:(((c0) async{
         // log("pressed");
          var data = await Services().getCities(controller.text,controller.text);
          log(data![0].country);
          setState(() {
            mapController.clearCircles();
            latitude = data[0].latitude;
            longitude = data[0].longitude;
            mapController.addCircle(CircleOptions(
              geometry: LatLng(latitude, longitude),
              circleColor: '#fbbc05',
              circleRadius: 15,
            ),
            );
           mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(zoom: 5,target: LatLng(latitude, longitude))));
                   });
   })) ,
         searchTextEditingController: controller,
         horizontalPadding: 5),
      
      )
      
    ]));
  }

  void addCircle(MapboxMapController mapController) {
    log("addCircle -> " + latitude.toString());
    log("addCircle -> " + longitude.toString());
    mapController.addCircle(CircleOptions(
      geometry: LatLng(latitude, longitude),
      circleColor: '#fbbc05',
      circleRadius: 15,
    ));
  }
}