

cylinderID=125;
gap=1;
thick = gap+1;
cylinderOD=cylinderID+thick;
cylinderLength=250;

clampZ=20;
clampX=153;
clampY=40;
clampThick=10;
clampBase=10;
supportZ=80;
helixThickness=2;
ledgeHeight=10;
ledgeThickness=7;
tChannelGap=20;
footZ=6;

// From PSSupport.scad
PSx = 111.5;
PSy = 51;
PSz = 203;
PSYOffset=0;
dx1=0.2;
dy1=-1.2;
dx2=0.3;
dy2=-2.2;
dx3=1;
dy3=2.2;
dx4=0;
dy4=2.6;

CylinderTop();
//BlankFan();

module CylinderTop()
{
	difference()
	{
		union()
		{
			intersection()
			{
				translate([47+(23-11),-cylinderOD+clampY/2-clampThick+30-(23-12), 0])
					cube([53,53,clampZ/2],center=true);
				Cylinder(rad=(cylinderID/2-ledgeThickness), ht = 2*cylinderLength);
			}
			intersection()
			{
				translate([-47,-cylinderOD+clampY/2-clampThick+30, 0])
					cube([53,53,clampZ/2],center=true);
				Cylinder(rad=(cylinderID/2-ledgeThickness), ht = 2*cylinderLength);
			}
			translate([0,-cylinderOD+clampY/2-clampThick+26, 0])
				translate([16+dx1,-16+dy1,0])
					cylinder(r=4,h=clampZ/2,center=true,$fn=20);
			translate([0,-cylinderOD+clampY/2-clampThick+26, 0])
				translate([-16+dx2,-16+dy2,0])
					cylinder(r=4,h=clampZ/2,center=true,$fn=20);
			translate([0,-cylinderOD+clampY/2-clampThick+cylinderOD-26, 0])
				translate([16+dx3,16+dy3,0])
					cylinder(r=4,h=clampZ/2,center=true,$fn=20);
			translate([0,-cylinderOD+clampY/2-clampThick+cylinderOD-26, 0])
				translate([-16+dx4,16+dy4,0])
					cylinder(r=4,h=clampZ/2,center=true,$fn=20);
	
			difference()
			{
				intersection()
				{
					translate([0,-cylinderOD/2,-clampZ/2+ledgeHeight])
						cube([clampX, clampY+cylinderOD, clampZ/2], center=true);
					Cylinder(rad=cylinderOD/2, ht = 2*cylinderLength);
					
				}	
				translate([0,0,ledgeHeight])
					Cylinder(rad=cylinderOD/2, ht = cylinderLength);
				translate([0,0,-10])
					Cylinder(rad=(cylinderID/2-ledgeThickness), ht = 2*cylinderLength);
				Tube(swell=1);
				PlateScrewHoles();
				FrameClampHoles();
	
				translate([0,-cylinderOD+clampY/2-clampThick+26, 0])
					cylinder(r=22,h=50,center=true,$fn=100);
				translate([0,-cylinderOD+clampY/2-clampThick+cylinderOD-26, 0])
					cylinder(r=22,h=50,center=true,$fn=100);
			}

		}
		BlockClamp(sx=11.5,sy=12.5);
		mirror([1,0,0])
			BlockClamp(sx=21.5,sy=22);

		translate([0,-cylinderOD+clampY/2-clampThick+26, 0])
		{
			translate([16+dx1,-16+dy1,0])
				cylinder(r=2,h=50,center=true,$fn=20);
			translate([-16+dx2,-16+dy2,0])
				cylinder(r=2,h=50,center=true,$fn=20);
		}

		translate([0,-cylinderOD+clampY/2-clampThick+cylinderOD-26, 0])
		{
			translate([16+dx3,16+dy3,0])
				cylinder(r=2,h=50,center=true,$fn=20);
			translate([-16+dx4,16+dy4,0])
				cylinder(r=2,h=50,center=true,$fn=20);
		}
	}				
}

module BlockClamp(sx=23,sy=23)
{
	union()
	{
		translate([37+(23-sx)/2,-cylinderOD+clampY/2-clampThick+40-(23-sy)/2, 0])
			cube([sx,sy,50],center=true);
		translate([37-23/2+5/2+2*(23-sx)/2-2.5/2,-cylinderOD+clampY/2-clampThick+40-23/2+0.2*(23-sy)/2, 0])
			cube([2.5,30-1.1*(23-sy),50],center=true);
		translate([20-23/2+5/2+(23-sx),-cylinderOD+clampY/2-clampThick+26-23/2+1.0*(23-sy)/2, 0])
			cube([30,2,50],center=true);
		translate([20+5/2+(23-sx)/2,-cylinderOD+clampY/2-clampThick+31-23/2+0.8*(23-sy)/2, -2])
			rotate([0,90,0])
				cylinder(r=1.7, h=50, center=true, $fn=20);
		translate([55-23/2+5/2+(23-sx)/2,-cylinderOD+clampY/2-clampThick+30-23/2+0.6*(23-sy)/2, 0])
			cube([10,10,50],center=true);
	}	

}

module Tube(swell = 0)
{
	difference()
	{
		Cylinder(rad=cylinderOD/2, ht = cylinderLength);
		Cylinder(rad=(cylinderID - swell)/2, ht = 2*cylinderLength);
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
		for(ang=[0:2])
		{
			rotate([0,0,ang*120+86])
			{
				translate([0, cylinderOD/2-ledgeThickness/2-(cylinderOD-cylinderID)/2, 
					0])
				{
					cylinder(r=1.7, h=50, center=true, $fn=20);
					if(ang != 2)
					translate([0, 0, -clampZ/2+1])
						cylinder(r1=3, r2=1.7, h=2, center=true, $fn=20);
				}
			}
		}
	}
}

module BlankFan()
{
	difference()
	{
		cube([40,40,3], center=true);
		cylinder(r=38/2,h=20,center=true,$fn=50);
		for(x=[-1,1])for(y=[-1,1])
			translate([x*16,y*16,0])
				cylinder(r=1.7, h=50, center=true, $fn=20);
	}
}




