/*
  Vertical mounting for 20A 12V PSU.

	Adrian

	3 February 2014

*/

//rotate([180,0,0]) // Uncomment for toppclip
PSSupport(topClip=false);

//*******************************************************************

PSx = 111.5;
PSy = 51;

BaseZ=3;
liftZ=10;
shim = 5;
cornerSize=45;
tubeD=125;
PSYOffset=-3.5;
chopY=-3.5;

XMountHole1=10;
XMountHole2=95;
ZMountHole12=12 + liftZ;
YMountHole3=37;
ZMountHole3=20.5 + liftZ;

height = ZMountHole3 + BaseZ + 5.5;
drop = height - BaseZ;

DuetHoleDX=92;
DuetHoleZ=22+liftZ;
DuetHoleX=-3;


module PSSupport(topClip=false)
{
	intersection()
	{
		intersection()
		{
			difference()
			{
				translate([0,0,0.5*height])
					cube([PSx+6, PSy+6, height], center=true);
		
				translate([0,0,BaseZ+0.5*height])
				{
					union()
					{
						difference()
						{
							cube([PSx, PSy, height], center=true);
							for(x=[0,1])for(y=[0,1])
							translate([-(2*x-1)*(PSx+6)/2, (2*y-1)*(PSy+6)/2,
								-height/2 + x*y*shim - shim])
									cube([30, 30, 2*(liftZ+shim)], center=true);
						}
						if(!topClip)
							cube([PSx-40, PSy+20, height], center=true);
					}
				}
				cube([PSx-30, PSy-30, 4*height], center=true);
				for(x=[-1,1])for(y=[-1,1])
					translate([x*(PSx-45)/2,y*(PSy-15)/2,0])
						cylinder(r=1.7,h=4*height,center=true,$fn=30);
		
				// Mounting hole centres
				echo((PSx-45));
				echo((PSy-15));
		
				DuetHoles();

				if(!topClip)
				{
					HorizontalMountHoles();

					translate([-(PSx-36)/2, -20, height-3])
						cube([5, 50, 10], center=true);	
				}		
			}
			translate([0,PSYOffset,0])
				cylinder(r=tubeD/2,h=500,center=true,$fn=200);
		}

		if(topClip)
		{
			translate([0,0,DuetHoleZ+5])
			difference()
			{
				cube([PSx*2, PSy*2, 12], center=true);
				translate([-PSx/2+18-DuetHoleX,-PSy/2,-5])
					cube([20, 200, 5], center=true);
			}
		}
		translate([0, chopY, 0])
				cube([PSx*2, PSy+6, 200], center=true);		
	}
}


module HorizontalMountHoles()
{
	union()
	{
	translate([-PSx/2+XMountHole1,-PSy/2,BaseZ+ZMountHole12])
		rotate([90,0,0])
		{
			cylinder(r=1.7,h=10,center=true,$fn=30);
			translate([0,0,2])
				cylinder(r1=1.7, r2=6/2 ,h=2.5,center=true,$fn=30);
		}
	translate([-PSx/2+XMountHole2,-PSy/2,BaseZ+ZMountHole12])
		rotate([90,0,0])
		{
			cylinder(r=1.7,h=12,center=true,$fn=30);
			translate([0,0,2])
				cylinder(r1=1.7, r2=6/2 ,h=2.5,center=true,$fn=30);
		}
	translate([PSx/2,-PSy/2+YMountHole3,BaseZ+ZMountHole3])
		rotate([0,90,0])
		{
			cylinder(r=1.7,h=12,center=true,$fn=30);
			translate([0,0,2])
				cylinder(r1=1.7, r2=6/2 ,h=2.5,center=true,$fn=30);
		}
	}
}


module DuetHoles()
{
	union()
	{
		translate([-DuetHoleDX/2+DuetHoleX,-PSy/2,BaseZ+DuetHoleZ])
		{
			rotate([90,0,0])
				cylinder(r=1.7,h=10,center=true,$fn=30);
			rotate([90,0,0])
				translate([0,0,1.2])
					cylinder(r2=1.7, r1=6/2 ,h=2.5,center=true,$fn=30);			
		}
		translate([DuetHoleDX/2+DuetHoleX,-PSy/2,BaseZ+DuetHoleZ])
		{
			rotate([90,0,0])
				cylinder(r=1.7,h=12,center=true,$fn=30);
			rotate([90,0,0])
				translate([0,0,1.2])
					cylinder(r2=1.7, r1=6/2 ,h=2.5,center=true,$fn=30);
		}
	}
}

