/*
  Vertical mounting for 20A 12V PSU.

	Adrian

	3 February 2014

*/

PSx = 110;
PSy = 50;
height = 25;
drop=5;
shim = 5; // 11 for top one

//mirror([1,0,0]) // Uncomment for top one
PSSupport();

module PSSupport()
{
	difference()
	{
		union()
		{
			cube([PSx+6, PSy+6, 3], center=true);
			for(x=[-1,1])for(y=[-1,1])
				translate([x*(PSx+6)/2, y*(PSy+6)/2, -1.5])
				{
					if(x < 0 && y < 0)
					{
							Corner();
					} else if (x < 0 && y > 0)
					{
						mirror([0, 1, 0])
							Corner();
					}else if (x > 0 && y < 0)
					{
						mirror([1, 0, 0])
							Corner();
					}else
					{
						mirror([1, 0, 0])
						mirror([0, 1, 0])
							Corner();
					}
						
				}
		}
		translate([0,0,1.5*height-(drop+ 0.5)-shim])
		{
			difference()
			{
				cube([PSx, PSy, height], center=true);
				translate([-(PSx+6-15)/2, (PSy+6-15)/2,-height/2])
					cube([25, 25, 2*shim], center=true);
			}
		}
		cube([PSx-30, PSy-30, 4*height], center=true);
		for(x=[-1,1])for(y=[-1,1])
			translate([x*(PSx-45)/2,y*(PSy-15)/2,0])
				cylinder(r=1.7,h=4*height,center=true,$fn=30);
	}
}

module Corner()
{
	difference()
	{
		polyhedron(
	  		points=[ [0,0,0],[30,0,0],[0,30,0],[0,0,2*height] ],                                 
	  		triangles=[ [0,3,1],[0,2,3],[0,1,2],[1,3,2] ] 
	 	);
		translate([0,0,50+height])
			cube([100,100,100], center=true);
	}

}

