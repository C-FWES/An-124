# =====
# Cargo, by Andino
# =====

locomotive = aircraft.door.new("/sim/model/cargo/locomotive", 60, 0 );
container = aircraft.door.new("/sim/model/cargo/container", 60, 0 );
container2 = aircraft.door.new("/sim/model/cargo/container2", 60, 0 );
container3 = aircraft.door.new("/sim/model/cargo/container3", 60, 0 );
container4 = aircraft.door.new("/sim/model/cargo/container4", 60, 0 );
container5 = aircraft.door.new("/sim/model/cargo/container5", 60, 0 );
container6 = aircraft.door.new("/sim/model/cargo/container6", 60, 0 );
helicopter = aircraft.door.new("/sim/model/cargo/helicopter", 60, 0 );
helicopter2 = aircraft.door.new("/sim/model/cargo/helicopter2", 60, 0 );
helicopter3 = aircraft.door.new("/sim/model/cargo/helicopter3", 60, 0 );
helicopter4 = aircraft.door.new("/sim/model/cargo/helicopter4", 60, 0 );

var Peso = func {

 if (getprop("/sim/model/cargo/locomotive/position-norm") > 0.6) {
    var pesoloco = 66138
} else {
   var pesoloco = 0
}

 if (getprop("/sim/model/cargo/container/position-norm") > 0.6) {
    var pesocont = 39683
} else {
   var pesocont = 0
}
 
 if (getprop("/sim/model/cargo/container2/position-norm") > 0.6) {
    var pesocont2 = 39683
} else {
   var pesocont2 = 0
}

 if (getprop("/sim/model/cargo/container3/position-norm") > 0.6) {
    var pesocont3 = 39683
} else {
   var pesocont3 = 0
}

 if (getprop("/sim/model/cargo/container4/position-norm") > 0.6) {
    var pesocont4 = 39683
} else {
   var pesocont4 = 0
}

 if (getprop("/sim/model/cargo/container5/position-norm") > 0.6) {
    var pesocont5 = 39683
} else {
   var pesocont5 = 0
}

 if (getprop("/sim/model/cargo/container6/position-norm") > 0.6) {
    var pesocont6 = 39683
} else {
   var pesocont6 = 0
}

 if (getprop("/sim/model/cargo/helicopter/position-norm") > 0.6) {
    var pesoheli = 10624
} else {
   var pesoheli = 0
}

 if (getprop("/sim/model/cargo/helicopter2/position-norm") > 0.6) {
    var pesoheli2 = 10624
} else {
   var pesoheli2 = 0
}

 if (getprop("/sim/model/cargo/helicopter3/position-norm") > 0.6) {
    var pesoheli3 = 10624
} else {
   var pesoheli3 = 0
}

 if (getprop("/sim/model/cargo/helicopter4/position-norm") > 0.6) {
    var pesoheli4 = 10624
} else {
   var pesoheli4 = 0
}


 var pesounido = (pesoloco + pesocont + pesocont2 + pesocont3 + pesocont4 + pesocont5 + pesocont6 + pesoheli + pesoheli2 + pesoheli3 + pesoheli4);

 setprop("sim/weight[1]/weight-lb", pesounido);

settimer(Peso, 0.1);

}

setlistener("sim/signals/fdm-initialized", Peso);
