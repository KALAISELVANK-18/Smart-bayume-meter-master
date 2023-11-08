
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



import 'main.dart';



class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(60),
          ),),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child:Container(
            height: 150,
            decoration:BoxDecoration(
              color: Color.fromARGB(255, 7, 19, 95 ),
              borderRadius: BorderRadius.only(

                topLeft: Radius.zero,
                topRight: Radius.zero,
                bottomLeft: Radius.zero,
                bottomRight: Radius.circular(50.0),
              ),
            ) ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Center(child: Text("My SaltPans",style: GoogleFonts.aclonica(textStyle: TextStyle(color: Color.fromARGB(255, 7, 19, 95 ),fontWeight: FontWeight.w900)),)),
                  ),
                ),
              ],
            ),
          ) ,
        ),
        backgroundColor: Color.fromARGB(255, 7, 19, 95 ),
        centerTitle: true,

        leading: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage:
                NetworkImage("your_thinkspeak_link"),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
                size: 27,
              ),
              onPressed: () {


              })
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),




            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("All Hydrometers",style: GoogleFonts.aclonica(textStyle: TextStyle(fontSize: 25, color: Color.fromARGB(255, 7, 19, 95 ),fontWeight: FontWeight.w900)),)
                ],
              ),
            ),


            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, index) {
                    return TextButton(
                      onPressed: () async {



                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>  MyHomePage(title: 'sasas',),
                          ),
                        );

                      },
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Container(
                            padding: EdgeInsets.all(20),
                            height: 200,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Salt Pan ${index+1}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "View Specific gravites",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          fontSize: 20

                                      ),
                                    ),

                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
