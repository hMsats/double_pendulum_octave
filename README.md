# double_pendulum_octave
Swinging double pendulum in Octave (open source version of Matlab)

In octave just type: `dp` to start.

It will first calculate the time delay necessary to make the pendulum swing in realtime.

Then press any key to start the pendulum. On Linux you end the program by typing crtl c.

It uses fourth order Runge-Kutta on the solution of the Hamilton-Lagrange equations.
The pendulum is plotted via `plot` in Octave.

Parameters can easily be changed at the top of dp.m. 
It's a lot of fun to set both `TH10` and `TH20` to 180 degrees.
This gives a vertical double pendulum which should be stable in theory but in practice begins to fall after about a minute due to the finite accuracy of the simulation.
