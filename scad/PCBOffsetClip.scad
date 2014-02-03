/*
  Allows a PCB to be mounted using holes not of the same pitch as the centres
	of its own holes.

	Adrian

	3 February 2014

*/

// Distance between holes.  (Duet needs 6.6, 11.1 and 13.5 + a spacer)

offset = 6.6;

// How far to separate the PCB from the surface under it

height = 7;

PCBOffsetClip();

//PCBSpacer();

module PCBSpacer()
{
	difference()
	{
		cylinder(r = 5, h = height, center=true, $fn=30);
		cylinder(r = 1.7, h = 2*height, center=true, $fn=30);
	}
}

module PCBOffsetClip()
{
	difference()
	{
		RoundEnd([offset,10,height]);
		for(x=[-1,1])
			translate([x*offset/2,0,0])
				cylinder(r=1.7, h = height*2, center=true, $fn=30);
		translate([-offset,0,height/2])
			cube([2*offset, 11, height], center=true);
		translate([-offset/2,0,-0.8])
 			cylinder(r2 = 5.5/2, r1=1.7, h = 1.8, 
				center=true, $fn=30);
		translate([offset/2,0,-2])
			rotate([0,0,30])
 			cylinder(r = 5.6 / 2 / cos(180 / 6) + 0.05, h = height, 
				center=true, $fn=6);
 
	}
}

module RoundEnd(b = [10,5,5])
{
	union()
	{
		cube(b, center=true);
		for(x=[-1,1])
		translate([x*b.x/2,0,0])
			cylinder(r=b.y/2, h=b.z, center=true, $fn=30);
	}
}