



#include <Wire.h>
#include <L3G4200D.h>
#include <LSM303.h>

#include "cTone.h"
#include "TB6612FNG.h"
#include "cSensor.h"

#define m1a    22
#define m1b    23
#define m1pwm  7
#define m2a    24
#define m2b    25
#define m2pwm  8
#define RESET   14
#define BEEP    15


class Robot {
public:
	Robot(){
		this->motorAB = MotorDriver(m1pwm,m1a,m1b,m2pwm,m2a,m2b);
		this->begin();
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

private:
	MotorDriver motorAB*;
}


void setup(){
	robot = Robot();
}


void loop(){
	;

}
