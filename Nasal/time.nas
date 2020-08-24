# by Andino for An-124



var convertTime2 = func {

 var TimeSecs = getprop("autopilot/route-manager/ete");

 var TimeHours = (TimeSecs / 3600);

 var TimeSecs2 = sprintf("%i", TimeSecs);

 var TimeHours2 = sprintf("%i", TimeHours);

 var TimeMins = ((TimeSecs2 - ( TimeHours2 * 3600)) / 60);

 var TimeMins2 = sprintf("%i", TimeMins);

 var TimeSecs3 = (TimeSecs2 - (TimeHours2 * 3600) - (TimeMins2 * 60));

 setprop("autopilot/route-manager/ete-hours", TimeHours2);
 setprop("autopilot/route-manager/ete-mins", TimeMins2);
 setprop("autopilot/route-manager/ete-secs", TimeSecs3);

settimer(convertTime2, 0.1);
}

setlistener("sim/signals/fdm-initialized", convertTime2);


var convertTime = func {

 var FTimeSecs = getprop("autopilot/route-manager/flight-time");

 var FTimeHours = (FTimeSecs / 3600);

 var FTimeSecs2 = sprintf("%i", FTimeSecs);

 var FTimeHours2 = sprintf("%i", FTimeHours);

 var FTimeMins = ((FTimeSecs2 - ( FTimeHours2 * 3600)) / 60);

 var FTimeMins2 = sprintf("%i", FTimeMins);

 var FTimeSecs3 = (FTimeSecs2 - (FTimeHours2 * 3600) - (FTimeMins2 * 60));

 setprop("autopilot/route-manager/flight-time-hours", FTimeHours2);
 setprop("autopilot/route-manager/flight-time-mins", FTimeMins2);
 setprop("autopilot/route-manager/flight-time-secs", FTimeSecs3);

settimer(convertTime, 0.1);

}

setlistener("sim/signals/fdm-initialized", convertTime);

