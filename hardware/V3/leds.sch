EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 6
Title "IMU Brick"
Date "2020-02-13"
Rev "3.0"
Comp "Tinkerforge GmbH"
Comment1 "Licensed under CERN OHL v.1.1"
Comment2 "Copyright (©) 2020, T.Schneidermann <tim@tinkerforge.com>"
Comment3 ""
Comment4 ""
$EndDescr
NoConn ~ 5400 2800
NoConn ~ 5400 3550
Wire Wire Line
	5050 5450 5400 5450
Wire Wire Line
	5050 5250 5400 5250
Wire Wire Line
	5050 3450 5400 3450
Wire Wire Line
	5050 3250 5400 3250
Wire Wire Line
	5050 2600 5400 2600
Wire Wire Line
	6350 3850 6050 3850
Wire Wire Line
	6050 3850 6050 3450
Wire Wire Line
	6050 3450 5800 3450
Wire Wire Line
	6350 3150 6150 3150
Wire Wire Line
	6150 3150 6150 3250
Wire Wire Line
	6150 3250 5800 3250
Wire Wire Line
	6350 2450 6150 2450
Wire Wire Line
	6150 2450 6150 2600
Wire Wire Line
	6150 2600 5800 2600
Wire Wire Line
	5800 5450 6050 5450
Wire Wire Line
	6050 5450 6050 5750
Wire Wire Line
	6050 5750 6350 5750
Wire Wire Line
	6350 5150 6150 5150
Wire Wire Line
	6150 5150 6150 5250
Wire Wire Line
	6150 5250 5800 5250
Connection ~ 6750 5450
Wire Wire Line
	6750 5750 6750 5450
Connection ~ 6750 4850
Connection ~ 6750 2150
Connection ~ 6750 3550
Wire Wire Line
	6750 3850 6750 3550
Connection ~ 6750 2850
Connection ~ 6750 2450
Connection ~ 6750 3150
Connection ~ 6750 5150
Wire Wire Line
	5800 5150 6050 5150
Wire Wire Line
	6050 5150 6050 4850
Wire Wire Line
	6050 4850 6350 4850
Wire Wire Line
	5800 5350 6150 5350
Wire Wire Line
	6150 5350 6150 5450
Wire Wire Line
	6150 5450 6350 5450
Wire Wire Line
	6350 2150 6050 2150
Wire Wire Line
	6050 2150 6050 2500
Wire Wire Line
	6050 2500 5800 2500
Wire Wire Line
	5800 2700 6150 2700
Wire Wire Line
	6150 2700 6150 2850
Wire Wire Line
	6150 2850 6350 2850
Wire Wire Line
	5800 3350 6150 3350
Wire Wire Line
	6150 3350 6150 3550
Wire Wire Line
	6150 3550 6350 3550
Wire Wire Line
	5050 2500 5400 2500
Wire Wire Line
	5050 2700 5400 2700
Wire Wire Line
	5050 3350 5400 3350
Wire Wire Line
	5050 5150 5400 5150
Wire Wire Line
	5050 5350 5400 5350
Text GLabel 5050 5250 0    60   Input ~ 0
LED-DEG-4
Text GLabel 5050 5450 0    60   Input ~ 0
LED-DEG-3
Text GLabel 5050 5350 0    60   Input ~ 0
LED-DEG-2
Text Notes 5950 4400 0    120  ~ 24
DEGREE
Text GLabel 5050 5150 0    60   Input ~ 0
LED-DEG-1
Text GLabel 5050 3450 0    60   Input ~ 0
LED-XYZ-ZB
Text GLabel 5050 3350 0    60   Input ~ 0
LED-XYZ-ZA
Text GLabel 5050 3250 0    60   Input ~ 0
LED-XYZ-YB
Text GLabel 5050 2700 0    60   Input ~ 0
LED-XYZ-YA
Text GLabel 5050 2600 0    60   Input ~ 0
LED-XYZ-XB
Text GLabel 5050 2500 0    60   Input ~ 0
LED-XYZ-XA
NoConn ~ 5800 3550
NoConn ~ 5800 2800
$Comp
L tinkerforge:R_PACK4 RP3
U 1 1 4D2466DC
P 5600 3600
F 0 "RP3" H 5600 4050 40  0000 C CNN
F 1 "1k" H 5600 3550 40  0000 C CNN
F 2 "kicad-libraries:0603X4" H 5600 3600 60  0001 C CNN
F 3 "" H 5600 3600 60  0001 C CNN
	1    5600 3600
	1    0    0    -1  
$EndComp
$Comp
L tinkerforge:R_PACK4 RP2
U 1 1 4D2466CE
P 5600 2850
F 0 "RP2" H 5600 3300 40  0000 C CNN
F 1 "1k" H 5600 2800 40  0000 C CNN
F 2 "kicad-libraries:0603X4" H 5600 2850 60  0001 C CNN
F 3 "" H 5600 2850 60  0001 C CNN
	1    5600 2850
	1    0    0    -1  
$EndComp
$Comp
L tinkerforge:R_PACK4 RP4
U 1 1 4D2466C4
P 5600 5500
F 0 "RP4" H 5600 5950 40  0000 C CNN
F 1 "1k" H 5600 5450 40  0000 C CNN
F 2 "kicad-libraries:0603X4" H 5600 5500 60  0001 C CNN
F 3 "" H 5600 5500 60  0001 C CNN
	1    5600 5500
	1    0    0    -1  
$EndComp
$Comp
L tinkerforge:3V3 #PWR012
U 1 1 4D246675
P 6750 4700
F 0 "#PWR012" H 6750 4800 40  0001 C CNN
F 1 "3V3" H 6750 4825 40  0000 C CNN
F 2 "" H 6750 4700 60  0001 C CNN
F 3 "" H 6750 4700 60  0001 C CNN
	1    6750 4700
	1    0    0    -1  
$EndComp
$Comp
L tinkerforge:LED D12
U 1 1 4D246651
P 6550 5750
F 0 "D12" H 6550 5650 50  0000 C CNN
F 1 "green" H 6550 5850 50  0000 C CNN
F 2 "kicad-libraries:D0603" H 6550 5750 60  0001 C CNN
F 3 "" H 6550 5750 60  0001 C CNN
	1    6550 5750
	-1   0    0    1   
$EndComp
$Comp
L tinkerforge:LED D11
U 1 1 4D24664E
P 6550 5450
F 0 "D11" H 6550 5350 50  0000 C CNN
F 1 "green" H 6550 5550 50  0000 C CNN
F 2 "kicad-libraries:D0603" H 6550 5450 60  0001 C CNN
F 3 "" H 6550 5450 60  0001 C CNN
	1    6550 5450
	-1   0    0    1   
$EndComp
$Comp
L tinkerforge:LED D10
U 1 1 4D24664C
P 6550 5150
F 0 "D10" H 6550 5050 50  0000 C CNN
F 1 "green" H 6550 5250 50  0000 C CNN
F 2 "kicad-libraries:D0603" H 6550 5150 60  0001 C CNN
F 3 "" H 6550 5150 60  0001 C CNN
	1    6550 5150
	-1   0    0    1   
$EndComp
$Comp
L tinkerforge:LED D9
U 1 1 4D246641
P 6550 4850
F 0 "D9" H 6550 4750 50  0000 C CNN
F 1 "green" H 6550 4950 50  0000 C CNN
F 2 "kicad-libraries:D0603" H 6550 4850 60  0001 C CNN
F 3 "" H 6550 4850 60  0001 C CNN
	1    6550 4850
	-1   0    0    1   
$EndComp
$Comp
L tinkerforge:3V3 #PWR013
U 1 1 4D246626
P 6750 2050
F 0 "#PWR013" H 6750 2150 40  0001 C CNN
F 1 "3V3" H 6750 2175 40  0000 C CNN
F 2 "" H 6750 2050 60  0001 C CNN
F 3 "" H 6750 2050 60  0001 C CNN
	1    6750 2050
	1    0    0    -1  
$EndComp
Text Notes 5900 1800 0    120  ~ 24
X-Y-Z Axis
$Comp
L tinkerforge:LED D8
U 1 1 4D246603
P 6550 3850
F 0 "D8" H 6550 3750 50  0000 C CNN
F 1 "red" H 6550 3950 50  0000 C CNN
F 2 "kicad-libraries:D0603" H 6550 3850 60  0001 C CNN
F 3 "" H 6550 3850 60  0001 C CNN
	1    6550 3850
	-1   0    0    1   
$EndComp
$Comp
L tinkerforge:LED D7
U 1 1 4D246602
P 6550 3550
F 0 "D7" H 6550 3450 50  0000 C CNN
F 1 "blue" H 6550 3650 50  0000 C CNN
F 2 "kicad-libraries:D0603" H 6550 3550 60  0001 C CNN
F 3 "" H 6550 3550 60  0001 C CNN
	1    6550 3550
	-1   0    0    1   
$EndComp
$Comp
L tinkerforge:LED D5
U 1 1 4D2465F8
P 6550 2850
F 0 "D5" H 6550 2750 50  0000 C CNN
F 1 "blue" H 6550 2950 50  0000 C CNN
F 2 "kicad-libraries:D0603" H 6550 2850 60  0001 C CNN
F 3 "" H 6550 2850 60  0001 C CNN
	1    6550 2850
	-1   0    0    1   
$EndComp
$Comp
L tinkerforge:LED D6
U 1 1 4D2465F7
P 6550 3150
F 0 "D6" H 6550 3050 50  0000 C CNN
F 1 "red" H 6550 3250 50  0000 C CNN
F 2 "kicad-libraries:D0603" H 6550 3150 60  0001 C CNN
F 3 "" H 6550 3150 60  0001 C CNN
	1    6550 3150
	-1   0    0    1   
$EndComp
$Comp
L tinkerforge:LED D4
U 1 1 4D2465D4
P 6550 2450
F 0 "D4" H 6550 2350 50  0000 C CNN
F 1 "red" H 6550 2550 50  0000 C CNN
F 2 "kicad-libraries:D0603" H 6550 2450 60  0001 C CNN
F 3 "" H 6550 2450 60  0001 C CNN
	1    6550 2450
	-1   0    0    1   
$EndComp
$Comp
L tinkerforge:LED D3
U 1 1 4D2465BB
P 6550 2150
F 0 "D3" H 6550 2050 50  0000 C CNN
F 1 "blue" H 6550 2250 50  0000 C CNN
F 2 "kicad-libraries:D0603" H 6550 2150 60  0001 C CNN
F 3 "" H 6550 2150 60  0001 C CNN
	1    6550 2150
	-1   0    0    1   
$EndComp
Wire Wire Line
	6750 5450 6750 5150
Wire Wire Line
	6750 4850 6750 4700
Wire Wire Line
	6750 2150 6750 2050
Wire Wire Line
	6750 3550 6750 3150
Wire Wire Line
	6750 2850 6750 2450
Wire Wire Line
	6750 2450 6750 2150
Wire Wire Line
	6750 3150 6750 2850
Wire Wire Line
	6750 5150 6750 4850
$EndSCHEMATC
