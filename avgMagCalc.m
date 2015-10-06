clear all
warning off
cd TaskStimuli
stimFiles = textread('stimuli.txt','%s');
for k = 1:length(stimFiles);
     file = char(stimFiles(k));
     pic = imread(file);
     allpics(:,:,k) = double(pic);       
 end
 cd ..

% Get phase/mag matrices
allpicsFFT = fftshift(fft2(allpics));
allpicsM = abs(allpicsFFT);
avgMag = mean(allpicsM,3);
allpicsP = angle(allpicsFFT);
save avgMag -V6 avgMag;

noiseMatrix = rand(size(avgMag));
save noiseMatrix -V6 noiseMatrix