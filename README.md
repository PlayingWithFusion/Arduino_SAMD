<p align="center">
  <img src="https://github.com/PlayingWithFusion/Arduino_SAMD/assets/77081880/05cc5ad2-8b62-4e97-ac00-dcc4c4118d5d" />
</p>

<h1 align="center">Playing With Fusion R3aktor Board Support Package</h1>

This repository contains the board support packages for all "R3aktor core" Arduino-compatible boards based specifically on the SAMD21 family of MCUs from Microchip. 

# Boards

- [R3aktor M0 Logger](https://playingwithfusion.com/productview.php?pdid=157)
- R3aktor TC Logger (Coming Soon!)
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
