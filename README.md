# CanSat2019_GS
Ground station software for the CanSat competition.

Reads csv data from serial port and plots it. The data has a predefined structure (the ground station is communicating with a known satellite, also developed by the team). 

The script can interpret the data in live mode (taking derivatives of already received data, this is based on an expected flight path and predefined mission sequence).

The script can transmit a telecommand, which initiates operation of the satellite (a simple transmission of a code-word via the serial port, the satellite is programmed to listen for it while in idle mode).

P.S. Communication is achieved using an antenna connected to a serial port (the exact port must be defined within the script).
