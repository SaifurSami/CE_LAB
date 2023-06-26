%https://www.youtube.com/watch?v=YnLSACNxcqY
clc;
close all;
clear all;

am = 2;
ac = 3;
fm = 1;
fc = 10;
fs = fc * 100;
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
ka = am / ac; %amplitude sensitivity of AM
st1 = (1+ka.*mt).* ct;
%st1 = ammod(mt,fc,fs); %using builtin function for modulation

subplot(413);
plot(t,st1,t,(ac+mt),t,(-ac-mt)); %with envalope
xlabel("Time");
ylabel("Amplitude");
title("Amplitude Modulation with Envalope");
line([0 T],[0 0],"linestyle","--","color","r");

%Amplitude Demodulation
st2 = (1 / pi) * (ac + mt); %demodulation
%st2 = amdemod(st1,fc,fs); %using builtin function for demodulation

subplot(414);
plot(t,st2,t,mt,"g");%compairing demodulated signal with modulating signal
xlabel("Time");
ylabel("Amplitude");
title("Amplitude Demodulated Signal");
line([0 T],[0 0],"linestyle","--","color","r");

##Formulas
##modulation = [1 + k.* m(t)].* c(t)
##demodulation = (1 / pi) * (ac + mt);
##Here,
##k = ratio of message amplitude & carrire amplitude = am/ac
##m(t) = message/modulating signal
##c(t) = carrire signal
##ac = carrire amplitude

%NB:either use builtin function for both modulation & demodulation or don't use them at all.
% Otherwhise accuracy drops.