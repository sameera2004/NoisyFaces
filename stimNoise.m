function stimulus = stimNoise(stimList, stimIndex, trialProp)
% function stimulus = stimNoise(stimFiles, stimIndex, trialProp)

global noiseMatrix
global avgMag
load avgMag
load noiseMatrix

reqmean = 0.5;
contrast = 0.003;   % Variance of image pixel values after normalisation

stimFiles = textread(stimList, '%s');
cd TaskStimuli;
stim = char(stimFiles(stimIndex));
pic = imread(stim);
cd ..

noiseFFT = fftshift(fft2(noiseMatrix));
noiseP = angle(noiseFFT);
pic = double(pic);
picFFT = fftshift(fft2(pic));
picP = angle(picFFT);

noiseLevel = 1-trialProp;   % hack to make noise + FH = 1

stimPhaseToShow = (noiseLevel*noiseP) + (trialProp*picP);

stimToShow = avgMag.*(cos(stimPhaseToShow) + 1i*sin(stimPhaseToShow));
stimFinal = abs(ifft2(stimToShow));

%% Normalise to given values
im = stimFinal - mean(stimFinal(:));
im = im/std(im(:));      % Zero mean, unit std dev
stimulus = reqmean + im*sqrt(contrast);   % Multiply by 1/3 to prepare for RGB

% Make sure pix vals are within bounds
stimulus(find(stimulus > 1)) = 1;
stimulus(find(stimulus < 0)) = 0;
