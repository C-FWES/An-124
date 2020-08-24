# =============================== IKU support =============================
iku_handler = func {
	settimer(iku_handler, 0.1);

	#Captain panel
	# yellow needle
	var sel_yellow = getprop("an124/instrumentation/iku-1[0]/l-mode");
	if( sel_yellow == nil ) sel_yellow = 0.0;
	var param_yellow = getprop("instrumentation/nav[0]/radials/reciprocal-radial-deg");
	if( param_yellow == nil ) param_yellow = 0.0;
	var compass = getprop("/orientation/heading-deg");
	if( compass == nil ) compass = 0.0;

	if( sel_yellow == 0.0 ) # ADF
		param_yellow = getprop("instrumentation/adf[0]/indicated-bearing-deg");
	else param_yellow -= compass;

	if( param_yellow == nil ) param_yellow = 0.0;
	setprop("an124/instrumentation/iku-1[0]/indicated-heading-l", param_yellow );


	# White needle
	var sel_white = getprop("an124/instrumentation/iku-1[0]/r-mode");
	if( sel_white == nil ) sel_white = 0.0;
	var param_white = getprop("instrumentation/nav[1]/radials/reciprocal-radial-deg");
	if( param_white == nil ) param_white = 0.0;

	if( sel_white == 0.0 ) # ADF
		param_white = getprop("instrumentation/adf[1]/indicated-bearing-deg");
	else param_white -= compass;

	if( param_white == nil ) param_white = 0.0;

	setprop("an124/instrumentation/iku-1[0]/indicated-heading-r", param_white );
}
settimer(iku_handler, 2);

# =============================== IDR-1 support =============================
idr_capt_handler = func {
	settimer(idr_capt_handler, 0.1);

	var distance = 0.0;
	var caged = 1;
 		
	if(getprop("instrumentation/nav[0]/in-range") == 1 ) {
		if((getprop("instrumentation/nav[0]/nav-loc") == 0) # not ILS (VOR)
	 	or (getprop("instrumentation/nav[0]/dme-in-range") == 1)) # ILS with DME
		{
			setprop("an124/instrumentation/idr-1[0]/caged-flag", 0);
			distance = getprop("instrumentation/nav[0]/nav-distance");     
			caged = 0;
		}
		else distance = 0.0;
	}

	setprop("an124/instrumentation/idr-1[0]/caged-flag", caged );


	if(distance == nil)
	{
		setprop("an124/instrumentation/idr-1[0]/caged-flag", 1);
		return;
	}

  distance = distance/10.0; # to dec meters, it need for correct work of digit wheels
  setprop("an124/instrumentation/idr-1[0]/indicated-wheels_dec_m", 
  (distance/10.0) - int( distance/100.0 )*10.0 );
  setprop("an124/instrumentation/idr-1[0]/indicated-wheels_hund_m", 
  (distance/100.0) - int( distance/1000.0 )*10.0 );
  setprop("an124/instrumentation/idr-1[0]/indicated-wheels_ths_m", 
  (distance/1000.0) - int( distance/10000.0 )*10.0 );
  setprop("an124/instrumentation/idr-1[0]/indicated-wheels_decths_m", 
  (distance/10000.0) - int( distance/100000.0 )*10.0 );

  distance = distance * 0.621; # km to miles
  setprop("an124/instrumentation/idr-1[0]/indicated-wheels_dec_miles", 
  (distance/10.0) - int( distance/100.0 )*10.0 );
  setprop("an124/instrumentation/idr-1[0]/indicated-wheels_hund_miles", 
  (distance/100.0) - int( distance/1000.0 )*10.0 );
  setprop("an124/instrumentation/idr-1[0]/indicated-wheels_ths_miles", 
  (distance/1000.0) - int( distance/10000.0 )*10.0 );
  setprop("an124/instrumentation/idr-1[0]/indicated-wheels_decths_miles", 
  (distance/10000.0) - int( distance/100000.0 )*10.0 );
}
settimer(idr_capt_handler, 2);

######################################################################
#
# RV-5M
#
var rv_altitude_update = func {
    var alt_m = getprop("position/altitude-agl-ft") * 0.3048;
    settimer(rv_altitude_update, (alt_m < 1200 ? 0.1 : (alt_m - 900) / 300));
    if (alt_m > 0) {
        var pitch_deg = getprop("orientation/pitch-deg");
        var roll_deg = getprop("orientation/roll-deg");
        if (-90 < pitch_deg and pitch_deg < 90
            and -90 < roll_deg and roll_deg < 90) {
            var beam_rad = math.acos(math.cos(pitch_deg / 57.3)
                                     * math.cos(roll_deg / 57.3));
            if (beam_rad > 0.262) { # > 15 degrees
                beam_rad -= 0.262;
                alt_m /= math.cos(beam_rad);
            }
            if (alt_m > 850)
                alt_m = 850;
        } else {
            alt_m = 850;
        }
    } else {
        alt_m = 0;
    }
    setprop("an124/instrumentation/rv-5m/indicated-altitude-m", alt_m);
}
rv_altitude_update();

rv5m_l = func(step) {
  var rv_alt = getprop("instrumentation/altimeter/indicated-altitude-ft");
  rv_alt = rv_alt * 0.3048;
  var ind_alt = getprop("an124/instrumentation/rv-5m/index-m");
  if ( step < 0) {
    if (ind_alt > 99) {
      ind_alt = ind_alt + 10;
    } else {
      ind_alt = ind_alt + 1;
    }
  } else {
    if (ind_alt > 99) {
      ind_alt = ind_alt - 10;
    } else {
      ind_alt = ind_alt - 1;
    }
  }
  if (ind_alt > 700){ ind_alt = 700;}
  if (ind_alt < 0) { ind_alt = 0;}
  
  setprop("an124/instrumentation/rv-5m/index-m",ind_alt);
}

#setprop("an124/stanchion", 1);
#setprop("consumables/fuel/tank[8]/selected", 0);

