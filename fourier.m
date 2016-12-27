%load('project1.mat');
SplusN=transpose(reference);
Noise=transpose(primary);
%{
Fs = 21000;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 70000;             % Length of signal
t = (0:L-1)*T;        % Time vector

Y = fft(SplusN);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
%}
x=SplusN
s = spectrogram(x);

spectrogram(x,'yaxis')