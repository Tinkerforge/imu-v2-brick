EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:tinkerforge
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 6
Title "IMU Brick"
Date "17 mar 2015"
Rev "2.0"
Comp "Tinkerforge GmbH"
Comment1 "Licensed under CERN OHL v.1.1"
Comment2 "Copyright (©) 2015, B.Nordmeyer <bastian@tinkerforge.com>"
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	8550 5350 8200 5350
Wire Wire Line
	8200 5350 8200 5400
Wire Wire Line
	3100 4250 3100 4750
Wire Wire Line
	2800 3850 2800 3800
Connection ~ 3000 3800
Wire Wire Line
	3000 3850 3000 3800
Wire Wire Line
	7300 5800 7300 5750
Wire Wire Line
	7300 5750 7550 5750
Connection ~ 4750 4650
Wire Wire Line
	4750 3800 4750 5550
Connection ~ 4650 4750
Wire Wire Line
	4650 5650 4650 3900
Wire Wire Line
	6300 4400 7550 4400
Wire Wire Line
	6300 4200 7550 4200
Wire Wire Line
	7550 6150 6300 6150
Wire Wire Line
	7550 5950 6300 5950
Connection ~ 3100 4750
Connection ~ 2950 3800
Wire Wire Line
	2950 3700 2950 3800
Wire Wire Line
	4750 4650 2200 4650
Wire Wire Line
	4650 5650 7550 5650
Wire Wire Line
	4650 3900 7550 3900
Wire Wire Line
	9000 6350 9000 6300
Wire Wire Line
	9000 4600 9000 4550
Wire Wire Line
	4750 3800 7550 3800
Wire Wire Line
	4750 5550 7550 5550
Wire Wire Line
	4650 4750 2200 4750
Wire Wire Line
	2800 3800 3100 3800
Connection ~ 2800 4650
Wire Wire Line
	7550 5850 6300 5850
Wire Wire Line
	7550 6050 6300 6050
Wire Wire Line
	6300 4100 7550 4100
Wire Wire Line
	6300 4300 7550 4300
Wire Wire Line
	7550 4000 7100 4000
Wire Wire Line
	7100 4000 7100 3700
Wire Wire Line
	2900 3850 2900 3800
Connection ~ 2900 3800
Wire Wire Line
	3100 3800 3100 3850
Wire Wire Line
	2800 4250 2800 4650
Wire Wire Line
	8200 3650 8200 3600
Wire Wire Line
	8200 3600 8550 3600
NoConn ~ 3000 4250
NoConn ~ 2900 4250
$Comp
L R_PACK4 RP5
U 1 1 4DA6BCC5
P 2750 4050
F 0 "RP5" H 2750 4500 40  0000 C CNN
F 1 "1k" H 2750 4000 40  0000 C CNN
F 2 "kicad-libraries:0603X4" H 2750 4050 60  0001 C CNN
F 3 "" H 2750 4050 60  0001 C CNN
	1    2750 4050
	0    1    1    0   
$EndComp
$Comp
L GND #PWR023
U 1 1 4D0FDD4E
P 7300 5800
F 0 "#PWR023" H 7300 5800 30  0001 C CNN
F 1 "GND" H 7300 5730 30  0001 C CNN
F 2 "" H 7300 5800 60  0001 C CNN
F 3 "" H 7300 5800 60  0001 C CNN
	1    7300 5800
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR024
U 1 1 4D0FDD41
P 7100 3700
F 0 "#PWR024" H 7100 3800 40  0001 C CNN
F 1 "3V3" H 7100 3825 40  0000 C CNN
F 2 "" H 7100 3700 60  0001 C CNN
F 3 "" H 7100 3700 60  0001 C CNN
	1    7100 3700
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR025
U 1 1 4CAC8AB4
P 2950 3700
F 0 "#PWR025" H 2950 3800 40  0001 C CNN
F 1 "3V3" H 2950 3825 40  0000 C CNN
F 2 "" H 2950 3700 60  0001 C CNN
F 3 "" H 2950 3700 60  0001 C CNN
	1    2950 3700
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR026
U 1 1 4CAC88AE
P 6700 900
F 0 "#PWR026" H 6700 990 20  0001 C CNN
F 1 "+5V" H 6700 990 30  0000 C CNN
F 2 "" H 6700 900 60  0001 C CNN
F 3 "" H 6700 900 60  0001 C CNN
	1    6700 900 
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR027
U 1 1 4CAC87D9
P 6700 1950
F 0 "#PWR027" H 6700 2050 40  0001 C CNN
F 1 "3V3" H 6700 2075 40  0000 C CNN
F 2 "" H 6700 1950 60  0001 C CNN
F 3 "" H 6700 1950 60  0001 C CNN
	1    6700 1950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR028
U 1 1 4CAC87AD
P 8200 3650
F 0 "#PWR028" H 8200 3650 30  0001 C CNN
F 1 "GND" H 8200 3580 30  0001 C CNN
F 2 "" H 8200 3650 60  0001 C CNN
F 3 "" H 8200 3650 60  0001 C CNN
	1    8200 3650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR029
U 1 1 4CAC87A9
P 8200 5400
F 0 "#PWR029" H 8200 5400 30  0001 C CNN
F 1 "GND" H 8200 5330 30  0001 C CNN
F 2 "" H 8200 5400 60  0001 C CNN
F 3 "" H 8200 5400 60  0001 C CNN
	1    8200 5400
	1    0    0    -1  
$EndComp
Text GLabel 6300 5950 0    60   Input ~ 0
BRICKLET-IO1_1/DA1
Text GLabel 6300 4200 0    60   Input ~ 0
BRICKLET-IO0_1/DA0
Text GLabel 6300 4400 0    60   Input ~ 0
BRICKLET-IO0_3
Text GLabel 6300 6150 0    60   Input ~ 0
BRICKLET-IO1_3
Text GLabel 6300 6050 0    60   Input ~ 0
BRICKLET-IO1_2/PWM1
Text GLabel 6300 4300 0    60   Input ~ 0
BRICKLET-IO0_2/PWM0
Text GLabel 6300 5850 0    60   Input ~ 0
BRICKLET-IO1_0/AD1
Text GLabel 6300 4100 0    60   Input ~ 0
BRICKLET-IO0_0/AD0
Text GLabel 2200 4650 0    60   Input ~ 0
BRICKLET-I2C-SCL
Text GLabel 2200 4750 0    60   Input ~ 0
BRICKLET-I2C-SDA
$Comp
L GND #PWR030
U 1 1 4CAC33F4
P 9000 6350
F 0 "#PWR030" H 9000 6350 30  0001 C CNN
F 1 "GND" H 9000 6280 30  0001 C CNN
F 2 "" H 9000 6350 60  0001 C CNN
F 3 "" H 9000 6350 60  0001 C CNN
	1    9000 6350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR031
U 1 1 4CAC33ED
P 9000 4600
F 0 "#PWR031" H 9000 4600 30  0001 C CNN
F 1 "GND" H 9000 4530 30  0001 C CNN
F 2 "" H 9000 4600 60  0001 C CNN
F 3 "" H 9000 4600 60  0001 C CNN
	1    9000 4600
	1    0    0    -1  
$EndComp
$Comp
L CON-SENSOR P2
U 1 1 4CAC3392
P 9000 5700
F 0 "P2" H 8750 6250 60  0000 C CNN
F 1 "CON-SENSOR" V 9200 5700 60  0000 C CNN
F 2 "kicad-libraries:CON-SENSOR" H 9000 5700 60  0001 C CNN
F 3 "" H 9000 5700 60  0001 C CNN
	1    9000 5700
	1    0    0    -1  
$EndComp
$Comp
L CON-SENSOR P1
U 1 1 4CAC338E
P 9000 3950
F 0 "P1" H 8750 4500 60  0000 C CNN
F 1 "CON-SENSOR" V 9200 3950 60  0000 C CNN
F 2 "kicad-libraries:CON-SENSOR" H 9000 3950 60  0001 C CNN
F 3 "" H 9000 3950 60  0001 C CNN
	1    9000 3950
	1    0    0    -1  
$EndComp
$Comp
L Filter-8x FILTER401
U 1 1 550801E9
P 7850 4150
F 0 "FILTER401" H 7750 4600 60  0000 C CNN
F 1 "IP4254" V 7850 4250 60  0000 C CNN
F 2 "DFN16-33x135" H 7850 4150 60  0001 C CNN
F 3 "~" H 7850 4150 60  0000 C CNN
	1    7850 4150
	-1   0    0    -1  
$EndComp
$Comp
L Filter-8x FILTER402
U 1 1 5508020E
P 7850 5900
F 0 "FILTER402" H 7750 6350 60  0000 C CNN
F 1 "IP4254" V 7850 6000 60  0000 C CNN
F 2 "DFN16-33x135" H 7850 5900 60  0001 C CNN
F 3 "~" H 7850 5900 60  0000 C CNN
	1    7850 5900
	-1   0    0    -1  
$EndComp
NoConn ~ 7550 4500
NoConn ~ 8150 4500
NoConn ~ 7550 6250
NoConn ~ 8150 6250
$Comp
L GND #PWR032
U 1 1 5508021E
P 7850 6500
F 0 "#PWR032" H 7850 6500 30  0001 C CNN
F 1 "GND" H 7850 6430 30  0001 C CNN
F 2 "" H 7850 6500 60  0001 C CNN
F 3 "" H 7850 6500 60  0001 C CNN
	1    7850 6500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR033
U 1 1 55080224
P 7850 4750
F 0 "#PWR033" H 7850 4750 30  0001 C CNN
F 1 "GND" H 7850 4680 30  0001 C CNN
F 2 "" H 7850 4750 60  0001 C CNN
F 3 "" H 7850 4750 60  0001 C CNN
	1    7850 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 4750 7850 4700
Wire Wire Line
	7850 6500 7850 6450
Wire Wire Line
	8150 6150 8550 6150
Wire Wire Line
	8550 6050 8150 6050
Wire Wire Line
	8150 5950 8550 5950
Wire Wire Line
	8550 5850 8150 5850
Wire Wire Line
	8150 5750 8550 5750
Wire Wire Line
	8550 5650 8150 5650
Wire Wire Line
	8150 5550 8550 5550
Wire Wire Line
	8150 4400 8550 4400
Wire Wire Line
	8550 4300 8150 4300
Wire Wire Line
	8150 4200 8550 4200
Wire Wire Line
	8550 4100 8150 4100
Wire Wire Line
	8150 4000 8550 4000
Wire Wire Line
	8550 3900 8150 3900
Wire Wire Line
	8150 3800 8550 3800
$Comp
L C C401
U 1 1 55080544
P 6850 1150
F 0 "C401" H 6850 1250 40  0000 L CNN
F 1 "1µF" H 6856 1065 40  0000 L CNN
F 2 "kicad-libraries:0603" H 6888 1000 30  0001 C CNN
F 3 "~" H 6850 1150 60  0000 C CNN
	1    6850 1150
	1    0    0    -1  
$EndComp
$Comp
L FILTER FB401
U 1 1 55080569
P 7200 900
F 0 "FB401" H 7200 1050 60  0000 C CNN
F 1 "FILTER" H 7200 800 60  0000 C CNN
F 2 "" H 7200 900 60  0000 C CNN
F 3 "~" H 7200 900 60  0000 C CNN
	1    7200 900 
	1    0    0    -1  
$EndComp
$Comp
L C C403
U 1 1 55080576
P 7550 1150
F 0 "C403" H 7550 1250 40  0000 L CNN
F 1 "1µF" H 7556 1065 40  0000 L CNN
F 2 "kicad-libraries:0603" H 7588 1000 30  0001 C CNN
F 3 "~" H 7550 1150 60  0000 C CNN
	1    7550 1150
	1    0    0    -1  
$EndComp
$Comp
L TVS D401
U 1 1 5508057E
P 7850 1150
F 0 "D401" H 7800 1250 40  0000 C CNN
F 1 "ESD5V0D3B-TP" H 7850 1050 40  0000 C CNN
F 2 "kicad-libraries:SOD-323" H 7850 1150 60  0001 C CNN
F 3 "~" H 7850 1150 60  0000 C CNN
	1    7850 1150
	0    1    1    0   
$EndComp
$Comp
L GND #PWR034
U 1 1 550805A1
P 7850 1450
F 0 "#PWR034" H 7850 1450 30  0001 C CNN
F 1 "GND" H 7850 1380 30  0001 C CNN
F 2 "" H 7850 1450 60  0001 C CNN
F 3 "" H 7850 1450 60  0001 C CNN
	1    7850 1450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR035
U 1 1 550805A7
P 7550 1450
F 0 "#PWR035" H 7550 1450 30  0001 C CNN
F 1 "GND" H 7550 1380 30  0001 C CNN
F 2 "" H 7550 1450 60  0001 C CNN
F 3 "" H 7550 1450 60  0001 C CNN
	1    7550 1450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR036
U 1 1 550805AD
P 6850 1450
F 0 "#PWR036" H 6850 1450 30  0001 C CNN
F 1 "GND" H 6850 1380 30  0001 C CNN
F 2 "" H 6850 1450 60  0001 C CNN
F 3 "" H 6850 1450 60  0001 C CNN
	1    6850 1450
	1    0    0    -1  
$EndComp
$Comp
L C C402
U 1 1 550805B3
P 6850 2200
F 0 "C402" H 6850 2300 40  0000 L CNN
F 1 "1µF" H 6856 2115 40  0000 L CNN
F 2 "kicad-libraries:0603" H 6888 2050 30  0001 C CNN
F 3 "~" H 6850 2200 60  0000 C CNN
	1    6850 2200
	1    0    0    -1  
$EndComp
$Comp
L FILTER FB402
U 1 1 550805B9
P 7200 1950
F 0 "FB402" H 7200 2100 60  0000 C CNN
F 1 "FILTER" H 7200 1850 60  0000 C CNN
F 2 "" H 7200 1950 60  0000 C CNN
F 3 "~" H 7200 1950 60  0000 C CNN
	1    7200 1950
	1    0    0    -1  
$EndComp
$Comp
L C C404
U 1 1 550805BF
P 7550 2200
F 0 "C404" H 7550 2300 40  0000 L CNN
F 1 "1µF" H 7556 2115 40  0000 L CNN
F 2 "kicad-libraries:0603" H 7588 2050 30  0001 C CNN
F 3 "~" H 7550 2200 60  0000 C CNN
	1    7550 2200
	1    0    0    -1  
$EndComp
$Comp
L TVS D402
U 1 1 550805C5
P 7850 2200
F 0 "D402" H 7800 2300 40  0000 C CNN
F 1 "ESD3V3D3B-TP" H 7850 2100 40  0000 C CNN
F 2 "kicad-libraries:SOD-323" H 7850 2200 60  0001 C CNN
F 3 "~" H 7850 2200 60  0000 C CNN
	1    7850 2200
	0    1    1    0   
$EndComp
$Comp
L GND #PWR037
U 1 1 550805CB
P 7850 2500
F 0 "#PWR037" H 7850 2500 30  0001 C CNN
F 1 "GND" H 7850 2430 30  0001 C CNN
F 2 "" H 7850 2500 60  0001 C CNN
F 3 "" H 7850 2500 60  0001 C CNN
	1    7850 2500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR038
U 1 1 550805D1
P 7550 2500
F 0 "#PWR038" H 7550 2500 30  0001 C CNN
F 1 "GND" H 7550 2430 30  0001 C CNN
F 2 "" H 7550 2500 60  0001 C CNN
F 3 "" H 7550 2500 60  0001 C CNN
	1    7550 2500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR039
U 1 1 550805D7
P 6850 2500
F 0 "#PWR039" H 6850 2500 30  0001 C CNN
F 1 "GND" H 6850 2430 30  0001 C CNN
F 2 "" H 6850 2500 60  0001 C CNN
F 3 "" H 6850 2500 60  0001 C CNN
	1    6850 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6850 2500 6850 2400
Wire Wire Line
	7550 2500 7550 2400
Wire Wire Line
	7850 2500 7850 2450
Wire Wire Line
	7550 1950 8300 1950
Wire Wire Line
	8300 1950 8300 5450
Wire Wire Line
	8300 3700 8550 3700
Connection ~ 7850 1950
Wire Wire Line
	8300 5450 8550 5450
Connection ~ 8300 3700
Wire Wire Line
	7550 900  8400 900 
Wire Wire Line
	8400 900  8400 5250
Wire Wire Line
	8400 3500 8550 3500
Wire Wire Line
	8400 5250 8550 5250
Connection ~ 8400 3500
Wire Wire Line
	7550 2000 7550 1950
Wire Wire Line
	6850 1950 6850 2000
Wire Wire Line
	6850 1950 6700 1950
Wire Wire Line
	6850 1450 6850 1350
Wire Wire Line
	6700 900  6850 900 
Wire Wire Line
	6850 900  6850 950 
Wire Wire Line
	7550 900  7550 950 
Wire Wire Line
	7550 1350 7550 1450
Wire Wire Line
	7850 1400 7850 1450
Connection ~ 7550 1950
Connection ~ 6850 1950
Connection ~ 6850 900 
Connection ~ 7550 900 
Connection ~ 7850 900 
$EndSCHEMATC
