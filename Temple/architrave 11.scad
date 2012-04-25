coldiameter = 17;
mod = coldiameter;
cpo = mod/10; // capitol offset
ch = mod*5* 1.24;
colid = 10.25;  			    //inner (open) diameter of column
colih = mod/3;				   // height of boss for column
length = ch * .618;  // for golden rectangle
height = ch/15;
width = (mod + (cpo*2))* 1.0;  //allows over or under hang if desired
angle = 1;

echo("Width=",width);

f_overhang = 2;			  //frieze overhang
f_height = height*2;		  //frieze height
f_d = .03; 					// amount of triglyph inset

c_overhang = 2;			  //cornice overhang
c_height = height *2/3;		  //cornice height
c_length = length;

//abacus();
//multi_abacus();
beam();
//corner();
//qr();
//tri();
//frieze_beam(2); 		  // parmeter is number of trigliphs
//frieze_corner();
//rotate([180,0,0]) translate([0,-18,-f_height-c_height]) {cornice_beam();}
//cornice_beam(1);
//cornice_corner();


module cornice_corner() {

}

module cornice_beam(type) {
	if ( type == 0 ) {
		cube([c_length,width+c_overhang,c_height]);
		}
	if ( type == 1 ) {
		cube([c_length*.75,width+c_overhang,c_height]);
		}
	
	translate([length*.065,width/6.5,c_height])
		cube([length/2-(length*.125),width-(width*.25),c_height/1.5]);

		if (type == 0 ) {
		translate([length/2 + (length*.065),width/6.5,c_height])
			cube([length/2-(length*.125),width-(width*.25),c_height/1.5]);
		}
		if (type == 1 ){
		translate([length/2 + (length*.055),width/6.5,c_height])
			cube([length/2-(length*.312),width-(width*.25),c_height/1.5]);
		}

}


module frieze_corner() {
	union() {	
	difference() {
	cube([length/2+mod/4,width,f_height]);
	translate([length/25,width/10,height/10])
		cube([length/2+mod/4-length/12,width-width/5,f_height]);
	translate([width/2,width/2,0])
		cylinder(h = height/2, r = width/8, $fs = angle);
	}
	//translate([width-length/20,0,0])  cube([length/25,width,f_height]);
	rotate([0,90,0]) {
		qr(length/2+mod/4);
	}
	translate([0,-f_height/12,f_height*.7]) cube([length/2+mod/4,f_height/12,f_height/6]);
	translate([0,0,f_height]) rotate([90.001,0,90])  {
		qr(length/2+mod/4);
	}
	translate([mod/4,-f_height/10,0])
		tri();
	//translate([(length/4)*2+(length/10),-f_height/15,0])
	//	tri();
	}
	union() {
	difference() {
	cube([width,(length/2)+(mod*.75),f_height]);
	translate([width/10,length/30,height/10])
		cube([width-width/5,(length/2)+(mod*.75)-length/15,f_height]);
	translate([width/2,width/2,0])
		cylinder(h = height/2, r = width/8, $fs = angle);
//	translate([width/2,3*length/4,0])
//		cylinder(h = height/2, r = width/8, $fs = angle);	
	}
	//translate([0,width-length/20,0])  cube([length/20,width,f_height]);
	translate([0,length/1.317,0]) rotate([90,90,0]) {
		qr(((length/2)+mod*.79));
	}
	translate([0,-length*.015,f_height]) rotate([180.001,270,90])  {
		qr(((length/2)+mod*.79));
	}
	translate([-f_height/12,-f_height/12,f_height*.7]) cube([f_height/12,length/2+coldiameter*.75+f_height/12,f_height/6]);
	translate([-f_height/10,mod*.76,0]) rotate([0,0,270])
		tri();
	translate([-f_height/10,length-(mod*.7),0]) rotate([0,0,270])
		tri();
	}
}


module frieze_beam(number) {
union() {
	difference() {
	cube([length,width,f_height]);
	translate([length/20,width/10,height/10])
		cube([length-length/10,width-width/5,f_height]);
	translate([length/4,width/2,0])
			cylinder(h = height/2, r = width/8, $fs = angle);
	translate([3*length/4,width/2,0])
			cylinder(h = height/2, r = width/8, $fs = angle);	}
	translate([length/2-length/20,0,0])  cube([length/10,width,f_height]);
	rotate([0,90,0]) {
		qr(length);
	}
	translate([0,0,f_height]) rotate([90.001,0,90])  {
		qr(length);
	}
//	translate([0,width,0]) rotate([90,180,90])  {
//		qr(length);
//	}
//	translate([0,width,f_height]) rotate([90,270,90])  {
//		qr(length);
//	}
#translate([0,-f_height/12,f_height*.7]) cube([length,f_height/12,f_height/6]);
if ( number == 3 ) {
	translate([0,-f_height/15,0])
		tri();
	translate([(length/5)*2,-f_height/15,0])
		tri();
	translate([(length/5)*4,-f_height/15,0])
		tri();
	}
else if ( number == 2 ){
	translate([(length/4)*0,-f_height/10,0])
		tri();
	translate([(length/4)*2,-f_height/10,0])
		tri();
	}
}
}


module qr(len) {

	difference() {
		cylinder(h = len, r = f_height/6, $fs = angle);
		translate([-f_height/3,0,0])
			cube([f_height/2.5,f_height/4,len]);
		translate([0,-f_height/4,0])
			cube([f_height/4,f_height/2,len]);
		}
}

module tri() {
	difference() {

		translate([0,0,f_height/7])
			cube([mod/2,f_height/10,f_height-f_height/3]);					//basic plate shape
		translate([0,-f_height*f_d,0])
			scale([1,1.5,1]) cylinder(r = mod*.05, h = f_height-f_height/6, $fs = .05);	//left half groove
		translate([modr*.167,-f_height*f_d,0])
			scale([1,1.5,1]) cylinder(r = mod*.05, h = f_height-f_height/6, $fs = .05);	//left full groove
		translate([mod*.333,-f_height*f_d,0])
			scale([1,1.5,1]) cylinder(r = mod*.05, h = f_height-f_height/6, $fs = .05);	//right full groove
		translate([mod/2,-f_height*f_d,0])
			scale([1,1.5,1]) cylinder(r = mod*.05, h = f_height-f_height/6, $fs = .05);	//right half groove
		}
	translate([0,-f_height/20,f_height*.7])
		cube([mod/2,f_height/7,f_height/7]);
}

module beam() {
	difference() {
		cube([length, width, height]);
		translate([length/4,width/2,0])
			cylinder(h = height/2, r = width/4, $fs = angle);
		translate([3*length/4,width/2,0])
			cylinder(h = height/2, r = width/4, $fs = angle);		}
	difference() {
		translate([0,width/2,0])
			cylinder(h = (height + colih), r1 = colid/2, r2 = colid/2.25, $fs = angle);
		translate([-colid/2,0,0])
			cube([colid/2,width,height*2]);
		}
	difference() {
		translate([length,width/2,0])
			cylinder(h = (height + colih), r1 = colid/2, r2 = colid/2.25, $fs = angle);
		translate([length,0,0])
			cube([colid/2,width,height*2]);
		}
}

module corner() {
	difference() {
		cube([length+width/2, width, height]);
		translate([width/2,width/2,0])
			cylinder(h = height/2, r = width/8, $fs = angle);
		translate([3*(length+width/2)/4,width/2,0])
			cylinder(h = height/2, r = width/8, $fs = angle);	
		}
	difference() {
		translate([0,width,0])
			cube([width, length-width/2, height]);
		translate([width/2,3*(length+width/2)/4,0])
			cylinder(h = height/2, r = width/8, $fs = angle);
		}
	translate([width/2,width/2,height/2])
		cylinder(h = (height/2 + colih), r = colid/2, $fs = angle);
	difference() {
		translate([length+width/2,width/2,0])
			cylinder(h = (height + colih), r = colid/2, $fs = angle);
		translate([length+width/2,0,0])
			cube([colid/2,width,height*2]);
		}
	difference() {
		translate([width/2,length+width/2,0])
			cylinder(h = (height + colih), r = colid/2, $fs = angle);
		translate([0,length+width/2,0])
			cube([width,colid/2,height*2]);
		}
}

module abacus() {
	translate([(width*1.1)/2,(width*1.1)/2,height/2])
		cylinder(h = height/2, r = colid/2, $fs = angle);
	difference() {
		cube([width*1.1,width*1.1,height/2]);
		translate([(width*1.1)/2,(width*1.1)/2,0])
			cylinder(h = (height/2)-.65, r =colid/1.75, $fs = angle);
		}
}

module multi_abacus() {
abacus();
translate([width*1.5,0,0])
	abacus();
translate([0,width*1.5,0])
	abacus();
translate([width*1.5,width*1.5,0])
	abacus();
}

