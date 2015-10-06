# NoisyFaces
Stimuli and code for creating noisy face/house stimuli for psychophysics experiments

There are 20 houses and 20 faces (10 male, 10 female), plus additional cropped, grayscale versions with the _C suffix. In my experiments I've used 10 of each which are listed in stimuli.txt. The faces are adapted from the Karolinska Directed Emotional Face set; full references and further information can be found in the methods of this paper http://www.stevefleming.org/storage/Journal%20of%20Neurophysiology%202010%20Fleming.pdf 
The house set were photographed by me in Hackney, London :)

We have used these files in two different ways in psychophysics experiments. In Fleming et al. 2010 J Neurophys we created merged versions of two image files, one face and one house, plus a variable proportion of a constant white noise matrix. In Fleming et al. 2012 J Neuro we created single images 

To create the merged image matrices you can call stimMerge as follows:

stimulus = stimNoise(‘stimuli.txt’, faceStimIndex, houseStimIndex, trialProp, noiseLevel)

where faceStimIndex/houseStimIndex is the index of the face/house in stimuli.txt; trialProp is the proportion of face/house you want on this trial (0-1), noiseLevel is a parameter controlling the proportion of noise added to the final stimulus (we used 0.35 in the 2010 paper).

Creating the single image stimulus is similar except the noise level is automatically set to 1-trialProp, and there is only a single stimIndex:

stimulus = stimNoise(‘stimuli.txt’, stimIndex, trialProp)

avgMag.mat and noiseMatrix.mat need to be in the current directory

You can check the created image with:
colormap gray
imagesc(stimulus)

Steve Fleming stephen.fleming@ucl.ac.uk 
