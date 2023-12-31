clc;
clear all;
close all;

bits = [1 1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 0 1];
disp("Bits : ");
disp(bits);

voltage = 5;
am = 5;
fm = 5;
fs = 200;
bitrate = 1;
T = length(bits) / bitrate;
t = 0 : 1/fs : T - 1/fs;

%Analog Carrier Signal
x_analog = am * sin(2*pi*fm*t);

subplot(3,1,1);
plot(t,x_analog);
xlim([0 T]);
ylim([-voltage-2 voltage+2]);
title("Analog Carrier Signal");
line([0 T],[0 0],"linestyle","--","color","r");
grid on;


%Encoded Digital Signal
x_digital = zeros(1,length(t));

for i = 1 : length(bits)
  from = (i - 1) * fs / bitrate + 1;
  to = i * fs / bitrate;
  if(bits(i) == 1)
    x_digital(from : to) = voltage;
  else
    x_digital(from : to) = 0;
  endif
endfor

subplot(3,1,2);
plot(t,x_digital);
xlim([0 T]);
ylim([-voltage-2 voltage+2]);
title(['Encoded Digital Signal : [' num2str(bits) ']']);
line([0 T],[0 0],"linestyle","--","color","r");
grid on;

%ASK Modulation
for i = 1 : length(t)
  if(x_digital(i) == voltage)
    ask(i) = x_analog(i);
  endif
endfor

subplot(3,1,3);
plot(t,ask);
xlim([0 T]);
ylim([-voltage-2 voltage+2]);
title("Amplitude Shift Keying");
line([0 T],[0 0],"linestyle","--","color","r");
grid on;

%ASK Demodulation
data = zeros(1,length(bits));

for i = 1 : length(t)
  if(rem(i,fs) == 0 && ask(i) != 0)
    data(i / fs) = 1;
  endif
endfor

disp("ASK Decoding : ");
disp(data);