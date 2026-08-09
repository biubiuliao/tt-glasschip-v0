<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

Explain how your project works

## How to test

Explain how to use your project

## External hardware

List external hardware used in your project (e.g. PMOD, LED display, etc), if any

## How it works

GlassChip V0 is an always-on wake controller for smart glasses.

- ui_in[0]: IMU event
- ui_in[1]: button event
- ui_in[2]: voice/AI wake event
- uo_out[0]: wake signal for the main SoC
- uo_out[1]: event pulse
- uo_out[7:4]: 4-bit event counter

External events are synchronized to the chip clock. A rising edge triggers the wake output, which remains active for a fixed number of clock cycles.

## How to test

1. Reset the design by driving rst_n low, then high.
2. Pulse ui_in[0] to simulate an IMU event.
3. Check that uo_out[0] goes high.
4. Repeat with ui_in[1] for a button event.
5. Repeat with ui_in[2] for a voice/AI wake event.
6. After three events, uo_out[7:4] should contain the value 3.
