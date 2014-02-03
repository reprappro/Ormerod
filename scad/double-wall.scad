
inner();
outer();

module inner()
{
	translate([0,0,2.5])
	difference()
	{
		cube([36-2*2.5,56-2*2.5,18-2.5], center=true);
		translate([0, 0, 2])
			cube([32-2*2.5,52-2*2.5,18-2.5], center=true);
	}

}

module outer()
{
	union()
	{
		difference()
		{
			cube([40,60,20], center=true);
			translate([0, 0, 2])
				cube([36,56,20], center=true);
		}
	
		for(x=[-1,1])
		for(y=[-1,1])
		{
			translate([x*10,y*20,-8])
				pyramid_45(5, 2.5);
			translate([x*10,y*28,4])
				rotate([y*90, 0, 0])
					pyramid_45(5, 2.5);
			translate([x*18,y*20,4])
				rotate([0, -x*90, 0])
					pyramid_45(5, 2.5);
		}
	}
}


module pyramid_45(side=2.5, height=2.5)
{
polyhedron(
  points=[ [side/2,side/2,0],[side/2,-side/2,0],[-side/2,-side/2,0],
		[-side/2,side/2,0], [0,0,height]  ],
  triangles=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4], 
              [1,0,3],[2,1,3] ] 
 );
}