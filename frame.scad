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
    translate([0,2.1,2.1]) rotate([0,-90,0]){
        cylinder(10,d=hole_256,center=true);
        translate([0,0,-1]) cylinder(10,d=2.5*hole_256,center=false);
    }
    translate([0,10.8-2.1,23.4+2.1/2+2]) rotate([0,-90,0]){
        cylinder(10,d=hole_256,center=true);
        translate([0,0,-1]) cylinder(10,d=2.5*hole_256,center=false);
    }
    translate([-5,8,-1]) cube([10,7,12]);  // connector
}

module ir_mnt(){
    translate([0,-15/2,0]) difference(){
        cube([3,13,30]);
        translate([0,2.5,1]) irholes();
    }
}

module wheel(){
    color("gray") rotate([90,0,0]) cylinder(h=8, d=60.1);
}

module board(){
    color("green") translate([-70/2, -35/2, 0]) cube([70,35,2]);
    color("green") translate([-10, -7.5, 0]) cube([20,15,19]);
}

module board_mnt(){
    // won't work like this!!!
    // solder bumps on the back will push it up higher
    w = 20;
    dia = 5;
    difference(){
        rotate([0,90,0]) cylinder(h=w,d=dia, center=true);
        translate([-w,0,-dia/4]) cube([2*w,dia,dia/2]);  // groove
        translate([-w,-dia/2,-dia/2]) cube([2*w,dia,dia/2]);  // cut off bottom
    }
}

//board_mnt();

module motor_straight(){
    difference(){
        union(){
            // gears
            translate([0,-18.8/2,-22.4/2]) cube([36.8, 18.8, 22.4]);
            // motor
            rotate([0,90,0]) translate([0,0,-22.9]) cylinder(h=22.9, d=18.8);
            // shaft
            translate([25.6,0,0]) rotate([-90,0,0]) cylinder(h=18.8/2+9.2,d=5.4);
            // nubbin
            translate([36.8-22.3,0,0]) rotate([-90,0,0]) cylinder(h=18.8/2+2,d=4.48);
        }
        // mounting holes
        translate([36.8-31.8,0,9]) rotate([-90,0,0]) cylinder(h=50.4,d=hole_440,center=true);
        translate([36.8-31.8,0,-9]) rotate([-90,0,0]) cylinder(h=50,d=hole_440,center=true);
    }
}

module motor_90(){
    difference(){
        union(){
            // gears
            translate([-22.5/2,-13.7/2,-22.8/2]) cube([42,13.7,22.8]);
            // motor
            rotate([90,0,0]) translate([0,0,13.72/2]) cylinder(d=22.5, h=33);
            // shaft
            translate([20.6,0,0]) rotate([-90,0,0]) cylinder(h=18.8/2+9.2,d=5.4);
            // nubbin
            translate([9.5,0,0]) rotate([-90,0,0]) cylinder(h=18.8/2+2,d=4.48);
        }
        // mounting holes
        translate([28.5,0,9]) rotate([-90,0,0]) cylinder(h=25,d=hole_256,center=true);
        translate([28.5,0,-9]) rotate([-90,0,0]) cylinder(h=25,d=hole_256,center=true);
    }
}

module motor_mnt(){
    height = 25;
    difference(){
        // main L shape of bracket
        union(){
            translate([-5,0,0]) cube([40,2,height]);
            translate([31.5,-8,0]) cube([9,10,height]);
        }
        
        // cut out in verticle square pillar
        translate([33,-8-1,.3*height/2]) cube([12,12,0.7*height]);
        
        // mounting hole verticle
        translate([36,-3,.2*height/2]) cylinder(h=100, d=hole_440, center=true);
        
        // motor shaft
        translate([20,0,height/2]) rotate([90,0,0]) cylinder(d=8, h=10, center=true);
        
        // nubbin
        translate([8.5,0,height/2]) rotate([90,0,0]) cylinder(d=5.25, h=10, center=true);
        
        // mounting holes
        translate([19.5,0,height/2]) rotate([90,0,0]){
            // 90
            translate([8,9,0]) cylinder(d=hole_256, h=10, center=true);
            translate([8,-9,0]) cylinder(d=hole_256, h=10, center=true);
            // straight
            translate([-20.5,9,0]) cylinder(d=hole_440, h=10, center=true);
            translate([-20.5,-9,0]) cylinder(d=hole_440, h=10, center=true);
        }
    }
}

module breadboard(){
    cube([54,83,10]);
}

module caster(){
    // 18.6 mm w/o thick
    dia = 10;
    h = 16;
    cylinder(h=h-dia/2, d=dia);
    translate([0,0,h-dia/2]) sphere(d=dia);
}

thick = 3;


module motor_plate_90(thick, draw=false){
    // main plate
    color("lightblue") difference()
    {
        cylinder(h=thick,d=100, center=true);
        
        // cut outs for the wheels
        translate([0,49,0]) cube([65,30,10], center=true);
        translate([0,-49,0]) cube([65,30,10], center=true);
    }
    
    // motor mounts
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
    difference(){
        union(){
            translate([0,width/2,0]) cylinder(h=h,d=10);
            translate([0,-width/2,0]) cylinder(h=h,d=10);
            difference(){
                translate([-5,-width/2,h-t]) cube([10,width,t]);
                translate([-hole_256/2,-width/2,h-2*t]) cube([hole_256,width,3*t]);
            }
        }
        translate([0,width/2,0]) cylinder(h=6*h,d=hole_440, center=true);
        translate([0,-width/2,0]) cylinder(h=6*h,d=hole_440, center=true);
    }
}

module base_plate_90(thick, draw=false){
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

//motor_plate_90(thick, true);
//translate([0,0,28]) base_plate_90(thick);
//base_plate_90(thick);

//motor_mnt();

//caster();

module base_plate_s(thick, draw=false){
    // plate
    color("lightblue") difference()
    {
        cylinder(h=thick,d=100, center=true);
        
        // IR cuts
        translate([48,0,0]) cube([10,50,10], center=true);  // front
        translate([28,15,-thick]) cube([35,50,10], center=false);  // robot right
        translate([28,-15,thick]) rotate([180,0,0]) cube([35,50,10], center=false);  // robot left
        
        // wheel cuts
        translate([0,57,0]) cube([65,30,10], center=true);
        translate([0,-57,0]) cube([65,30,10], center=true);
        
        // holes
        translate([16,37,0]) cylinder(h=10,d=hole_440, center=true);
        translate([16,-37,0]) cylinder(h=10,d=hole_440, center=true);
        
        // electronics board holes
        translate([-43,35/2-3,0]) cylinder(h=10,d=hole_256, center=true);
        translate([-43,-35/2+3,0]) cylinder(h=10,d=hole_256, center=true);
        translate([63-43,35/2-3,0]) cylinder(h=10,d=hole_256, center=true);
        translate([63-43,-35/2+3,0]) cylinder(h=10,d=hole_256, center=true);
    }
    
<<<<<<< HEAD
    if (draw){
        // electronics board
=======
    // electronics board
    if (draw){
>>>>>>> aa75e32dec23ce2409879322cab7f08783aae942
        translate([-10,0,-thick/2-1]) rotate([180,0,0]) board();
    }
    
    // caster wheels
    translate([35,0,0]) caster();
    translate([-40,0,0]) caster();
    
    // line following array
//    translate([16,0,0]) array_mnt(68);
}


// straight motors
module motor_plate_s(thick, draw=false){
    color("lightblue") difference()
    {
        cylinder(h=thick,d=100, center=true); // main disk plate
        
        // wheel cut outs
        translate([0,57,0]) cube([65,30,10], center=true);
        translate([0,-57,0]) cube([65,30,10], center=true);
        
        // jumper access
        translate([-54,0,0]) cube([40,50,10], center=true);
        
        
        // IR cuts
        translate([50,0,0]) cube([6,50,10], center=true);
        translate([30,25,-thick]) cube([35,50,10], center=false);
        translate([30,-25,thick]) rotate([180,0,0]) cube([35,50,10], center=false);
        
        // power switch
        translate([25, -37, -4]) cylinder(h=8,d=5.5);
    }
    
    
    // IR sensors
    translate([44,0,thick/2]) ir_mnt();
    translate([37,22,thick/2]) rotate([0,0,90]) ir_mnt();
    translate([37,-22,thick/2]) rotate([0,0,-90]) ir_mnt();
//    rotate([0,0,-30]) translate([44,0,-thick/2]) rotate([0,0,0]) ir_mnt();
//    rotate([0,0,30]) translate([44,0,-thick/2]) rotate([0,0,60]) ir_mnt();
//    rotate([0,0,-30]) translate([44,0,-thick/2]) rotate([0,0,-60]) ir_mnt();
    
    // motor mounts
//    translate([-14,37,thick/2]) color("lightblue") motor_mnt();
    translate([-20,40,thick/2]) color("lightblue") motor_mnt();
    translate([-20,-40,25+thick/2]) rotate([180,0,0]) color("lightblue") motor_mnt();
    
    if (draw){
        translate([0,0,22.8/2+thick/2]){
//            translate([-20,28,1]){
            translate([-26,30.5,1]){
                motor_straight();
                translate([26,22,0]) wheel();
            }
            translate([-26,-30.5,1]){
                rotate([180,0,0]){
                    motor_straight();
//                    translate([26,22,0]) wheel();
                }
            }
        }
    }
}


//motor_plate_s(thick, false);
<<<<<<< HEAD
//translate([0,0,28]) base_plate_s(thick);

base_plate_s(thick, false);
=======
//translate([0,0,28]) base_plate_s(thick, true);

// line following array
//translate([16,0,29.5]) array_mnt(74);

//motor_straight();
//base_plate_s(thick, false);
array_mnt(74);
>>>>>>> aa75e32dec23ce2409879322cab7f08783aae942
