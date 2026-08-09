## How it works

GlassChip V0 is an always-on wake controller for smart glasses.

It monitors three event inputs:

- ui_in[0]: IMU event
- ui_in[1]: Button event
- ui_in[2]: Voice or AI wake event

When an event is detected, the chip generates a wake signal on uo_out[0].

uo_out[1] indicates an event pulse.

uo_out[7:4] contains a 4-bit event counter.

## How to test

1. Drive rst_n low, then high to reset the chip.
2. Pulse ui_in[0] to simulate an IMU event.
3. Verify that uo_out[0] becomes high.
4. Pulse ui_in[1] to simulate a button event.
5. Pulse ui_in[2] to simulate a voice wake event.
6. After three events, uo_out[7:4] should equal 3.

## External hardware

No external hardware is required for simulation.
