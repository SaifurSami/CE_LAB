clc;
close all;
clear all;

bits = [0,1,0,0,1]; %5

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
    y(i * n + 1 : (i + 0.5) * n) = voltage;
    y((i + 0.5) * n + 1 : (i + 1) * n) = 0;
  else
    y(i * n + 1 : (i + 0.5) * n) = -voltage;
    y((i + 0.5) * n + 1 : (i + 1) * n) = 0;
  endif
end

plot(t,y,'LineWidth',2);
axis([0 T -voltage-1 voltage+1]);
grid on;
title(['Polar RZ : [' num2str(bits) ']']);

%demodulation
for i = 1 : length(t)
  if(rem(i,n) == 0 && y(i - n * 0.5) == voltage)
    receiving_bits(i / n) = 1;
    elseif(rem(i,n) == 0 && y(i - n * 0.5) == -voltage)
    receiving_bits(i / n) = 0;
  endif
end
%disp("OK DUCK");
disp(receiving_bits);
