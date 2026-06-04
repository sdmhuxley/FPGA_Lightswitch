# FPGA_Lightswitch
This is an FPGA project that uses a Bluetooth module and a light switch phone app to control a servo motor that switches a light switch on and off. It also has a buzzer to signal when the light switch is turned on. The phone app has two buttons, each to send a hex code to the Bluetooth module. The servo motor is connected to the light switch which allows it to flip said switch. 

1. The Constraints folder contains the BASYS-3 board constraints
2. The Sources folder contains all Verilog code neccesary for the project including a top module and all of its submodules
3. bluetooth_app.aia was created using MIT App Designer and allows for connection via a mobile device to the HM-10 Bluetooth Module

Hardware Used:
- BASYS-3 FPGA Board
- HM-10 Bluetooth Module
- SG90 Servo Motor
- Piezo Buzzer
