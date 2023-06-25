%https://www.youtube.com/watch?v=YnLSACNxcqY
clc;
close all;
clear all;

am = 2;
ac = 3;
fm = 1;
fc = 10;
fs = 1000;
T = 5;
t = 0 : 1/fs : T - 1/fs;

%Carrier Signal
ct = ac * sin(2 * pi * fc * t);

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

%Amplitude Modulation
k = am / ac; %amplitude sensitivity of AMI
st1 = (1+k.*mt).* ct;

subplot(413);
plot(t,st1,t,(ac+mt),t,(-ac-mt)); %with envalope
xlabel("Time");
ylabel("Amplitude");
title("Amplitude Modulation with Envalope");
line([0 T],[0 0],"linestyle","--","color","r");

%Amplitude Demodulation
st2 = (1 / pi) * (ac + mt); %demodulation

subplot(414);
plot(t,st2,t,mt);%compairing demodulated signal with modulating signal
xlabel("Time");
ylabel("Amplitude");
title("Demodulated Signal");
line([0 T],[0 0],"linestyle","--","color","r");

##Formula
##modulation = [1 + k.* m(t)].* c(t)
##demodulation = (1 / pi) * (ac + mt);
##k = ratio of message amplitude & carrire amplitude = am/ac
##m(t) = message/modulating signal
##c(t) = carrire signal
##ac = carrire amplitude

  
  



