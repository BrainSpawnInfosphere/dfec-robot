

#include <Wire.h>
#include "TB6612FNG.h"

const int m1a    = 22
const int m1b    = 23
const int m1pwm  = 7
const int m2a    = 24
const int m2b    = 25
const int m2pwm  = 8
const int RESET  = 14
const int BEEP   = 15


class Robot {
public:
	Robot(){
		this->motorAB = new MotorDriver(m1pwm,m1a,m1b,m2pwm,m2a,m2b);
		this->motorAB.begin();
	}
	// dir <xxxx d c b a>  0 - reverse, 1 - forward
	// void setMotors(byte dir, byte a, byte b, byte c, byte d){
	void drive(byte dir, byte a, byte b){
		if(dir & 1) motorAB.motor0Forward(a);
		else motorAB.motor0Reverse(a);

		if(dir & 2) motorAB.motor1Forward(b);
		else motorAB.motor1Reverse(b);
	}

	void allStop(){
		motorAB.coastBothMotors();
		delay(100);
		motorAB.stopBothMotors();
	}

	void run(){
		// check sensors
		// move motors
	}

private:
	MotorDriver motorAB*;
};

Robot robot = Robot();


void setup(){
	Serial.begin(9600);
	Serial.println('hello world');
}


void loop(){
	while(true){
		robot.run();
		delay(100);
	}
}
