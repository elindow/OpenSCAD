coldiameter = 16;
mod = coldiameter;
ch = mod*6;		//column height
cr = mod/2;		//column radius
nf = 20;		//number of flutes
fr = 1.5;		//flute radius
fvo = 2; //flute vertical offset 
fho = .65; //flute horizontal offset (outwards)

bh = mod/2;  //base height
bo = mod/8; 	// base offset
btr = bo*.625;  //base torus radius
base_plate = 1;		//1 for a square plate, 0 for no plate

cph = mod/2;  //capitol height
cpo = mod/10; // capitol offset
ctr = cpo*.8;   //capitol torus radius
has_abacus = 1; //1 for abacus 0 for no abacus

$fs = 1;
aa = 6;

base();
column();
capitol();

module column() {
translate([0,0,bh])
difference(){
	ring(ch,cr,cr-(4*fho),aa);
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
		union() {
		ring(bh*.5,cr+bo,cr-bo,10);
		translate([0,0,bh*.5]) ring(bh*.5,cr+btr,cr-bo,10);
		}
	translate([0,0,bh*.5]) torus(cr+bo,btr);
	}
	translate([0,0,btr*1.1]) torus(cr+bo,btr*1.1);
	translate([0,0,bh*.8]) torus(cr+bo*.5,btr*.9);
	echo(bh*.75+(2*btr*.95));
	if ( base_plate == 1 )
		difference() {
		translate([0,0,-bh*.15]) cube([2*(cr+bo+btr),2*(cr+bo+btr),bh*.33],center=true);
			translate([0,0,-bh*.35]) cylinder(h=bh*.5,r = cr-bo);
		}
}

module capitol() {
	translate([0,0,ch+cph]) {
	difference() {
		ring(cph,cr+cpo,cr-bo,aa);
		translate([0,0,cph/2]) torus(cr+cpo+.75,ctr*1.5);
		}
	translate([0,0,ctr]) torus((cr+cpo)*.9,ctr);
	translate([0,0,ctr+cph*.67]) torus((cr+cpo)*1.05,ctr*1.1);
	if ( has_abacus == 1 )	{
		difference() {
			translate([0,0,cph]) cube([(cr+cpo+ctr*1.4)*2,(cr+cpo+ctr*1.4)*2,cph/3], center= true);
			translate([0,0,cph/2]) cylinder(h=cph,r = cr-bo);
			}
		if ( has_abacus == 0 ) {

			}
		}
	
	}
}

