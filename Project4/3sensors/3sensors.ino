
#include<Wire.h>

const int MPU6050_addr = 0x68;
int16_t AccX, AccY, AccZ, Temp, GyroX, GyroY, GyroZ;
const int pressure = A1; // Pin connected to FSR/resistor divider
int stretch = A0;    // Sensor connected to analog pin A0

void setup()
{
  pinMode(pressure, INPUT); //0-970
  Wire.begin();
  Wire.beginTransmission(MPU6050_addr);
  Wire.write(0x6B);
  Wire.write(0);
  Wire.endTransmission(true);
  Serial.begin(9600);
}

void loop()
{
  Wire.beginTransmission(MPU6050_addr);
  Wire.write(0x3B);
  Wire.endTransmission(false);
  Wire.requestFrom(MPU6050_addr, 14, true);
  AccX = Wire.read() << 8 | Wire.read();
  AccY = Wire.read() << 8 | Wire.read();
  AccZ = Wire.read() << 8 | Wire.read();
  
  Serial.print(analogRead(stretch));
  Serial.print(":");
  Serial.print(AccY);
  Serial.print(":");
  Serial.print(AccX);
  Serial.print(":");
  Serial.println(AccZ);
  delay(30);


}
