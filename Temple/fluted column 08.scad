ch = 45;		//column height
cr = 20;		//column radius
nf = 16;		//number of flutes
fr = 2;		//flute radius
fvo = 3; //flute vertical offset 
fho = 1; //flute horizontal offset (outwards)

bh = 3.5;  //base height
bo = 3; // base offset
cph = 3.5;  //capitol height
co = 1.5; // capitol offset

$fs = 1;
aa = 6;

module column() {
translate([0,0,bh])
difference(){
	ring(ch,cr,cr-(2*fho),aa);
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
rotate_extrude(convexity = 20)
translate([w, 0, 0])
circle(r = r, $fn = 50);
}

module base() {
difference() {
	ring(bh,cr+bo,cr-cr,10);
	translate([0,0,bh])
	torus(cr+bo,1.5);
}
}

module capitol() {
	translate([0,0,ch+cph])
	difference() {
		ring(cph,cr+co,cr-co,aa);
		translate([0,0,-.1])
		torus(cr+co+.75,2.5);
	}
}

base();
column();
capitol();