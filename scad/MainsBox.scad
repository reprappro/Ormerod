// The rectangular hole for the clip-in mains connector

mainsHoleX = 36;
mainsHoleY = 3;
mainsHoleZ = 57;

// How far back do the works go?

mainsDepth = 35;

// Countersunk Self Tapping Screws (RS 546-5480 - UTS #6, 13mm)

ScrewDia = 2.84;
ScrewPitch = 0.635;
ScrewRootDia = ScrewDia - ScrewPitch*5.0*sqrt(3.0)/8.0;
ScrewLength = 13;
ScrewHead = ScrewDia*2;

//MainsBox();
MainsLid();
//InsulatingPlate();

module MainsLid()
{
	translate([0,0, mainsHoleZ/2 + 15])
	difference()
	{
		union()
		{
			translate([0, (mainsHoleY - 3)/2, 0])
				cube([mainsHoleX+2*(ScrewDia+7) + 6, mainsDepth, 
					3], center=true);
			translate([0, (mainsHoleY - 3)/2-mainsDepth/2 - mainsHoleY/2, 0])
				cube([mainsHoleX, mainsHoleY, 3], 
					center=true);
		}

		for(x = [-1,1]) for(y=[-1,1])
		translate([x*((mainsHoleX+2*(ScrewDia+7)+6)/2-(ScrewDia+7)/2), 
				y*((mainsDepth)/2-(ScrewDia+7)/2 - (0.5 - y/2)*(mainsHoleY - 3)/2), 
				0])
					if(x < 0 && y < 0)
					{
							ScrewCentre(rad = ScrewDia/2, cone=true);
					} else if (x < 0 && y > 0)
					{
						mirror([0, 1, 0])
							ScrewCentre(rad = ScrewDia/2, cone=true);
					}else if (x > 0 && y < 0)
					{
						mirror([1, 0, 0])
							ScrewCentre(rad = ScrewDia/2, cone=true);
					}else
					{
						mirror([1, 0, 0])
						mirror([0, 1, 0])
							ScrewCentre(rad = ScrewDia/2, cone=true);
					}	
		}			
						
}


module MainsBox()
{
	difference()
	{
		union()
		{
			difference()
			{
				cube([mainsHoleX + 2*(ScrewDia+7) + 12, mainsDepth + 3 + mainsHoleY, 
					mainsHoleZ + 6], center=true);
				translate([0, (mainsHoleY - 3)/2, 3])
					cube([mainsHoleX+2*(ScrewDia+7) + 6, mainsDepth, mainsHoleZ + 6], 
						center=true);
				translate([0, -mainsDepth/2, 3])
					cube([mainsHoleX, mainsDepth, mainsHoleZ + 6], 
						center=true);
			}
			for(x = [-1,1]) for(y=[-1,1])
			translate([x*((mainsHoleX+2*(ScrewDia+7)+6)/2-(ScrewDia+7)/2), 
					y*((mainsDepth)/2-(ScrewDia+7)/2 - (0.5 - y/2)*(mainsHoleY - 3)/2),0])
						if(x < 0 && y < 0)
						{
								translate([0,0,(mainsHoleZ + 6 - (ScrewLength + 15))/2 - 3])
									ScrewHole(cn=false);
						} else if (x < 0 && y > 0)
						{
							translate([0,0,(mainsHoleZ + 6 - (ScrewLength + 15))/2 - 3])
								mirror([0, 1, 0])
									ScrewHole(cn=false);
							translate([-2.5,0,-((mainsHoleZ + 6 - (10))/2 - 3)])
								cube([ScrewDia+7-5, ScrewDia+7, 10], center=true);
						}else if (x > 0 && y < 0)
						{
							translate([0,0,(mainsHoleZ + 6 - (ScrewLength + 15))/2 - 3])
								mirror([1, 0, 0])
									ScrewHole(cn=false);
						}else
						{
							translate([0,0,(mainsHoleZ + 6 - (ScrewLength + 15))/2 - 3])
								mirror([1, 0, 0])
									mirror([0, 1, 0])
										ScrewHole(cn=false);
							mirror([1, 0, 0])
								translate([-2.5,0,-((mainsHoleZ + 6 - (10))/2 - 3)])
									cube([ScrewDia+7-5, ScrewDia+7, 10], center=true);
						}		
		}
		translate([0, mainsDepth/2-1.5, 3])
					cube([mainsHoleX + 2*(ScrewDia+7) + 6, 3, mainsHoleZ + 6], 
						center=true);
		translate([mainsHoleX/2-5,mainsDepth/2,-mainsHoleZ/2+26])
			rotate([90,0,0])
			{
				cylinder(r=2,h=20,center=true,$fn=30);
				translate([0,0,-1])
					cylinder(r1=2,r2=4,h=2.5,center=true,$fn=30);
			}	
		translate([-mainsHoleX/2+5,mainsDepth/2,-mainsHoleZ/2+6])
			rotate([90,0,0])
			{
				cylinder(r=2,h=20,center=true,$fn=30);
				translate([0,0,-1])
					cylinder(r1=2,r2=4,h=2.5,center=true,$fn=30);
			}	
		translate([mainsHoleX/2+5,mainsDepth/2-14,-mainsHoleZ/2+6])
			rotate([0,90,0])
				cylinder(r=3,h=40,center=true,$fn=30);
	}
}

module ScrewCentre(rad = ScrewRootDia/2, cone=false)
{
	translate([1, 1, 0])
			cylinder(r = rad, h = ScrewLength + 1, center=true, $fn=20);
	if(cone)
		translate([1, 1, (ScrewHead-rad)/6])
			cylinder(r1 = rad, , r2 = ScrewHead,
				h = 2*(ScrewHead-rad)/3.5, center=true, $fn=20);
}

module ScrewHole(cn=false)
{
	difference()
	{
		cube([ScrewDia+7, ScrewDia+7, ScrewLength + 15], center=true);
		translate([0,0,15/2 + 1])
			ScrewCentre(rad = ScrewRootDia/2, cn);
		translate([ScrewDia+3.8, 0, - 17])
			rotate([0,28,0])
				cube([ScrewDia+20, ScrewDia+10, ScrewLength + 30], center=true);		
	}
}

module InsulatingPlate()
{
	translate([mainsHoleX+40,0,0])
	//rotate([90,0,0])
	cube([mainsHoleX + 2*(ScrewDia+7) + 6, mainsHoleZ, 2.5], 
						center=true);
}