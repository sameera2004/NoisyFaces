function stimulus = stimMerge(stimList, faceStim, houseStim, trialProp, noiseLevel)
% function stimulus = stimMerge(stimList, faceStim, houseStim, trialProp, noiseLevel)

global noiseMatrix
global avgMag
load avgMag
load noiseMatrix
% Load and compute phase matrices for each

reqmean = 0.5;
contrast = 0.003;   % Variance of image pixel values after normalisation

stimFiles = textread(stimList, '%s');
cd TaskStimuli;
faceFile = char(stimFiles(faceStim));
facePic = imread(faceFile);
houseFile = char(stimFiles(houseStim));
housePic = imread(houseFile);
cd ..

noiseFFT = fftshift(fft2(noiseMatrix));
noiseP = angle(noiseFFT);
facePic = double(facePic);
facePicFFT = fftshift(fft2(facePic));
facePicP = angle(facePicFFT);
housePic = double(housePic);
housePicFFT = fftshift(fft2(housePic));
housePicP = angle(housePicFFT);

faceProp = trialProp * (1-noiseLevel);
houseProp = (1-trialProp) * (1-noiseLevel);
stimPhaseToShow = (noiseLevel*noiseP) + (faceProp*facePicP) + (houseProp*housePicP);

stimToShow = avgMag.*(cos(stimPhaseToShow) + 1i*sin(stimPhaseToShow));
stimFinal = abs(ifft2(stimToShow));

%% Normalise to given values
im = stimFinal - mean(stimFinal(:));    
im = im/std(im(:));      % Zero mean, unit std dev
stimulus = reqmean + im*sqrt(contrast);   % Multiply by 1/3 to prepare for RGB

% Make sure pix vals are within bounds
stimulus(find(stimulus > 1)) = 1;
stimulus(find(stimulus < 0)) = 0;
