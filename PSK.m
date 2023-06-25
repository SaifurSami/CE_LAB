clc;
clear all;
close all;

bits = [1 1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 0 1];
disp("Bits : ");
disp(bits);

voltage = 5;
amplitude = 5;
fc = 1;
fs = 200;
bitrate = 1;
T = length(bits) / bitrate;
t = 0 : 1/fs : T - 1/fs;

%Carrier Signal for Zero
carrier0 = amplitude * sin(2 * pi * fc * t);

subplot(4,1,1);
plot(t,carrier0);
xlim([0 T]);
ylim([-amplitude-2 amplitude+2]);
xlabel("Time");
ylabel("Amplitude");
title("Analog Carrier Signal for Zero");
line ([0, T], [0 0], "linestyle","--", "color", "r");
grid on;

%Carrier Signal for One
carrier1 = amplitude * sin(2 * pi * fc * t + 180);

subplot(4,1,2);
plot(t,carrier1);
xlim([0 T]);
ylim([-amplitude-2 amplitude+2]);
xlabel("Time");
ylabel("Amplitude");
title("Analog Carrier Signal for One");
line([0 T],[0 0],"linestyle","--","color","r");
grid on;

%Encoded Digital Signal
y_digital = zeros(1,length(t));

for i = 1 : length(bits)
  from = (i - 1) * fs / bitrate + 1;
  to = i * fs / bitrate;
  if(bits(i) == 1)
    y_digital(from : to) = voltage;
  endif
endfor

subplot(4,1,3);
plot(t,y_digital);
xlim([0 T]);
ylim([-voltage-2 voltage+2]);
xlabel("Time");
ylabel("Voltage");
title(['Encoded Digital Signal : [' num2str(bits) ']']);
line([0 T],[0 0],"linestyle","--","color","r");
grid on;

%PSK Modulation
for i = 1 : length(bits)
  from = (i -1) * fs / bitrate + 1;
  to = i * fs / bitrate;
  if(bits(i) == 1)
    psk(from : to) = carrier1(from : to);
  else
    psk(from : to) = carrier0(from : to);
  endif
endfor

subplot(4,1,4);
plot(t,psk);
xlim([0 T]);
ylim([-amplitude-2 amplitude+2]);
xlabel("Time");
ylabel("Amplitude");
title("Phase Shift Keying");
line([0 T],[0 0],"linestyle","--","color","r");
grid on;

%PSK Demodulation
data = zeros(1,length(bits));

for i = 1 : length(t)
  if(rem(i,fs) == 0 && psk(i) == carrier1(i))
    data(i / fs) = 1;
  endif
endfor

disp("PSK Decoding : ");
disp(data);