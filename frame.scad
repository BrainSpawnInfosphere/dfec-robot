$fn=100;

hole_440 = 3.5;  // mm
hole_256 = 2.5;  // mm

module plate(thick=3){
    difference(){
        dia = 100;
        cylinder(thick,d=dia, center=true);
        translate([-dia/2,dia/2-10,-thick]) cube([dia,dia,2*thick]);
        translate([-dia/2,-3*dia/2+10,-thick]) cube([dia,dia,2*thick]);
    }
}

module irholes(){
    translate([0,2.1,2.1]) rotate([0,90,0]) cylinder(10,d=2.5,center=true);
    translate([0,10.8-2.1,23.4+2.1/2]) rotate([0,90,0]) cylinder(10,d=2.5,center=true);
}

module ir_mnt(){
    translate([0,-15/2,0]) difference(){
        cube([3,15,35]);
        translate([0,2.5,3]) irholes();
    }
}

module wheel(){
    color("gray") rotate([90,0,0]) cylinder(h=8, d=60.1);
}

module board(){
    color("green") translate([-70/2, -35/2, 0]) cube([70,35,19]);
}

module motor_straight(){
    translate([0,-18.8/2,-22.4/2]) cube([36.8, 18.8, 22.4]);
    rotate([0,90,0]) translate([0,0,-22.9]) cylinder(h=22.9, d=22.3);
    translate([20.6,0,0]) rotate([-90,0,0]) cylinder(h=15.4,d=5.4);
}

module motor_90(){
    translate([-22.5/2,-13.7/2,-22.8/2]) cube([42,13.7,22.8]);
    rotate([90,0,0]) translate([0,0,13.72/2]) cylinder(d=22.5, h=33);
    translate([20.6,0,0]) rotate([-90,0,0]) cylinder(h=15.4,d=5.4);
}

module motor_mnt(){
    height = 25;
    difference(){
        union(){
            cube([35,2,height]);
            translate([30,-8,0]) cube([10,10,height]);
        }
        translate([32,-8-1,.3*height/2]) cube([12,12,0.7*height]);
        
        translate([36,-3,.2*height/2]) cylinder(h=100, d=hole_440, center=true);
        
        // motor shaft
        translate([20,0,height/2]) rotate([90,0,0]) cylinder(d=8, h=10, center=true);
        
        // nubbin
        translate([8,0,height/2]) rotate([90,0,0]) cylinder(d=5, h=10, center=true);
        
        // mounting holes
        translate([19.5,0,height/2]) rotate([90,0,0]){
            translate([8,9,0]) cylinder(d=hole_256, h=10, center=true);
            translate([8,-9,0]) cylinder(d=hole_256, h=10, center=true);
        }
    }
}

module breadboard(){
    cube([54,83,10]);
}

module caster(){
    // 18.6 mm w/o thick
    dia = 10;
    h = 18.6;
    cylinder(h=h-dia/2, d=dia);
    translate([0,0,h-dia/2]) sphere(d=dia);
}

thick = 3;


module motor_plate(thick, draw=false){
    // 90 degree motors
    color("red") difference()
    {
        cylinder(h=thick,d=100, center=true);
        translate([0,49,0]) cube([65,30,10], center=true);
        translate([0,-49,0]) cube([65,30,10], center=true);
    }
    // 90 degree motors
    translate([-20,32,thick/2]) color("lightblue") motor_mnt();
    rotate([180,180,0]) translate([-20,32,thick/2]) color("lightblue") motor_mnt();
    
    // IR sensors
//    translate([47,0,0]) ir_mnt();
//    rotate([0,0,30]) translate([47,0,0]) ir_mnt();
//    rotate([0,0,-30]) translate([47,0,0]) ir_mnt();
    
    
    if (draw){
        translate([0,0,22.8/2+thick/2]){
            translate([-21,25,1]){
                rotate([0,0,0]) motor_90();
//                translate([20.6,20,0]) wheel();
            }
            translate([21,-25,1]){
                rotate([180,180,0]){
                    motor_90();
//                    translate([20.6,20,0]) wheel();
                }
            }
        }
    }
}

module array_mnt(width){
    h = 10;
    t = 2;
    translate([0,width/2,0]) cylinder(h=h,d=10);
    translate([0,-width/2,0]) cylinder(h=h,d=10);
    difference(){
        translate([-5,-width/2,h-t]) cube([10,width,t]);
        translate([-hole_256/2,-width/2,h-2*t]) cube([hole_256,width,3*t]);
    }
}

module base_plate(thick, draw=false){
    // plate
    color("lightgray") difference()
    {
        cylinder(h=thick,d=100, center=true);
        translate([0,49,0]) cube([65,30,10], center=true);
        translate([0,-49,0]) cube([65,30,10], center=true);
        
        // holes
        translate([16,29,0]) cylinder(h=10,d=hole_440, center=true);
        translate([-16,-29,0]) cylinder(h=10,d=hole_440, center=true);
    }
    
    // caster wheels
    translate([40,0,0]) caster();
    translate([-40,0,0]) caster();
    
    // line following array
    translate([25,0,0]) array_mnt(55);
}

//motor_plate(thick, false);
//translate([0,0,28]) base_plate(thick);
base_plate(thick);

//motor_mnt();

//caster();

// straight motors
//color("lightgray") difference()
//{
//    cylinder(h=thick,d=100, center=true);
//    translate([0,47,0]) cube([65,30,10], center=true);
//    translate([0,-47,0]) cube([65,30,10], center=true);
//}
//
//translate([0,0,thick/2]) board();
//
//translate([0,0,22.8/2+thick/2]){
//translate([-25,25,0]){
//    rotate([0,0,0]) motor_straight();
//    translate([20.6,20,0]) wheel();
//}
//translate([0,-25,0]){
//    rotate([180,180,0]){
//        motor_straight();
//        translate([20.6,20,0]) wheel();
//    }
//}
//}
