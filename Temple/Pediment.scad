coldiameter = 17.5;
mod = coldiameter;					//this is the diameter of a column
//height = mod * 6;					//height of a column
length = 90;
width = (length * 7/6) * .618;  	//golden rectangle

angle = 12;
hl = length/cos(angle)*1.02;

pediment_end();

module pediment_end() {

	cube([length,length/8,length/50]);
	difference() {
		union() {
			rotate([0,-angle,0]) translate([0,0,-length/30])
				cube([hl,length/10,length/25]);
			rotate([0,-angle,0])	translate([0,0,0]) 
				cube([length*1.05,length/8,length/40]);
		}
	translate([length,0,0]) cube([length/25,length/8,length/2]);
	#translate([0,0,-length/25]) cube([length,length/8,length/25]);
	}
}



