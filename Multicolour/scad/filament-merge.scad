zoffset=15;
zvertical=5;
ang=35;
rad=30;
union_len=16;
union_dia=5;
filament_dia=2;
screw_dia=3;
thickness=8;

//cavity();

body(top=true);

module body(top=false)
{
	difference()
	{
	translate([rad*0.05,0,zoffset*1.2])
	{
		difference()
		{
			cube([rad*0.8,thickness,2*rad], center=true);
			translate([rad*0.6,0,1.3*rad])
				rotate([0,45,0])
					cube([rad,rad,rad], center=true);
			translate([-rad*0.6,0,1.3*rad])
				rotate([0,45,0])
					cube([rad,rad,rad], center=true);
		}

	}
	cavity();
	if(top)
		translate([0,100,0])
			cube([200,200,200],center=true);
	else
		translate([0,-100,0])
			cube([200,200,200],center=true);		
	}

}

module cavity()
{
	union()
	{
		translate([0,0,zoffset])
			mirror([1,0,0])
				angle_channel();
		angle_channel();
		translate([0,0,rad*2*sin(ang)+zvertical])
			brass_union();
		translate([0,0,-zvertical])
		{
			cylinder(r=filament_dia/2,h=rad*2*sin(ang)+
				2*zvertical,$fn=30);
			rotate([0,180,0])
				brass_union();
		}
		translate([rad-rad*cos(ang) + 5 ,0,rad*sin(ang)+
			zoffset - 2])
				rotate([90,0,0])
					cylinder(r=screw_dia/2,h=2*thickness,
						center=true,$fn=30);

		translate([rad-rad*cos(ang) ,0,rad*sin(ang)+
			zoffset+8])
				rotate([90,0,0])
					cylinder(r=screw_dia/2,h=2*thickness,
						center=true,$fn=30);

		translate([-rad+rad*cos(ang) ,0,rad*sin(ang)+12])
				rotate([90,0,0])
					cylinder(r=screw_dia/2,h=2*thickness,
						center=true,$fn=30);

		translate([-rad+rad*cos(ang)-2 ,0,rad*sin(ang)-5])
				rotate([90,0,0])
					cylinder(r=screw_dia/2,h=2*thickness,
						center=true,$fn=30);

		translate([6,0,-zvertical-2])
				rotate([90,0,0])
					cylinder(r=screw_dia/2,h=2*thickness,
						center=true,$fn=30);

		translate([-6,0,-zvertical-2])
				rotate([90,0,0])
					cylinder(r=screw_dia/2,h=2*thickness,
						center=true,$fn=30);

	}

}


module angle_channel()
{
	translate([-rad,0,0])
		union()
		{
			intersection()
			{
				rotate([90,0,0])
				rotate_extrude(convexity = 10, $fn = 60)
					translate([rad, 0, 0])
						circle(r = filament_dia/2, $fn=30); 
				translate([0,-2,0])
					cube([2*rad,4,2*rad]);
				rotate([0,90-ang,0])
					translate([0,-2,0])
						cube([2*rad,4,2*rad]);
			}
			translate([rad*cos(ang),0,rad*sin(ang)])
				rotate([0,-ang,0])
					brass_union();
	
		}
}

module brass_union()
{
	translate([0,0,union_len/2+2])
	union()
	{
		cylinder(r=union_dia/2,h=union_len-4,center=true,
			$fn=40);
		translate([0,0,-union_len/2+0.5])
			cylinder(r=union_dia/2-0.75,h=3,center=true,$fn=40);
		translate([0,0,-union_len/2-1])
			cylinder(r=union_dia/2,h=2,center=true,$fn=40);
	}
}