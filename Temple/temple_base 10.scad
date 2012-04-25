coldiameter = 16;
mod = coldiameter;
colheight = 82;
cbdiameter = 21;				//diameter of column base (for inset)
b_length = colheight/1.618;
b_width = cbdiameter *1.3;
b_height = cbdiameter/4;
step_width = b_height * 1.5;

//straight_base();
//translate([0,b_width+15,0]) straight_base();
//steps(2);
//corner_base();
//corner_steps(2);
//step_unit(2);
corner_unit(2);

module corner_unit(flights) {
	corner_base();
	rotate([0,0,180]) translate([-b_length+b_width/2,-b_length+b_width/2,0]) 
		corner_steps(flights);
}

module step_unit(flights) {
	rotate([0,0,180]) translate([-b_length*2+b_width/2,-b_width,0]) 
	 	union() { straight_base(); steps(flights);}
}

module large_corner_unit(flights) {
	rotate([0,0,180]) translate([-b_length*2+b_width/2,-b_width,0]) 
	 	union() { straight_base(); steps(flights);}
	translate([b_width,b_length-b_width/2,0]) rotate([0,0,90]) 
		union() { straight_base(); steps(flights);}
	corner_base();
	rotate([0,0,180]) translate([-b_length+b_width/2,-b_length+b_width/2,0]) 
		corner_steps(flights);
}

module corner_steps(flights) {
for ( i = [1 : flights] ) {
	translate([0,0,-b_height*i])
	difference() {
		cube([b_length-b_width/2+(step_width*i),b_length-b_width/2+(step_width*i),b_height]);
		translate([b_width/6,b_width/6,0])
		cube([b_length-b_length/2.5+(step_width*(i-1)),b_length-b_length/2.5+(step_width*(i-1)),b_height+b_height/10]);
	}
	}
}

module steps(flights) {
for ( i = [1 : flights] ) {
	translate([0,0,-b_height*i])
	difference() {
		cube([b_length,(step_width*i)+b_width,b_height]);
		translate([b_length/10,b_width/10,0])
		cube([b_length-b_length/5,b_width-b_width/10+(step_width*(i-1)),b_height+b_height/10]);
	}
//	difference () {
		translate([0,-b_width/3,-b_height*i])  cube([b_length,b_width/3,b_height]);

//	}
	}
}

module corner_base() {
difference() {
	union() {
	cube([b_length-b_width/2,b_width,b_height]);
	cube([b_width, b_length-b_width/2, b_height]);
	}
	translate([b_width/2,b_width/2,b_height*.75])
		cylinder(h=b_height*.5,r=cbdiameter*.54);
	}
}

module straight_base() {
difference() {
	cube([b_length,b_width,b_height]);
	translate([b_length/2,b_width/2,b_height*.75])
		cylinder(h=b_height*.5,r=cbdiameter*.54);   //fudge factor
	translate([b_length/20,b_width/5,0])
		cube([b_length/2-(b_length/10),b_width-(2*b_width/5),b_height/2]);
	translate([b_length/20+b_length/2,b_width/5,0])
		cube([b_length/2-(b_length/10),b_width-(2*b_width/5),b_height/2]);}
}

