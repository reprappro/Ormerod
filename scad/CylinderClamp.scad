
PSx = 110;
PSy = 50;
PSz = 203;
PSYOffset=-2;

cylinderOD=125;
cylinderID=cylinderOD-2;
cylinderLength=250;

clampZ=40;
clampX=160;
clampY=40;
clampThick=10;
clampBase=10;
supportZ=80;
helixThickness=2;
ledgeHeight=10;
ledgeThickness=7;


CylinderClamp();

//Tube();
//PSU();

module CylinderClamp()
{
	union()
	{
		difference()
		{
			union()
			{
				cube([clampX, clampY, clampZ], center=true);
				intersection()
				{
					translate([0,-cylinderOD/2,-clampZ/2+ledgeHeight])
						cube([clampX, clampY+cylinderOD, clampZ/2], center=true);
					Cylinder(rad=cylinderOD/2, ht = 2*cylinderLength);
				}
			}
			translate([0,0,ledgeHeight])
				Cylinder(rad=cylinderOD/2, ht = cylinderLength);
			translate([0,0,-10])
				Cylinder(rad=(cylinderID/2-ledgeThickness), ht = 2*cylinderLength);
			Tube();
			PlateScrewHoles();
		}
		Support(ang=50);
		Support(ang=-50);
	}
}

module Tube()
{
	difference()
	{
		Cylinder(rad=cylinderOD/2, ht = cylinderLength);
		Cylinder(rad=cylinderID/2, ht = 2*cylinderLength);
	}
}

module Cylinder(rad=125, ht = 200)
{
	translate([0, -cylinderOD/2+clampY/2-clampThick, 
		cylinderLength/2-clampZ/2+clampBase])
			cylinder(r = rad, h = ht, center=true, $fn=250);
}

module PlateScrewHoles()
{
	translate([0, -cylinderOD/2+clampY/2-clampThick, 0])
	union()
	{
		for(ang=[0:3])
		{
			rotate([0,0,ang*90])
			{
				translate([0, cylinderOD/2-ledgeThickness/2, 0])
				{
					cylinder(r=1.7, h=50, center=true, $fn=20);
					translate([0, 0, -clampZ/2+1])
						cylinder(r1=3, r2=1.7, h=2, center=true, $fn=20);
				}
			}	
		}
	}
}

module Support(ang=30)
{
	difference()
	{
		translate([0, -cylinderOD/2+clampY/2-clampThick, 0])
		rotate([0,0,ang])
		translate([0, cylinderOD/2+clampY/2-1, 
			supportZ/2+clampZ/2-1])
		{
			difference()
			{
				cube([10, clampY, supportZ], center=true);
				translate([0, -clampY + helixThickness+1, -10])
					difference()
					{
						cube([20, clampY, supportZ], center=true);
						translate([0, clampY/2+5, supportZ/2+5])
							rotate([30,0,0])
								cube([30, 20, 20], center=true);
					}
				translate([0, -clampY/2+4, supportZ/2-4-7/2])
					cube([20, 2, 7], center=true);
				translate([0, clampY/2+8, 0])
					rotate([15,0,0])
						cube([30, clampY, 2*supportZ], center=true);
			}
		}
		Cylinder(rad=cylinderOD/2, ht = cylinderLength);
	}
}

module PSU()
{
	translate([0, -cylinderOD/2+clampY/2-clampThick + PSYOffset, 
		cylinderLength/2-clampZ/2+clampBase])
			cube([PSx, PSy, PSz], center=true);
}