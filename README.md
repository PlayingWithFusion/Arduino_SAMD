<p align="center">
  <img src="https://github.com/PlayingWithFusion/Arduino_SAMD/assets/77081880/05cc5ad2-8b62-4e97-ac00-dcc4c4118d5d" />
</p>

<h1 align="center">Playing With Fusion R3aktor Board Support Package</h1>

This repository contains the board support packages for all "R3aktor core" Arduino-compatible boards based specifically on the SAMD21 family of MCUs from Microchip. 

# Boards

- [R3aktor M0 Logger](https://playingwithfusion.com/productview.php?pdid=157)
- [R3aktor TC Logger](https://www.playingwithfusion.com/productview.php?pdid=230)
- R3aktor RTD Logger (Coming Soon!)

# Related Libraries

- [MAX31856](https://github.com/PlayingWithFusion/PWFusion_MAX31856) Users can utilize this library with the R3aktor TC logger to interface with the on-board MAX31856 chips, as well as any others attached to the on-board SPI bus.
  
- [MAX31865](https://github.com/PlayingWithFusion/PWFusion_MAX31865) This library can be used with the R3aktor RTD logger to perform RTD measurements from on-board MAX31865 chips, and any others attached to the on-board SPI bus.

# Installation Instructions 

To install this package, you **must** have Arduino IDE. If you don't already, you can download it [here](https://www.arduino.cc/en/software)

Next, Copy this url:
```
https://raw.githubusercontent.com/PlayingWithFusion/Arduino_SAMD/main/package_pwfusion_samd_index.json
```

Open the Arduino IDE, and locate the "Additional Board Manager URLs" setting. This should be under **File** > **Preferences** 

![image](https://github.com/PlayingWithFusion/Arduino_SAMD/assets/77081880/276ad1fc-adec-4d65-b9b1-1fa7d63bf747)

Then, paste the url above into the "Additional boards manager URLs:" text box:

![image](https://github.com/PlayingWithFusion/Arduino_SAMD/assets/77081880/50bdcb8f-5c61-424c-a7f4-e99cb06f2dcd)

The IDE will now automatically download the json index and parse the Playing With Fusion boards available. 

Finally, go to the boards manager, and search for "Playing With Fusion SAMD Boards". After finding the backage, select "install"

![image](https://github.com/PlayingWithFusion/Arduino_SAMD/assets/77081880/3ab37634-8a84-4c43-aede-0f20ca65b007)

(These instructions are as of Arduino IDE 2.3.2)

# R3aktor Core Boards

Useful common interractions to R3aktor Core boards. 

For RTD or TC specific functionality & examples, reference either the [MAX31856](https://github.com/PlayingWithFusion/PWFusion_MAX31856) library for TC boards, or the [MAX31865](https://github.com/PlayingWithFusion/PWFusion_MAX31865) library for RTD boards.

### Read Battery Voltage

The battery monitoring circuit measures the battery voltage from a simple voltage divider made of 2 499k ohm resistors, resulting in a 2:1 voltage divider.

The output of this divier is represented by the equation: $V_\text{batt} = 2 * V_\text{div}$ where $V_\text{div}$ is the output of the voltage divider. 

The actual battery voltage can be found from a ADC conversion (obtained with `analogRead()`) by the following equation (Given 10-bit resolution and 1.65V reference):

$$V_\text{batt} = (\text{ADC RESULT} \times 1.65 \times 2) / 2^{10} = (\text{ADC RESULT} \times 3.3) / 1024 $$

If you wish to read the battery voltage from the on-board charge circuit, use this function:

```cpp
/*
 * Get the battery voltage from the charge circuit onboard
 */
float
getBatteryVoltage()
{
  // two 499k ohm resistors create a 
  // voltage divier with a ratio of 1:2
  // 
  // This function assumes:
  // 10-bit wide, 1.65V Vref, which should be 
  // the case if running on a R3actor TC Logger
  return ((float)analogRead(ADC_BATTERY) * 3.3) / 1024.0; // 3.3 = 1.65 * 2
}
```

As long as the default ADC settings hare not changed, this function will work. If you change the Vref or ADC resolution, change this function accordingly to get an accurate reading from the battery circuit. 

### Blink LED with Hardware Timer

Hardware timers are sometimes more desireable than the simple `loop()` function provided by the Arduino framework. For hardware timers, we recommend the use of the [SAMD_TimerInterrupt](https://github.com/khoih-prog/SAMD_TimerInterrupt) library. Reference this source for more info or examples. 

Here is a minimal example that blinks the onboard LED of R3aktor Core boards with the hardware timer:

```cpp
// Make sure that this sketch is running on a SAMD based board
#if !( defined(ARDUINO_SAMD_ZERO) || defined(ARDUINO_SAMD_MKR1000) || defined(ARDUINO_SAMD_MKRWIFI1010) \
      || defined(ARDUINO_SAMD_NANO_33_IOT) || defined(ARDUINO_SAMD_MKRFox1200) || defined(ARDUINO_SAMD_MKRWAN1300) || defined(ARDUINO_SAMD_MKRWAN1310) \
      || defined(ARDUINO_SAMD_MKRGSM1400) || defined(ARDUINO_SAMD_MKRNB1500) || defined(ARDUINO_SAMD_MKRVIDOR4000) \
      || defined(ARDUINO_SAMD_CIRCUITPLAYGROUND_EXPRESS) || defined(__SAMD51__) || defined(__SAMD51J20A__) \
      || defined(__SAMD51J19A__) || defined(__SAMD51G19A__) || defined(__SAMD51P19A__)  \
      || defined(__SAMD21E15A__) || defined(__SAMD21E16A__) || defined(__SAMD21E17A__) || defined(__SAMD21E18A__) \
      || defined(__SAMD21G15A__) || defined(__SAMD21G16A__) || defined(__SAMD21G17A__) || defined(__SAMD21G18A__) \
      || defined(__SAMD21J15A__) || defined(__SAMD21J16A__) || defined(__SAMD21J17A__) || defined(__SAMD21J18A__) )
  #error This code is designed to run on SAMD21/SAMD51 platform! Please check your Tools->Board setting.
#endif

// Disable timer library logging & debugging
#define TIMER_INTERRUPT_DEBUG         (0)
#define _TIMERINTERRUPT_LOGLEVEL_     (0)

// Select only one to be true for SAMD21. Must must be placed at the beginning before #include "SAMDTimerInterrupt.h"
#define USING_TIMER_TC3         true      // Only TC3 can be used for SAMD51
#define USING_TIMER_TC4         false     // Not to use with Servo library
#define USING_TIMER_TC5         false
#define USING_TIMER_TCC         false
#define USING_TIMER_TCC1        false
#define USING_TIMER_TCC2        false     // Don't use this, can crash on some boards

#define SELECTED_TIMER TIMER_TC3

#include "SAMDTimerInterrupt.h"
#include "SAMD_ISR_Timer.h"

#define HW_TIMER_INTERVAL_MS (10)
#define TIMER_INTERVAL_1S    (1000L)

SAMDTimer timer(SELECTED_TIMER);

SAMD_ISR_Timer isrTimer;

void timerHandler(){
  isrTimer.run();
}

// NOTE: Don't do anything too heavey inside the ISR, try to enter and exit it as fast as possible. 
void switchLED(){
  digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
}

void setup() {
  Serial.begin(115200);
  while (!Serial);

  pinMode(LED_BUILTIN, OUTPUT);

  if (timer.attachInterruptInterval_MS(HW_TIMER_INTERVAL_MS, timerHandler)) {
    Serial.println("Starting timer OK");
  } else {
    Serial.println("Failed to set timer...");
    while(1);
  }

  isrTimer.setInterval(TIMER_INTERVAL_1S, switchLED);
}

void loop() {
  // Nothing to do, everything is handled by hardware
}
```

## License and credits

This core has been developed by Arduino LLC in collaboration with Atmel.

```
  Copyright (c) 2015 Arduino LLC.  All right reserved.

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
```
