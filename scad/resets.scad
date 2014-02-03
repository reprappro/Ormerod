dx= 21.5 - 3.3;
dy = 73 - 35.5;
height = 23.25-2.8+20-2.8;

//reset_insert();

reset_block();

module reset_block()
{
	difference()
	{
		union()
		{
			column();
			translate([dx, dy, 0])
				column();
			translate([-7.5/2,-7.5/2,-height/2])
				cube([dx+7.5,dy+7.5,3]);
		}
		column_hole();
		translate([dx, dy, 0])
			column_hole();
		translate([dx-2, 2, 0])
			cylinder(r=1.7, h=2*height,center=true,$fn=20);
		translate([2, dy - 2, 0])
			cylinder(r=1.7, h=2*height,center=true,$fn=20);
	}
}

module column()
{
	cube([7.5,7.5,height],center=true);
}

module column_hole()
{
	union()
	{
		translate([0,0,-5])
		{
			cube([4.5,4.5,height],center=true);
			translate([0,0,height/2])
				pyramid_45(4.5);
		}
		cylinder(r=1, h=2*height,center=true,$fn=20);
	}
}

module reset_insert()
{
	difference()
	{
		cube([height-7,4,4],center=true);
		rotate([0,90,0])
			cylinder(r=1,h=2*height,center=true,$fn=20);
	}
}


module pyramid_45(side=5)
{
polyhedron(
  points=[ [side/2,side/2,0],[side/2,-side/2,0],[-side/2,-side/2,0],
		[-side/2,side/2,0], [0,0,side/sqrt(2)]  ],
  triangles=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4], 
              [1,0,3],[2,1,3] ] 
 );
}


