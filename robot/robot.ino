

#include <Wire.h>
#include "TB6612FNG.h"

/*
name motors left/right not A/B

*/

const int a1    = 13;
const int a2    = 12;
const int pwma  = 11;  // HW
const int b1    = 8;
const int b2    = 9;
const int pwmb  = 10; // HW
//const int RESET  = 14;
//const int BEEP   = 15;


class Robot {
public:
	Robot(){
//		motorAB = new MotorDriver(pwma,a1,a2,pwmb,b1,b2);
    motorAB.init(pwma,a1,a2,pwmb,b1,b2);
    motorAB.begin();
	}
	// dir <xxxx d c b a>  0 - reverse, 1 - forward
	// void setMotors(byte dir, byte a, byte b, byte c, byte d){
	void drive(byte dir, byte a, byte b){
		if(dir & 1) motorAB.motor0Forward(a);
		else motorAB.motor0Reverse(a);

		if(dir & 2) motorAB.motor1Forward(b);
		else this->motorAB.motor1Reverse(b);
	}

	void allStop(){
		motorAB.coastBothMotors();
		delay(100);
		motorAB.stopBothMotors();
	}

  int motorTest(int spd){
    spd += 10;
    if(spd>100) spd = 0;
    motorAB.motor0Forward(spd);
    motorAB.motor1Forward(spd);
    delay(1000);
    motorAB.motor0Reverse(spd);
    motorAB.motor1Reverse(spd);

    return spd;
  }

	void run(){
    static int spd = 0;
		// check sensors
		// move motors
//    spd = motorTest(spd);
    delay(1000);
    Serial.println(spd);
//    Serial.println((int)motorAB);
	}

 void turnLeft(int spd){
    motorAB.motor0Forward(spd);
    motorAB.motor1Reverse(spd);
 }
 
  void turnRight(int spd){
    motorAB.motor1Forward(spd);
    motorAB.motor0Reverse(spd);
 }

 void forward(int spd){
    motorAB.motor0Forward(spd);
    motorAB.motor1Forward(spd);
 }

 void wander(){
  int front = analogRead(0); // green
  int left = analogRead(2); // blue
  int right = analogRead(1); // orange

  int detect = 150;
  int spd = 50;
  int lrturn = 100; // left/right turn time
  int fturn = 1000; // front turn time
  
  Serial.println(front);
  if (front > detect){
    if (left > detect && right > detect){
      turnRight(spd);
      delay(1000); // try to get 180 with 2 delays
    }
    else if (left > detect){
      turnRight(spd);
      delay(1000);
    }
    else {
      turnLeft(spd);
      delay(1000);
    }
  }
  else if (left > detect){
      turnRight(spd);
      delay(1000);
    }
  else if (right > detect){
      turnLeft(spd);
      delay(1000);
    }
  else {
    forward(50);
    delay(100);
  }
 }

private:
  MotorDriver motorAB;
};

Robot *robot = NULL;

//MotorDriver md(pwma,a1,a2,pwmb,b1,b2);
//int spd = 0;

void setup(){
  robot = new Robot();
	Serial.begin(9600);
	Serial.println("hello world");
}


void mdtest(){
  int spd = 0;
  MotorDriver md;
  md.init(pwma,a1,a2,pwmb,b1,b2);
  while(true){
    spd += 10;
    if(spd>100) spd = 0;
    md.motor0Forward(spd);
    md.motor1Forward(spd);
    delay(1000);
    md.motor0Reverse(spd);
    md.motor1Reverse(spd);
    delay(1000);
    
  }
}


void loop(){
//    mdtest();

  int a = 0;
	while(true){
		robot->wander();
//		delay(1000);
//    a = analogRead(0);
//    Serial.println(a);
	}
}
