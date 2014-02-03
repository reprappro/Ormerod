/*
	Adrian
	31 Jan 2014

*/
difference()
{
	union()
	{
		difference()
		{
			cylinder(r=10.5+4,h=6,center=true,$fn=50);
			cylinder(r=10.5,h=10,center=true,$fn=50);
		}
		translate([11+5,0,0])
			cube([10,10,6],center=true);
		translate([0, 11+5, -1])
			cube([10,10,4],center=true);
	}
	translate([11+5,0,0])
		cube([20,3,8],center=true);
	translate([11+7,0,0])
		rotate([90,0,0])
			cylinder(r=1.7,h=15,center=true,$fn=20);
	translate([0, 11+7, 0])
			cylinder(r=1.7,h=15,center=true,$fn=20);
}
