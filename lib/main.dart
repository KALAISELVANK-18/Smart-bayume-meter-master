import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sbm/page1.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const Student(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url="https://api.thingspeak.com/channels/1888998/feeds.json?results=2";
  Map<String, dynamic> jsonResponse={};


  late String nn;
  List<List<String>> bb=[['abc']];


  List<SalesData> fetchdata(List<dynamic> data){
    List<SalesData> da=[];
    for(int i=13;i<data.length;i++){

      da.add(SalesData(data[i]["created_at"].toString().substring(11,16),double.parse(data[i]["field1"])  ));
    }
    return da;
  }




  Future<Stream<Map<String, dynamic>>> _ge() async{

    http.Response response = await http.get(Uri.parse('https://api.thingspeak.com/channels/2107940/feeds.json'));
    jsonResponse['output']=await jsonDecode(response.body);


    late Future<Stream<Map<String, dynamic>>> _bids = (() async{
      late final StreamController<Map<String, dynamic>> controller;
      controller = StreamController<Map<String, dynamic>>(
        onListen: ()  async{

          controller.add(jsonResponse);

          controller.close();
        },
      );
      return controller.stream;
    })();

    return _bids;
  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(

        backgroundColor: Colors.white,
        width: 170,
        child: ListView(
          children: [
            DrawerHeader(decoration: BoxDecoration(color: Colors.white),
              child:Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Row(

                  children: [
                    Icon(Icons.data_exploration,color: Colors.deepPurple,),
                    Text("Gravity",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),

                  ],
                ),
              ),
            ),
            ListTile(
              onTap: (){Navigator.pop(context);},

              hoverColor: Colors.blueAccent,
              selectedTileColor: Colors.blueAccent,
              title: Text("Dashboard"),
            ),

            ListTile(
              onTap: (){Navigator.pop(context);},
              hoverColor: Colors.blueAccent,
              title: Text("Logout"),
            )
          ],
        ),
      ),
      appBar: AppBar(


        backgroundColor: Colors.indigo,
        actions: <Widget>[Padding(padding: EdgeInsets.symmetric(horizontal: 17,vertical: 15),child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Text("Gravity",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19)),
            ),
          ],
        ))

        ],
      ),
      body: Center(
        child: FutureBuilder<Stream<Map<String, dynamic>>>(
            future: _ge(),
            builder: (BuildContext context, AsyncSnapshot<Stream<Map<String, dynamic>>> snapshot) {
              List<Widget> children;
              if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('Stack trace: ${snapshot.stackTrace}'),
                  ),
                ];
                return Column(children: children,);
              } else {



                print(snapshot.data);
                return StreamBuilder<Map<String, dynamic>>(

                    stream: snapshot.data,
                    builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasError) {
                        children = <Widget>[
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Error: ${snapshot.error}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text('Stack trace: ${snapshot.stackTrace}'),
                          ),
                        ];
                        return Column(
                          children: children,
                        );
                      } else {

                        print(snapshot.data?['output']);

                        late var cc=snapshot.data?['output']['feeds'].length;


                      if(cc!=null){
                      return ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(padding: EdgeInsets.symmetric(vertical: 10),
                            child: Center(child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Specific gravity Analysis",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                Icon(Icons.abc_outlined)

                              ],
                            ),),),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: Colors.white,
                                  boxShadow: [
                                  BoxShadow(
                                    color: Colors.tealAccent,
                                  blurRadius: 10.0,
                                  ),
                                  ],
                              ),
                              child: Padding(

                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                child: SfCartesianChart(

                                    plotAreaBorderColor: Colors.black,

                                    backgroundColor: Colors.white,
                                    primaryXAxis: CategoryAxis(
                                        title: AxisTitle(text: "Time",textStyle: TextStyle(color: Color.fromARGB(255, 7, 19, 95 ),fontWeight: FontWeight.bold,fontSize: 20)),autoScrollingMode: AutoScrollingMode.end,associatedAxisName: 'cxcxc',autoScrollingDelta: 20), //Chart title.

                                    legend: Legend(isVisible: false), // Enables the legend.
                                    tooltipBehavior: TooltipBehavior(enable: true), // Enables the tooltip.
                                    series: <LineSeries<SalesData, String>>[
                                      LineSeries<SalesData, String>(

                                          dataSource: fetchdata(snapshot.data?['output']['feeds']),
                                          xValueMapper: (SalesData sales, _) => sales.year,
                                          yValueMapper: (SalesData sales, _) => sales.sales,

                                          dataLabelSettings: DataLabelSettings(isVisible: true,) // Enables the data label.
                                      )
                                    ]
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                      Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                      child: Center(child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      Text("Recent Specific gravity",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ],
                      )))],
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                              itemCount: cc,
                              itemBuilder: (BuildContext context,int index){
                            return Column(children:
                            [

                              SizedBox(height: 20,),
                              Container(

                                child: SafeArea(
                                  minimum: EdgeInsets.zero,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [


                                      Padding(

                                        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 20),
                                        child: Container(

                                            width:MediaQuery.of(context).size.width*0.9,
                                            height: 90,
                                            decoration: BoxDecoration(

                                                color: Color.fromARGB(255, 7, 19, 95 ),
                                                borderRadius: BorderRadius.circular(8)
                                            ),

                                            child: Column(
                                              children: [
                                                SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 10,),
                                                    Icon(Icons.data_exploration,color:  Colors.white,),
                                                    SizedBox(width: 10,),

                                                    Text("Specific gravity",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                                                    SizedBox(width: 10,),
                                                    Text('${snapshot.data?['output']['feeds'][cc-1-index]["field1"]}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                                                  ],
                                                ),
                                                SizedBox(height: 20,),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 10,),
                                                    Icon(Icons.timelapse,color:  Colors.white,),
                                                    SizedBox(width: 10,),
                                                    Text("Time",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                                                    SizedBox(width: 10,),
                                                    Text('${snapshot.data?['output']['feeds'][cc-1-index]["created_at"]}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15),),
                                                  ],
                                                )
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],);
                          }),


                        ],
                      );}
                      else{
                        return Center(
                          child: Column(
                            children: [
                              Center(child:CircularProgressIndicator())
                            ],
                          ),
                        );
                      }}});
              }}
        ),
      ),
    );


  }
}


class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
