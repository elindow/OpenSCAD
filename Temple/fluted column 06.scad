ch = 20;		//column height
cr = 10;		//column radius
nf = 30;		//number of flutes
fr = 1;		//flute radius
fvo = 1.5; //flute vertical offset 
fho = .5; //flute horizontal offset (outwards)

bh = 1.75;  //base height
bo = 1.5; // base offset
cph = 2;  //capitol height
co = .75; // capitol offset

$fs = 2;
aa = 12;

module column() {
translate([0,0,bh])
difference(){
	ring(ch,cr,cr-fho,aa);
	for ( i = [0 : 360/nf : 360] ) {
		rotate(i)
		flute();
		}
	}
}

module flute() {
	translate([cr+fho+.01,0,fvo])     //small offset needed to make manifold
		cylinder(h=ch-(2*fvo),r=fr);
	translate([cr+fho,0,fvo])
		sphere(r=fr);
	translate([cr+fho,0,ch-fvo])
		sphere(r=fr);
}

module ring(h,r1,r2,aa) { 
difference() {
cylinder(h=h,r=r1,$fa=aa);
cylinder(h=h,r=r2,$fa=aa);
}
}

module torus(w,r) {
rotate_extrude(convexity = 10)
translate([w, 0, 0])
circle(r = r, $fa = 12);
}

module base() {
difference() {
	ring(bh,cr+bo,cr-cr,10);
	translate([0,0,bh])
	#	torus(cr+bo,.75);
}
}

module capitol() {
	translate([0,0,ch+1])
	difference() {
		ring(cph,cr+co,cr-co,aa);
		translate([0,0,-.25])
		#	torus(cr+co,.95);
	}
}

base();
column();
capitol();