clc;
close all;
clear all;

bits = [0,1,0,1,1,0,1,1]; %8

bitrate = 1;
voltage = 5;
temp = 0;
lastLevel = 0;

T = length(bits)/bitrate; %total time for bit sequence
n = 200; %sample per bit
N = n * T; %total sample
dt = T / N; %sampling time
t = 0:dt:T-dt; %every time instance
y = zeros(1,length(t)); %output signal

%modulation
for i = 0 : length(bits) - 1
  if(bits(i+1) == 1)
    temp++;
    if(rem(temp,4) == 1)
    y(i * n + 1 : (i + 1) * n) = voltage;
    lastLevel = voltage;
    elseif(rem(temp,4) == 3)
    y(i * n + 1 : (i + 1) * n) = -voltage;
    lastLevel = -voltage;
    else
    y(i * n + 1 : (i + 1) * n) = 0;
    lastLevel = 0;
    endif
  else
    y(i * n + 1 : (i + 1) * n) = lastLevel;
  endif
end

plot(t,y,'LineWidth',2);
axis([0 T -voltage-1 voltage+1]);
grid on;
title(['MLT-3 : [' num2str(bits) ']']);

%demodulation
lastLevel = 0;
for i = 1 : length(t)
  if(rem(i,n) == 0 && y(i) == lastLevel)
      receiving_bits(i / n) = 0;
    elseif(rem(i,n) == 0)
      receiving_bits(i / n) = 1;
      lastLevel = y(i);
  endif
end
%disp("OK DUCK");
disp(receiving_bits);
