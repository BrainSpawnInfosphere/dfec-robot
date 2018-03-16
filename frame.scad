$fn=100;

module plate(thick=3){
    difference(){
        dia = 100;
        cylinder(thick,d=dia, center=true);
        translate([-dia/2,dia/2-10,-thick]) cube([dia,dia,2*thick]);
        translate([-dia/2,-3*dia/2+10,-thick]) cube([dia,dia,2*thick]);
    }
}

//plate();

module irholes(){
    translate([0,2.1,2.1]) rotate([0,90,0]) cylinder(10,d=2.5,center=true);
    translate([0,10.8-2.1,23.4+2.1/2]) rotate([0,90,0]) cylinder(10,d=2.5,center=true);
}

difference(){
    cube([3,15,35]);
    translate([0,2.5,3]) irholes();
}