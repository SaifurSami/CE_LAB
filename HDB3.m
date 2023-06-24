clc;
close all;
clear all;

bits = [1,1,1,1,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,1]; 

bitrate = 1;
voltage = 5;
lastNonZero = -voltage;
cnt = 0;
NonZeroPulse = 0;

T = length(bits)/bitrate; %total time for bit sequence
n = 200; %sample per bit
N = n * T; %total sample
dt = T / N; %sampling time
t = 0:dt:T-dt; %every time instance
y = zeros(1,length(t)); %output signal


%modulation
for i = 1 : length(bits)
  if(bits(i) == 0)
    cnt++;
  else
    cnt = 0;
    NonZeroPulse++;
    y((i - 1) * n + 1 : i * n) = -lastNonZero;
    lastNonZero = -lastNonZero;
  endif
  
  if(cnt == 4 && rem(NonZeroPulse,2) == 0)
    y((i - 4) * n + 1 : (i - 3) * n) = -lastNonZero;
    lastNonZero = -lastNonZero;
    y((i - 1) * n + 1 : i * n) = lastNonZero;
    cnt = 0;
    NonZeroPulse += 2;
  elseif(cnt == 4)
    y((i - 1) * n + 1 : i * n) = lastNonZero;
    cnt = 0;
    NonZeroPulse++;
  endif
endfor

%disp("FUCK");
plot(t,y,'LineWidth',2);
axis([0 T -voltage-1 voltage+1]);
grid on;
title(['B8ZS : [' num2str(bits) ']']);

%demodulation
lastNonZero = -voltage;
NonZeroPulse = 0;

for i = 1 : length(t)
  if(rem(i,n) == 0 && y(i) == 0)
      receiving_bits(i / n) = 0;
    elseif(rem(i,n) == 0 && y(i) == lastNonZero) 
      receiving_bits(i / n) = 0;
      receiving_bits((i / n) - 3) = 0;
    elseif(rem(i,n) == 0 && y(i) == -lastNonZero) 
      receiving_bits(i / n) = 1;
      lastNonZero = -lastNonZero;   
  endif
endfor
disp("HDB3 Decoding : ");
%receiving_bits = bits();
disp(receiving_bits);
