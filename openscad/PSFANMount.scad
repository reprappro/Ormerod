wall=2;
innerX=40;
innerY=52;//54;
innerZ=47.5-wall;
dZ=38.5;
solidY=43;//47;
stepY=14;//17-4;
stepZ=22;//19;
screw1X=26;
screw1Z=innerZ-2.5+wall;
screw2Y=4.5;
screw2Z=7.5;
fanX=wall+innerX/2;
fanY=32;
flapZ=12;//12;
flapY=10;
flapA=60;
flapX=60;
lug=2.5;
fanheight=11.5;
fanrib=1;

PSUFanHousing();
//Flap();

module PSUFanHousing()
{
	union()
		{
			difference()
			{
				union()
		{
			cube([innerX+2*wall,innerY+wall,innerZ+wall]);
			translate([-flapZ+1,innerY-solidY,dZ-flapZ+wall])
				cube([flapZ,flapY,19]);
		}
		
		translate([wall,-1,wall+fanheight+fanrib])
			cube([innerX,innerY+1,innerZ+2*wall]);
		translate([wall,-1,wall])
			cube([innerX,innerY+1,fanheight]);
		translate([wall,-1,wall])
			cube([innerX,innerY+1,innerZ+2*wall]);
		translate([wall,-1,wall+dZ])
			cube([innerX+4*wall,innerY+1,innerZ+2*wall]);
		translate([0.0,2*flapZ-2.5*wall,wall+dZ])
			cube([innerX+4*wall,innerY-19,innerZ+2.5*wall]);
		translate([-wall,-1,-3*wall])
			cube([innerX+2*wall,1+innerY-solidY,2*innerZ]);
		translate([5*wall,-1,stepZ+wall])
			cube([innerX,stepY+1,innerZ+2*wall]);
		translate([innerX,stepY,dZ+wall])
			CornerRadius(thick=10,rad=3);
		translate([screw1X+wall,innerY/2,screw1Z])
			rotate([90,0,0])
				cylinder(h=200,r=1.7,$fn=30,center=true);
translate([screw1X,0,stepZ+wall])
			rotate([0,90,0])
				cylinder(h=200,r=4,$fn=30,center=true);
		translate([screw1X,screw2Y,screw2Z])
			rotate([0,90,0])
				cylinder(h=200,r=1.7,$fn=30,center=true);
		translate([screw1X,0,stepZ+wall])
			rotate([0,90,0])
				cylinder(h=200,r=4,$fn=30,center=true);
		translate([fanX, fanY, 0])
			Fan();
		translate([-flapZ+1.3+wall,innerY-solidY-1,1.55*flapZ+dZ-flapZ+wall])	
		{
			rotate([0,flapA,0])
				cube([2*flapZ, flapY-wall+1, 2*flapZ]);
			translate([-2.005*flapZ, -2, -flapZ+wall])
				rotate([0,flapA,0])
					cube([2*flapZ, flapY-wall+6, 2*flapZ]);
		}


	}


//


translate([wall,9,wall+fanheight])
			cube([0.3,innerY-9,1]);;
translate([innerX+1.7,9,wall+fanheight])
			cube([0.3,innerY-9,1]);
translate([wall,9,wall])
			cube([innerX,2,3]);;
}
}


module Flap()
{
	union()
	{
		cube([flapX, flapY, wall]);
		translate([flapZ+0.5,0,0])
			cube([flapX-flapZ, flapY, 2*wall]);
		translate([flapZ/2, flapY/2+wall/2, 0])
		difference()
		{
			cylinder(h=3*wall, r1=0.9*lug, r2=1.0*lug, $fn=40);
			cube([20,1.3,50],center=true,$fn=30);
		}
	}
}

module Fan()
{
	union()
	{
		difference()
		{
			cylinder(h=50,r=40/2,center=true,$fn=150);
			cylinder(h=60,r=11,center=true,$fn=30);
			for(a=[0:4])
				rotate([0,0,a*72])
				{
					translate([-wall/2,0,-30])
						cube([wall,50,200]);
				}
		}
		//for(x=[-1,1]) for(y=[-1,1])
//			translate([x*16,y*16,0])
//				cylinder(h=50,r=1.9,center=true,$fn=30);
	}
}


module CornerRadius(thick=10,rad=5)
{
	rotate([90,0,0])
	translate([-thick/2,-rad,-rad])
	difference()
	{
		cube([thick,2*rad,2*rad]);
		rotate([0,90,0])
			cylinder(h=3*thick,r=rad,center=true,$fn=30);
	}
}