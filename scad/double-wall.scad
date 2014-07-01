g=4;				// The gap between the boxes
t=2;				// The thickness of the walls
c=[145+2*(g+2*t),105+2*(g+2*t),25+g+2*t]; 	// The numbers are the size of the inner box
base=-(25+g+2*t)/2+g+t;


//inner();
//outer();

translate([0,0,50])
rotate([180,0,0])
top();


module u(rad=2)
{
	rotate([90,0,0])
	union()
	{
		cylinder(r=rad,h=20,center=true,$fn=30);
		translate([0,10,0])
			cube([2*rad,20,20],center=true);
	}
}

module holes()
{

	union()
	{
		screw_holes();
		translate([10,0,0])
		{
			
			translate([125/2,105/2-8-10,base+15/2+4])
				cube([30,18,15], center=true);
			translate([125/2,105/2-48-7,base+8/2+4])
				cube([30,12,8], center=true);
			translate([-125/2+20,-105/2,base+20])
				u();
			translate([-125/2+40,-105/2,base+20])
				u();
			translate([-125/2+60,-105/2,base+20])
				u();
			translate([-125/2+80,-105/2,base+20])
				u();
			translate([-125/2+100,-105/2,base+20])
				u(rad=2.5);
			translate([-125/2-20,105/2-55,base+8/2+4])
				cube([30,15,8], center=true);
			translate([-125/2-20,105/2-28,base+20])
				rotate([0,0,90])
					u(rad=3);
		}
	}
}

module screw_holes()
{
	translate([10,0,0])
	union()
	{
		for(x=[-1,1])
		for(y=[-1,1])
		{
			translate([x*115/2,y*92/2,0])
				cylinder(r=1.7, h=50, center=true,$fn=20);
		}
	}
}

module inner()
{
	difference()
	{
		translate([0,0,2.5])
		difference()
		{
			cube([c.x-2*(g+t),c.y-2*(g+t),c.z-g-t], center=true);
			translate([0, 0, t])
				cube([c.x-2*(g+t)-2*t,c.y-2*(g+t)-2*t,c.z-g-t], center=true);
		}
		holes();
	}

}

module top()
{
		difference()
		{
			rotate([180,0,0])
			difference()
			{
				cube([c.x+2*t+1, c.y+2*t+1, g+t+1], center=true);
				translate([0, 0, t])
					cube([c.x+1, c.y+1, g+t+1], center=true);
			}
			screw_holes();
		}
}

module outer()
{
	difference()
	{
		union()
		{
			difference()
			{
				cube(c, center=true);
				translate([0, 0, t])
					cube([c.x-2*t,c.y-2*t,c.z], center=true);
			}
		
			for(x=[-1,1])
			for(y=[-1,1])
			{
				translate([x*(c.x/2-20-g/2),y*(c.y/2-20-g/2),-c.z/2+t])
					pyramid_45(2*g, g);
				translate([x*(c.x/2-10),y*(c.y/2-t),c.z/2-1.5*g])
					rotate([y*90, 0, 0])
						pyramid_45(2*g, g);
				translate([x*(c.x/2-t),y*(c.y/2-10),c.z/2-1.5*g])
					rotate([0, -x*90, 0])
						pyramid_45(2*g, g);
			}
		}
		holes();
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