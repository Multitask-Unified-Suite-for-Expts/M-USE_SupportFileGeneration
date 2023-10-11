function [blockdef, stimDef] = get_continuousRecognitionBlock_01(cfg_CR)

iFeedbackLocations_X = [-2:1:2];
iFeedbackLocations_Y = [1.8:-0.9:-1.8];

iStimLocations_X = -2.3750:0.95:2.375; %[-2.3750, -1.4250, -0.4750,  0.4750,  1.4250,  2.3750]
iStimLocations_Y = -1.4:0.7:1.4; % -1.4000   -0.7000         0    0.7000    1.4000


%blockdef_HeaderString = sprintf('BlockName\tContextName\tTotalTokensNum\tNumRewardPulses\tBlockStimIndices\tNumObjectsMinMax\tInitialStimRatio\tDisplayStimsDuration\tChooseStimDuration\tTrialEndDuration\tTouchFeedbackDuration\tDisplayResultDuration\tTokenUpdateDuration\tTokenRevealDuration\tBlockFeedbackLocations\tNumRows\tNumColumns\tX_Start\tY_Start\tX_Gap\tY_Gap\tSubsetFeedbackLocations');
blockdef = [];

stimDef = [];
stimDef.StimValues = [];
stimDef.StimName = {};
stimDef.StimCode = [];

% for each block get the quaddles
for iBL = 1:length(cfg_CR.blockconditionName)

    nDimensions = 4;
    % --- which feature dimensions are used ?
    iDims = zeros(4,1); tmp = randperm(4); iDims(tmp(1:nDimensions)) = 1;
    % --- choose randomly features values for each dimenion
    featD1 = randperm(cfg_CR.nFeaturesPerDim);
    featD2 = randperm(cfg_CR.nFeaturesPerDim);
    featD3 = randperm(cfg_CR.nFeaturesPerDim);
    featD4 = randperm(cfg_CR.nFeaturesPerDim); %nFeaturesPerDim

    dimIdx = find(iDims);

    % --- select maxStimPerSet objects.
    %nObjects = cfg_CR.numObjectsMinMax{iBL};
    StimValues = zeros(cfg_CR.nObjects{iBL},4);
    for iO=1:cfg_CR.nObjects{iBL}
        featD1 = randperm(8);
        featD2 = randperm(8);
        featD3 = randperm(8);
        featD4 = randperm(8);
        iStimValues(iO,:) = [featD1(1), featD2(1), featD3(1), featD4(1)];
    end
    blockStimIndices = length(stimDef.StimValues)+1:(length(stimDef.StimValues)+1+length(iStimValues));
    stimDef.StimCode = cat(1,stimDef.StimCode,blockStimIndices);
    stimDef.StimValues = cat(1,stimDef.StimValues,iStimValues);


    % = 'Dirt'; %
    %xLocations          = [-2.55:0.85:2.55]; %
    %yLocations          = [-1.5:0.7:1.5]; %


    blockdef(iBL).BlockName          = cfg_CR.blockconditionName{iBL};
    blockdef(iBL).FindAllStim          = cfg_CR.FindAllStim;
    blockdef(iBL).ManuallySpecifyLocation  = 'FALSE';
    blockdef(iBL).StimFacingCamera         = 'TRUE';

    blockdef(iBL).ContextName        = cfg_CR.contextName{iBL}
    blockdef(iBL).NumTokenBar	    = sprintf('%s', cfg_CR.numTokens(iBL));
    blockdef(iBL).NumRewardPulses	= sprintf('%s', cfg_CR.NumRewardPulses);
    blockdef(iBL).PulseSize	= sprintf('%s', cfg_CR.PulseSize);
    blockdef(iBL).RewardMag	= sprintf('%s', cfg_CR.RewardMag);

    tmp = sprintf('%d, ',blockStimIndices);
    blockdef(iBL).BlockStimIndices = sprintf('[%s]',tmp(1:end-2));
    blockdef(iBL).NumObjectsMinMax = sprintf('[%d, %d]',cfg_CR.numObjectsMinMax{iBL}(1:2)) ;%[2, 18]
    blockdef(iBL).InitialStimRatio = sprintf('[%d, %d, %d]',cfg_CR.stimulusRatio{iBL}(1:3));
    blockdef(iBL).DisplayStimsDuration = sprintf('%s', 0.2);
    blockdef(iBL).ChooseStimDuration = sprintf('%s', cfg_CR.ChooseStimDuration);
    blockdef(iBL).TrialEndDuration = sprintf('%s', cfg_CR.TrialEndDuration);
    blockdef(iBL).TouchFeedbackDuration = sprintf('%s', cfg_CR.TouchFeedbackDuration) ;
    blockdef(iBL).DisplayResultDuration = '2';
    blockdef(iBL).TokenUpdateDuration	= sprintf('%s', cfg_CR.TokenUpdateDuration);
    blockdef(iBL).TokenRevealDuration	= sprintf('%s', cfg_CR.TokenRevealDuration);
    blockdef(iBL).BlockStimLocations	= '[]';

    tmp = sprintf('%.3f, ',iStimLocations_X); tmp(end-2:end) = [];    
    blockdef(iBL).X_Locations = ['[' tmp ']']; 
    tmp = sprintf('%.3f, ',iStimLocations_Y); tmp(end-2:end) = [];    
    blockdef(iBL).Y_Locations = ['[' tmp ']']; 

    tmp = sprintf('%.1f, ',iFeedbackLocations_X); tmp(end-2:end) = [];    
    blockdef(iBL).X_FbLocations = ['[' tmp ']']; 	
    tmp = sprintf('%.1f, ',iFeedbackLocations_Y); tmp(end-2:end) = [];    
    blockdef(iBL).Y_FbLocations	= ['[' tmp ']']; 	
    
    %blockdef(iBL).NumRows	= '6';
    %blockdef(iBL).NumColumns = '6';
    %blockdef(iBL).X_Start	= '-2.55';
    %blockdef(iBL).Y_Start = '1.5';
    %blockdef(iBL).X_Gap = '0.85';
    %blockdef(iBL).Y_Gap = '0.7';
    % SubsetFeedbackLocations = []; % not needed... remove...

end

sprintf('done with blockdef\n'),
return
