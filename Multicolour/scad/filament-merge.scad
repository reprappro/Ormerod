zoffset=15;
zvertical=5;
ang=35;
rad=30;

union_len=15;
union_dia=5.5;
union_valley_dia=4.7;
union_lip=1.5;
union_valley=2.8;

filament_dia=2.3;
screw_dia=3.2;
thickness=8;


body(bottom=true);

module body(bottom=true)
{
	if(bottom)
		rotate([90,0,0])
			body_i(bottom);
	else
		rotate([-90,0,0])
			body_i(bottom);
}

module body_i(bottom=true)
{
	difference()
	{
	translate([rad*0.05,0,zoffset*1.2])
	{
		difference()
		{
			cube([rad*0.9,thickness,2*rad], center=true);
			translate([rad*0.6,0,1.3*rad])
				rotate([0,45,0])
					cube([rad,rad,rad], center=true);
			translate([-rad*0.6,0,1.3*rad])
				rotate([0,45,0])
					cube([rad,rad,rad], center=true);
		}

	}
	cavity();
	if(bottom)
		translate([0,100,0])
			cube([200,200,200],center=true);
	else
		translate([0,-100,0])
			cube([200,200,200],center=true);		
	}

}

module screw_cavity()
{
	union()
	{
		cylinder(r=screw_dia/2,h=2*thickness,
						center=true,$fn=30);
		translate([0,0,thickness*1.5-0.6*screw_dia])
			rotate([0,0,30])
				cylinder(r=2.1*(screw_dia/2),h=2*thickness,
						center=true,$fn=6);
		translate([0,0,-thickness*0.4])
			cylinder(r2=screw_dia/2,r1=screw_dia*(5.5/6), h=screw_dia*(2/3),
						center=true,$fn=30);
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
					screw_cavity();

		translate([rad-rad*cos(ang) ,0,rad*sin(ang)+
			zoffset+10])
				rotate([90,0,0])
					screw_cavity();

		translate([-rad+rad*cos(ang) ,0,rad*sin(ang)+12])
				rotate([90,0,0])
					screw_cavity();

		translate([-rad+rad*cos(ang)-2 ,0,rad*sin(ang)-5])
				rotate([90,0,0])
					screw_cavity();

		translate([6,0,-zvertical-2])
				rotate([90,0,0])
					screw_cavity();

		translate([-6,0,-zvertical-2])
				rotate([90,0,0])
					screw_cavity();

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

	union()
	{
		translate([0,0,(union_len+union_valley+union_lip)/2])
			cylinder(r=union_dia/2,h=union_len-union_valley-union_lip,center=true,
				$fn=40);
		translate([0,0,union_valley/2+union_lip])
			cylinder(r=union_valley_dia/2,h=union_valley+1,center=true,$fn=40);
		translate([0,0,union_lip/2])
			cylinder(r=union_dia/2,h=union_lip,center=true,$fn=40);
	}
}