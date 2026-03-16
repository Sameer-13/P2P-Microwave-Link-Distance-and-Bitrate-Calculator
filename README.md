# P2P-Microwave-Link-Distance-and-Bitrate-Calculator

This project is a MATLAB tool for analyzing a **point-to-point wireless communication link** between two towers.
It allows users to compute either:

* 📡 **Maximum separation distance between towers** for a target bit rate
* ⚡ **Maximum achievable bit rate** for a given tower separation

The calculations are based on fundamental wireless communication models such as the **Friis transmission equation** and the **Shannon–Hartley theorem**.

---

## Features

* Compute **maximum tower spacing** given a desired data rate
* Compute **maximum achievable bit rate** for a given distance
* Considers **free-space propagation**
* Includes **Earth curvature line-of-sight limitation**
* Calculates **receiver noise power**
* Interactive MATLAB menu interface

---

## System Model

The communication link is modeled using the following parameters:

| Parameter         | Value   | Description                           |
| ----------------- | ------- | ------------------------------------- |
| Carrier Frequency | 5 GHz   | Operating RF frequency                |
| Bandwidth         | 2 MHz   | Communication channel bandwidth       |
| Transmit Power    | 40 W    | Transmitter output power              |
| Antenna Gain      | 20 dB   | Transmitter and receiver antenna gain |
| Tower Height      | 12 m    | Height of each communication tower    |
| Noise Temperature | 10000 K | Receiver noise temperature            |

---

## Key Equations

### Channel Capacity

Based on the **Shannon–Hartley theorem**

[
R = B \log_2(1 + SNR)
]

Where:

* (R) = channel capacity (bit/s)
* (B) = bandwidth
* (SNR) = signal-to-noise ratio

---

### Received Power

Using the **Friis transmission equation**

[
P_r = P_t G_t G_r \left(\frac{\lambda}{4\pi d}\right)^2
]

Where:

* (P_t) = transmitted power
* (P_r) = received power
* (G_t, G_r) = antenna gains
* (d) = distance
* (\lambda) = wavelength

---

### Earth Curvature (Line-of-Sight Limit)

[
d = 3.57(\sqrt{4/3,h_1} + \sqrt{4/3,h_2})
]

Where:

* (h_1, h_2) = tower heights (meters)

---

## Usage

1. Open MATLAB.
2. Run the script.

```matlab
main.M
```

3. Choose an option from the menu:

```
1. Maximum separation between towers (km)
2. Maximum possible bit rate (Mb/s)
```

### Option 1

Enter a **target bit rate**, and the program will compute the **maximum tower spacing**.

### Option 2

Enter a **tower spacing**, and the program will compute the **maximum achievable bit rate**.

---

## Example

Example calculation:

```
Choose a function:
1. Maximum separation between towers d (km)
2. Maximum possible bit rate R (Mb/s)
```

Input:

```
1
Enter target bit rate R (Mb/s): 10
```

Output:

```
Maximum separation between towers = X km
```

---

## Project Structure

```
.
├── main.m
└── README.md
```

Main functions:

* `computeMaxSpacing(R)`
* `computeMaxBitRate(d)`

---

## License

This project is released under the **MIT License**.
