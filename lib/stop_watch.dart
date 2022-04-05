import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {

  //build logic

  int seconds=0,minutes= 0,hours=0;

  String digitSeconds ="00",digitMinutes ="00",digitHours ="00";
  Timer? timer;
  bool started = false;

  List laps = [];

  //Stop Timer Code

  void stop(){
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  // reset Button Code

  void reset(){
    timer!.cancel();
    setState(() {
      seconds=0;
      minutes=0;
      hours=0;

      digitSeconds ="00";
      digitMinutes ="00";
      digitHours = "00";
      started = false;

    });
  }

  void appLaps(){
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  //Start button code

  void start(){
    started= true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if(localSeconds >59){
        if(localMinutes > 59){
          localHours++;
          localMinutes =0;
        }
        else{
          localMinutes++;
          localSeconds=0;
        }
      }

      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1c2757),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text("Stop WaTcH App",style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.white
                    ),
                    ),
                  )
              ),

              const SizedBox(height: 40,),

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("$digitHours:$digitMinutes:$digitSeconds",style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 60,
                      color: Colors.white
                  ),
                  ),
                ),
              ),

              const SizedBox(height: 60,),
              
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: const Color(0xff323f68),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                    itemBuilder: (context,index){

                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Lap ${index +1}",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                            color: Colors.green
                          ),
                          ),
                          Text("Lap ${laps[index]}",style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white
                          ),
                          ),
                        ],
                      ),
                    );
                    }
                ),
              ),
              const SizedBox(height: 110,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child:InkWell(
                      onTap: (){
                        (!started) ? start() : stop();
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue,width:3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:Center(child: Text((!started)? "Start" : "Pause",style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        )
                        ),
                      ),
                    )
                  ),

                TextButton(onPressed: (){
                  appLaps();
                },
                    child:InkWell(
                      onTap: (){
                        appLaps();
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        child: Text("Result"),
                        backgroundColor: Colors.teal,
                      ),
                    )
                ),

                  Expanded(
                      child:InkWell(
                        onTap: (){
                          reset();
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(child: Text("Reset",style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          )
                          ),
                        ),
                      )
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
