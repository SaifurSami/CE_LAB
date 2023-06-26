%https://www.youtube.com/watch?v=N-cgugyTXW8
clc;
clear all;
close all;

am = 1;
fm = 1;
ac = 1;
fc = 15; %must be greater than modulating frequency fm

fs = fc * 100; %sampling frequency
T = 5; %total time
t = 0 : 1 / fs : T - 1 / fs;

%Carrier Signal
ct = ac * sin(2 * pi * fc * t);

subplot(411);
plot(t,ct);
xlabel("Time");
ylabel("Amplitude");
title("Analog Carrier Signal");
line([0 T],[0 0],"linestyle","--","color","r");

%Modulating Signal
mt = am * cos(2 * pi * fm * t); %cos funtion must be used otherwise 90 degree phase will be different

subplot(412);
plot(t,mt);
xlabel("Time");
ylabel("Amplitude");
title("Analog Modulating Signal");
line([0 T],[0 0],"linestyle","--","color","r");

%Frequency Modulation
kf = fc / ac; %frequency sensitivity of frequency modulator(not sure about this equation tho :3)
df = kf * am; %frequency deviation
B = df / fm; %modulation index

st1 = ac * sin(2 * pi * fc * t + (B.*sin(2 * pi * fm * t)));
%st1 = fmmod(mt,fc,fs,df);%using builtin function for modulation

subplot(413);
plot(t,st1);
xlabel("Time");
ylabel("Amplitude");
title("Frequency Modulated Signal");
line([0 T],[0 0],"linestyle","--","color","r");

%Frequency Demodulation
x = diff(st1);
y = abs(x);
[b,a] = butter(10,0.13); % second parameter's range = (0,1);no idea about the first one :3
st2 = filter(b,a,y);
%st2 = fmdemod(st1,fc,fs); %using builtin function for demodulation

subplot(414);
plot(st2);
xlabel("Time");
ylabel("Amplitude");
title("Frequency Demodulated Signal");
line([0 T],[0 0],"linestyle","--","color","r");

##Formulas
##modulation = ac*sin(2*pi*fc*t+(B.*sin(2*pi*fm*t)))
##demodulation in 4 steps
##1.x = diff(st1)
##2.y = abs(x)
##3.[b,a] = butter(10,0.13); here values can differ 
##4.st2 = filter(b,a,y)
##Here,
##st1 = modulated signal
##st2 = demodulated signal
##m(t) = message/modulating signal = am*cos(2*pi*fm*t); not sin 
##c(t) = carrire signal = ac*sin(2*pi*fc*t)
##kf = ratio of carrire frequency & carrire amplitude = fc/ac
##df = frequency deviation = kf*am
##B(beta) = modulation index = df/fm = (fc/fm)*(am/ac)
