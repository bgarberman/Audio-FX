function [filteredwave] = distfftfilter(wave, tone, Fs);
filterfrequency = ((Fs-2000)/2)*sin((tone/101)*(pi/2))+1000;
fNorm = filterfrequency/(Fs/2);
[b,a] = butter(2, fNorm, 'low');
filteredwave = filtfilt(b, a, wave);
end