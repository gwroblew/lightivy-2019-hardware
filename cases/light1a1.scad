/*
	roundedCube() v1.0.3 by robert@cosmicrealms.com from https://github.com/Sembiance/openscad-modules
	Allows you to round any edge of a cube
	
	Usage
	=====
	Prototype: roundedCube(dim, r, x, y, z, xcorners, ycorners, zcorners, $fn)
	Arguments:
		-      dim = Array of x,y,z numbers representing cube size
		-        r = Radius of corners. Default: 1
		-        x = Round the corners along the X axis of the cube. Default: false
		-        y = Round the corners along the Y axis of the cube. Default: false
		-        z = Round the corners along the Z axis of the cube. Default: true
		- xcorners = Array of 4 booleans, one for each X side of the cube, if true then round that side. Default: [true, true, true, true]
		- ycorners = Array of 4 booleans, one for each Y side of the cube, if true then round that side. Default: [true, true, true, true]
		- zcorners = Array of 4 booleans, one for each Z side of the cube, if true then round that side. Default: [true, true, true, true]
		-       rx = Radius of the x corners. Default: [r, r, r, r]
		-       ry = Radius of the y corners. Default: [r, r, r, r]
		-       rz = Radius of the z corners. Default: [r, r, r, r]
		-   center = Whether to render the cube centered or not. Default: false
		-      $fn = How smooth you want the rounding to be. Default: 128

	Change Log
	==========
	2018-08-21: v1.0.3 - Added ability to set the radius of each corner individually with vectors: rx, ry, rz
	2017-05-15: v1.0.2 - Fixed bugs relating to rounding corners on the X axis
	2017-04-22: v1.0.1 - Added center option
	2017-01-04: v1.0.0 - Initial Release

	Thanks to Sergio Vilches for the initial code inspiration
*/

// Example code:

/*cube([5, 10, 4]);

translate([8, 0, 0]) { roundedCube([5, 10, 4], r=1); }
translate([16, 0, 0]) { roundedCube([5, 10, 4], r=1, zcorners=[true, false, true, false]); }

translate([24, 0, 0]) { roundedCube([5, 10, 4], r=1, y=true, z=false); }
translate([32, 0, 0]) { roundedCube([5, 10, 4], r=1, x=true, z=false); }
translate([40, 0, 0]) { roundedCube([5, 10, 4], r=1, x=true, y=true, z=true); }
*/

module roundedCube(dim, r=1, x=false, y=false, z=true, xcorners=[true,true,true,true], ycorners=[true,true,true,true], zcorners=[true,true,true,true], center=false, rx=[undef, undef, undef, undef], ry=[undef, undef, undef, undef], rz=[undef, undef, undef, undef], $fn=128)
{
	translate([(center==true ? (-(dim[0]/2)) : 0), (center==true ? (-(dim[1]/2)) : 0), (center==true ? (-(dim[2]/2)) : 0)])
	{
		difference()
		{
			cube(dim);

			if(z)
			{
				translate([0, 0, -0.1])
				{
					if(zcorners[0])
						translate([0, dim[1]-(rz[0]==undef ? r : rz[0])]) { rotateAround([0, 0, 90], [(rz[0]==undef ? r : rz[0])/2, (rz[0]==undef ? r : rz[0])/2, 0]) { meniscus(h=dim[2], r=(rz[0]==undef ? r : rz[0]), fn=$fn); } }
					if(zcorners[1])
						translate([dim[0]-(rz[1]==undef ? r : rz[1]), dim[1]-(rz[1]==undef ? r : rz[1])]) { meniscus(h=dim[2], r=(rz[1]==undef ? r : rz[1]), fn=$fn); }
					if(zcorners[2])
						translate([dim[0]-(rz[2]==undef ? r : rz[2]), 0]) { rotateAround([0, 0, -90], [(rz[2]==undef ? r : rz[2])/2, (rz[2]==undef ? r : rz[2])/2, 0]) { meniscus(h=dim[2], r=(rz[2]==undef ? r : rz[2]), fn=$fn); } }
					if(zcorners[3])
						rotateAround([0, 0, -180], [(rz[3]==undef ? r : rz[3])/2, (rz[3]==undef ? r : rz[3])/2, 0]) { meniscus(h=dim[2], r=(rz[3]==undef ? r : rz[3]), fn=$fn); }
				}
			}

			if(y)
			{
				translate([0, -0.1, 0])
				{
					if(ycorners[0])
						translate([0, 0, dim[2]-(ry[0]==undef ? r : ry[0])]) { rotateAround([0, 180, 0], [(ry[0]==undef ? r : ry[0])/2, 0, (ry[0]==undef ? r : ry[0])/2]) { rotateAround([-90, 0, 0], [0, (ry[0]==undef ? r : ry[0])/2, (ry[0]==undef ? r : ry[0])/2]) { meniscus(h=dim[1], r=(ry[0]==undef ? r : ry[0])); } } }
					if(ycorners[1])
						translate([dim[0]-(ry[1]==undef ? r : ry[1]), 0, dim[2]-(ry[1]==undef ? r : ry[1])]) { rotateAround([0, -90, 0], [(ry[1]==undef ? r : ry[1])/2, 0, (ry[1]==undef ? r : ry[1])/2]) { rotateAround([-90, 0, 0], [0, (ry[1]==undef ? r : ry[1])/2, (ry[1]==undef ? r : ry[1])/2]) { meniscus(h=dim[1], r=(ry[1]==undef ? r : ry[1])); } } }
					if(ycorners[2])
						translate([dim[0]-(ry[2]==undef ? r : ry[2]), 0]) { rotateAround([-90, 0, 0], [0, (ry[2]==undef ? r : ry[2])/2, (ry[2]==undef ? r : ry[2])/2]) { meniscus(h=dim[1], r=(ry[2]==undef ? r : ry[2])); } }
					if(ycorners[3])
						rotateAround([0, 90, 0], [(ry[3]==undef ? r : ry[3])/2, 0, (ry[3]==undef ? r : ry[3])/2]) { rotateAround([-90, 0, 0], [0, (ry[3]==undef ? r : ry[3])/2, (ry[3]==undef ? r : ry[3])/2]) { meniscus(h=dim[1], r=(ry[3]==undef ? r : ry[3])); } }
				}
			}

			if(x)
			{
				translate([-0.1, 0, 0])
				{
					if(xcorners[0])
						translate([0, dim[1]-(rx[0]==undef ? r : rx[0])]) { rotateAround([0, 90, 0], [(rx[0]==undef ? r : rx[0])/2, 0, (rx[0]==undef ? r : rx[0])/2]) { meniscus(h=dim[0], r=(rx[0]==undef ? r : rx[0])); } }
					if(xcorners[1])
						translate([0, dim[1]-(rx[1]==undef ? r : rx[1]), dim[2]-(rx[1]==undef ? r : rx[1])]) { rotateAround([90, 0, 0], [0, (rx[1]==undef ? r : rx[1])/2, (rx[1]==undef ? r : rx[1])/2]) { rotateAround([0, 90, 0], [(rx[1]==undef ? r : rx[1])/2, 0, (rx[1]==undef ? r : rx[1])/2]) { meniscus(h=dim[0], r=(rx[1]==undef ? r : rx[1])); } } }
					if(xcorners[2])
						translate([0, 0, dim[2]-(rx[2]==undef ? r : rx[2])]) { rotateAround([180, 0, 0], [0, (rx[2]==undef ? r : rx[2])/2, (rx[2]==undef ? r : rx[2])/2]) { rotateAround([0, 90, 0], [(rx[2]==undef ? r : rx[2])/2, 0, (rx[2]==undef ? r : rx[2])/2]) { meniscus(h=dim[0], r=(rx[2]==undef ? r : rx[2])); } } }
					if(xcorners[3])
						rotateAround([-90, 0, 0], [0, (rx[3]==undef ? r : rx[3])/2, (rx[3]==undef ? r : rx[3])/2]) { rotateAround([0, 90, 0], [(rx[3]==undef ? r : rx[3])/2, 0, (rx[3]==undef ? r : rx[3])/2]) { meniscus(h=dim[0], r=(rx[3]==undef ? r : rx[3])); } }
				}
			}
		}
	}
}

module meniscus(h, r, fn=100)
{
	$fn=fn;

	difference()
	{
		cube([r+0.2, r+0.2, h+0.2]);
		translate([0, 0, -0.1]) { cylinder(h=h+0.4, r=r); }
	}
}

module rotateAround(a, v) { translate(v) { rotate(a) { translate(-v) { children(); } } } }

module pin(){
cylinder(r=0.9,h=6);
}

module hole(){
cylinder(r=0.8,h=3);
}

module stub(){
difference(){
cylinder(r=2.6,h=6);
cylinder(r=0.8,h=15,center=true);
}
}

module cutout(x1,x2,y1,y2,z1,z2){
translate([x1,y1,z1])
roundedCube([x2-x1,y2-y1,z2-z1]);
}

module cutoutc(x1,x2,y1,y2,z1,z2){
translate([x1,y1,z1])
cube([x2-x1,y2-y1,z2-z1]);
}

$fn=100;
// pcb width
pcbw = 120;
// pcb height
pcbh = 54;
// wall thickness (top)
wt = 1.6;
// wall thickness (side)
wts = 2.4;
// opening expansion
fit = 0.4;

logo_in = 0;
letters_in = 0;

difference(){
union(){
translate([0,0,-3.5])
roundedCube([pcbw+wts*2,pcbh+wts*2,12],center=true,r=5+wts,y=true,x=true,ycorners=[true,true,false,false],xcorners=[false,true,true,false],ry=[wt,wt,wt,wt],rx=[wt,wt,wt,wt]);
translate([-0.0,4,4.3])
roundedCube([60+wt,35+wts*2,6.6],center=true,y=true,x=true,r=wt,ycorners=[true,true,false,false],xcorners=[false,true,true,false]);

// speaker border
cutout(-9,9,-pcbh/2+2,-pcbh/2+12,2.49,3.3);

letter_ext = 1.4; //0.9;
logo_ext = 1.8; //1.2;

if (letters_in == 0) {
translate([-pcbw/2+104,pcbh/2-8+0.5,1.8])
linear_extrude(letter_ext)
text("X",valign="center",halign="center",size=4,font="Lato:style=Bold");
translate([-pcbw/2+96,pcbh/2-16+0.5,1.8])
linear_extrude(letter_ext)
text("Y",valign="center",halign="center",size=4,font="Lato:style=Bold");
translate([-pcbw/2+112,pcbh/2-28-0.5,1.8])
linear_extrude(letter_ext)
text("A",valign="center",halign="center",size=4,font="Lato:style=Bold");
translate([-pcbw/2+104,pcbh/2-36-0.5,1.8])
linear_extrude(letter_ext)
text("B",valign="center",halign="center",size=4,font="Lato:style=Bold");
translate([-pcbw/2+15,pcbh/2-22.5,1.8])
linear_extrude(letter_ext)
text("+",valign="center",halign="center",size=7,font="Lato:style=Bold");
translate([-pcbw/2+32,-pcbh/2+7,1.8])
linear_extrude(letter_ext)
text("START",valign="center",halign="center",size=3.4,font="Lato:style=Bold");
}

if (logo_in == 0) {
translate([35,-22,1.8])
linear_extrude(logo_ext)
text("LightIvy",valign="center",halign="center",size=5.2,font="FreeMono:style=Bold");
}
}
translate([0,0,-5.1])
roundedCube([pcbw+fit*2,pcbh+fit*2,13.2],center=true,r=5,x=true,y=true,rx=[2,2,2,2],ry=[2,2,2,2]);

// screen
translate([0,4,2])
cube([58,35,8],center=true);
translate([1.5,4,0])
roundedCube([37,30,16],center=true,r=1);

// microsd card
cutout(-pcbw/2+50,-pcbw/2+75,0,pcbh/2+3,-1.4,1.8);

// power switch
cutout(pcbw/2-5,pcbw/2+5,pcbh/2-16,pcbh/2-8,-9.6,-1.0);

// prog port
cutout(-pcbw/2+81,-pcbw/2+98,pcbh/2-3,pcbh/2+3,-100,-5);

// up
translate([-pcbw/2+15,pcbh/2-14,0])
roundedCube([6.5,6.5,6],center=true,r=1.2);
// down
translate([-pcbw/2+15,pcbh/2-30,0])
roundedCube([6.5,6.5,6],center=true,r=1.2);
// left
translate([-pcbw/2+7,pcbh/2-22,0])
roundedCube([6.5,6.5,6],center=true,r=1.2);
// right
translate([-pcbw/2+23,pcbh/2-22,0])
roundedCube([6.5,6.5,6],center=true,r=1.2);
// up X
translate([-pcbw/2+104,pcbh/2-14,0])
roundedCube([6.5,6.5,6],center=true,r=1.2);
// down B
translate([-pcbw/2+104,pcbh/2-30,0])
roundedCube([6.5,6.5,6],center=true,r=1.2);
// left Y
translate([-pcbw/2+96,pcbh/2-22,0])
roundedCube([6.5,6.5,6],center=true,r=1.2);
// right A
translate([-pcbw/2+112,pcbh/2-22,0])
roundedCube([6.5,6.5,6],center=true,r=1.2);
// START
translate([-pcbw/2+44.5,-pcbh/2+7.5,0])
roundedCube([6.5,6.5,16],center=true,r=1.2);

if (logo_in != 0) {
translate([0,-19.2,5-0.2])
linear_extrude(2)
text("LightIvy",valign="center",halign="center",size=5.2,font="FreeMono:style=Bold");
}

if (letters_in != 0) {
translate([-pcbw/2+90,pcbh/2-6+0.5,2.1])
linear_extrude(2)
text("X",valign="center",halign="center",size=4,font="Lato:style=Bold");
translate([-pcbw/2+82,pcbh/2-14+0.5,2.1])
linear_extrude(2)
text("Y",valign="center",halign="center",size=4,font="Lato:style=Bold");
translate([-pcbw/2+98,pcbh/2-26-0.5,2.1])
linear_extrude(2)
text("A",valign="center",halign="center",size=4,font="Lato:style=Bold");
translate([-pcbw/2+90,pcbh/2-34-0.5,2.1])
linear_extrude(2)
text("B",valign="center",halign="center",size=4,font="Lato:style=Bold");
translate([-pcbw/2+14,pcbh/2-20.5,2.1])
linear_extrude(2)
text("+",valign="center",halign="center",size=7,font="Lato:style=Bold");
}

// speaker
cutout(-7,7,-pcbh/2+4,-pcbh/2+10,0,5);
cutoutc(-7.6,7.6,-pcbh/2+2.9,-pcbh/2+11.1,0,2.2);

translate([pcbw/2-4,pcbh/2-4,-1.0])
hole();
translate([pcbw/2-4,-pcbh/2+4,-1.0])
hole();
translate([-pcbw/2+4,pcbh/2-4,-1.0])
hole();
translate([-pcbw/2+4,-pcbh/2+4,-1.0])
hole();
}

// speaker fill
/*for(i=[0:4:10])
translate([-pcbw/2+11.0+i,-pcbh/2+7,2.7])
cube([1.2,10,0.4],center=true);

translate([-pcbw/2+15,-pcbh/2+5.25,2.7])
cube([17,1.2,0.4],center=true);
translate([-pcbw/2+15,-pcbh/2+8.75,2.7])
cube([17,1.2,0.4],center=true);
*/

/*translate([pcbw/2-4,pcbh/2-4,-3.5])
pin();
translate([pcbw/2-4,-pcbh/2+4,-3.5])
pin();
translate([-pcbw/2+4,pcbh/2-4,-3.5])
pin();
translate([-pcbw/2+4,-pcbh/2+4,-3.5])
pin();
*/
translate([pcbw/2-4,pcbh/2-4,-5])
stub();
translate([pcbw/2-4,-pcbh/2+4,-5])
stub();
translate([-pcbw/2+4,pcbh/2-4,-5])
stub();
translate([-pcbw/2+4,-pcbh/2+4,-5])
stub();

// up
translate([-pcbw/2+15,pcbh/2-14,2])
roundedCube([6,6,3],center=true,r=1.2);
translate([-pcbw/2+15,pcbh/2-17,1.5+0.4])
cube([4,4,0.4],center=true);
// down
translate([-pcbw/2+15,pcbh/2-30,2])
roundedCube([6,6,3],center=true,r=1.2);
translate([-pcbw/2+15,pcbh/2-27,1.5+0.4])
cube([4,4,0.4],center=true);
// left
translate([-pcbw/2+7,pcbh/2-22,2])
roundedCube([6,6,3],center=true,r=1.2);
translate([-pcbw/2+10,pcbh/2-22,1.5+0.4])
cube([4,4,0.4],center=true);
// right
translate([-pcbw/2+23,pcbh/2-22,2])
roundedCube([6,6,3],center=true,r=1.2);
translate([-pcbw/2+20,pcbh/2-22,1.5+0.4])
cube([4,4,0.4],center=true);
// up X
translate([-pcbw/2+104,pcbh/2-14,2])
roundedCube([6,6,3],center=true,r=1.2);
translate([-pcbw/2+104,pcbh/2-17,1.5+0.4])
cube([4,4,0.4],center=true);
// down B
translate([-pcbw/2+104,pcbh/2-30,2])
roundedCube([6,6,3],center=true,r=1.2);
translate([-pcbw/2+104,pcbh/2-27,1.5+0.4])
cube([4,4,0.4],center=true);
// left Y
translate([-pcbw/2+96,pcbh/2-22,2])
roundedCube([6,6,3],center=true,r=1.2);
translate([-pcbw/2+99,pcbh/2-22,1.5+0.4])
cube([4,4,0.4],center=true);
// right A
translate([-pcbw/2+112,pcbh/2-22,2])
roundedCube([6,6,3],center=true,r=1.2);
translate([-pcbw/2+109,pcbh/2-22,1.5+0.4])
cube([4,4,0.4],center=true);
// START
translate([-pcbw/2+44.5,-pcbh/2+7.5,2])
roundedCube([6,6,3],center=true,r=1.2);
translate([-pcbw/2+41.5,-pcbh/2+7.5,1.5+0.4])
cube([4,4,0.4],center=true);

// speaker to pcb
difference(){
cutoutc(-8.4,8.4,-pcbh/2+2.1,-pcbh/2+11.9,-2,2.2);
cutoutc(-7.6,7.6,-pcbh/2+2.9,-pcbh/2+11.1,-3,0);
cutout(-7,7,-pcbh/2+4,-pcbh/2+10,-3,5);
}
