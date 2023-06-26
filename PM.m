clc;
clear all;
close all;

am = 1;
fm = 1;
ac = 1;
fc = 5;
kp = pi/2; %phase sensitivity modulator

fs = fc * 100;
T = 5;
t = 0 : 1 / fs : T - 1 / fs;

%Carrier Signal
ct = ac * cos(2 * pi * fc * t);

subplot(411);
plot(t,ct);
xlabel("Time");
ylabel("Amplitude");
title("Analog Carrier Signal");
line([0 T],[0 0],"linestyle","--","color","r");

%Modulating Signal
mt = am * sin(2 * pi * fm * t); 

subplot(412);
plot(t,mt);
xlabel("Time");
ylabel("Amplitude");
title("Analog Modulating Signal");
line([0 T],[0 0],"linestyle","--","color","r");

%Phase Modulation
st1 = ac * cos(2 * pi * fc * t + (kp.*mt));

subplot(413);
plot(t,st1);
xlabel("Time");
ylabel("Amplitude");
title("Phase Modulated Signal");
line([0 T],[0 0],"linestyle","--","color","r");

%Phase Demodulation
x = diff(st1);
y = abs(x);
[b,a] = butter(10,0.13);
st2 = filter(b,a,y);

subplot(414);
plot(st2);
xlabel("Time");
ylabel("Amplitude");
title("Phase Demodulated Signal");
line([0 T],[0 0],"linestyle","--","color","r");


