clc;
close all;
clear all;

bits = [1,1,0,0,1,0,1,1,1,0]; 

bitrate = 1;
voltage = 5;
temp = voltage;

T = length(bits)/bitrate; %total time for bit sequence
n = 200; %sample per bit
N = n * T; %total sample
dt = T / N; %sampling time
t = 0:dt:T-dt; %every time instance
y = zeros(1,length(t)); %output signal

%modulation
for i = 0 : length(bits) - 1
  if(bits(i+1) == 1)
    voltage = voltage * (-1);
    y(i * n + 1 : (i + 1) * n) = voltage;
  else
    y(i * n + 1 : (i + 1) * n) = voltage;
  endif
end

plot(t,y,'LineWidth',2);
axis([0 T -temp-1 temp+1]);
grid on;
title(['Polar NRZ-I : [' num2str(bits) ']']);

%demodulation
for i = 1 : length(t)
  if(rem(i,n) == 0 && y(i) == temp)
    receiving_bits(i / n) = 0;
    elseif(rem(i,n) == 0 && y(i) == -temp)
    receiving_bits(i / n) = 1;
    temp = -temp;
  endif
end
disp("Polar NRZ-I Decoding : ");
disp(receiving_bits);
