clc
clear all
close all

%****************************
%
%Filename: Distortion.m
%
%Author: Brett Garberman
%Created: February 6th, 2019
%MATLAB R2016a
%
%****************************
%
%Description: Implements a distortion effect on the sample
%given by the audioread() function.
%
%Distortion algorithm designed by Cheng-Hao Chang, 2011
%https://ses.library.usyd.edu.au/bitstream/2123/7624/2/DESC9115_DAS_Assign02_310106370.pdf
%
%****************************

%Input Parameters

%Boost: Input signal rescaling. Results in a signal multplied by (1+boost).
%Drive: Increases harmonic distortion. Range (0, 100)
%Tone: Controls second order butterworth filter
%y: The audio input (16 bit expected)
%Fs: Audio sampling rate (44100 expected)

boost = 0;
drive = 90;
tone = 50;

[y,Fs] = audioread('sample.wav');

%****************************

%Signal chain setup

gain = ((boost/100)*100)+1;

a = sin(((drive+1)/101)*(pi/2))
k = 2*a/(1-a);

%****************************

%Signal Chain

y_gain = y*gain;
y_tone = (1+k)*(y_gain)./(1+k*abs(y_gain));
out = distfftfilter(y_tone, tone, Fs);

%****************************

%Visualization

samplesIn = [1:length(y)];
samplesOut = [1:length(out)];

figure

subplot(4,1,1);
plot(samplesIn, y);
title('IN');

subplot(4,1,2);
plot(samplesOut, y_gain);
title('BOOST');

subplot(4,1,3);
plot(samplesOut, y_tone);
title('DISTORTED');

subplot(4,1,4);
plot(samplesOut, out);
title('OUT');

%****************************

%Playback

playerIn = audioplayer(y, Fs)
play(playerIn)

pause(length(samplesIn)/Fs + 1)

playerOut = audioplayer(out,Fs)
play(playerOut)






