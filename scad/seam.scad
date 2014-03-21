seam=10;
gauze=3;
length=50;
self_tap_dia=2;
hole_pitch=12;

difference()
{
	cube([seam,seam,length],center=true);
	translate([seam/2-gauze/2+0.5, seam/2-gauze/2+0.5, 0])
		cube([gauze+1,gauze+1,length+1],center=true);

	for(i=[-1,1])
	{
		translate([seam/2-gauze/2+0.5, 0, i*(length/2-gauze/2+0.5)])
			cube([gauze+1,length+1,gauze+1],center=true);
		translate([0, seam/2-gauze/2+0.5, i*(length/2-gauze/2+0.5)])
			cube([length+1, gauze+1,gauze+1],center=true);
	}

	for(i=[-1,1])
	{
		translate([seam/2, seam/2, i*length/2])
		rotate([0,i*45,0])
			rotate([0,0,45])
				cube([gauze,gauze,length],center=true);
		translate([seam/2, seam/2, i*length/2])
		rotate([-i*45,0,0])
			rotate([0,0,45])
				cube([gauze,gauze,length],center=true);	
	}

	for(i=[-1,1])
	translate([0, 0, i*length/2])
	rotate([-45,90,0])
		rotate([0,0,45])
			cube([gauze,gauze,length],center=true);

	for(i=[1:floor(length/hole_pitch)])
	{
		translate([0, -gauze/2, length/2 - (i+0.25)*hole_pitch])
			rotate([0,90,0])
				cylinder(r=self_tap_dia/2,h=length,center=true,$fn=20);
		translate([-gauze/2, 0, -length/2 + (i+0.25)*hole_pitch])
			rotate([90,0,0])
				cylinder(r=self_tap_dia/2,h=length,center=true,$fn=20);

	}
}
