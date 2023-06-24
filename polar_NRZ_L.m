clc;
close all;
clear all;

bits = [0,1,0,0,1,1,1,0]; 

bitrate = 1;
voltage = 5;

T = length(bits)/bitrate; %total time for bit sequence
n = 200; %sample per bit
N = n * T; %total sample
dt = T / N; %sampling time
t = 0:dt:T-dt; %every time instance
y = zeros(1,length(t)); %output signal

%modulation
for i = 0 : length(bits) - 1
  if(bits(i+1) == 1)
    y(i * n + 1 : (i + 1) * n) = -voltage;
  else
    y(i * n + 1 : (i + 1) * n) = voltage;
  endif
end

plot(t,y,'LineWidth',2);
axis([0 T -voltage-1 voltage+1]);
grid on;
title(['Polar NRZ-L : [' num2str(bits) ']']);

%demodulation
for i = 1 : length(t)
  if(rem(i,n) == 0 && y(i) / voltage == -1)
      receiving_bits(i / n) = 1;
    elseif(rem(i,n) == 0 && y(i) / voltage == 1)
      receiving_bits(i / n) = 0;
  endif
end
disp("Polar NRZ-L Decoding : ");
disp(receiving_bits);
