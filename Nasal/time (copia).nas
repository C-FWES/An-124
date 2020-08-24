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





 


