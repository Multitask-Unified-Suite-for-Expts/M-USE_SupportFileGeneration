function [cfg] = make_FlexLearning_configs_01(cfg,iExpName)
% --- this script generates the Set shifting "FlexLearningGainLoss" task
% --- it varies for 2D
if nargin < 2, iExpName = []; end

if ~isfield(cfg, 'externalStimFolderPath_Quaddle1' )
    cfg.externalStimFolderPath_Quaddle1 = '"C:\\Users\\Womelsdorf Lab\\Desktop\\QuaddleRepository_20180515"'
end
if isempty(cfg)
    cfg.iSet = 1;
    cfg.isWebGL = 0;
end
if isempty(iExpName),
    iExpName = 'FlexLearning'
end
if ~isfield(cfg, 'isWebGL')
    cfg.isWebGL = 0;
end

% cfg.contextRepositoryFolderPath = [pwd filesep 'ContextRepository_20221206/'];
% cfg.contexts                    = get_contextNames_01(cfg.contextRepositoryFolderPath)
[a,typeID,c] = intersect(cfg.contexts.types,'Copper');
context_idx = find(cfg.contexts.typeID==typeID);
iContextName = cfg.contexts.name{context_idx(randi(length(context_idx)))};

% default is 36 blocks
nBlocks = 36;
if isfield(cfg,'fl_nBlocks'),
    nBlocks = cfg.fl_nBlocks;
end
numTrials_minMax = [32 50];
if isfield(cfg,'flexLearning_numTrials_minMax'),
    numTrials_minMax = cfg.fl_numTrials_minMax;
end

nDimensions         = 2; % 3;
numTokens           = 8;
numInitialTokens    = 3;
NumRewardPulses     = 3;
RewardPulseSize     = 250;
BlockEndWindow      = 5;
BlockEndThreshold   = 0.8;

iEccentricity       = 6.0; %5.5;
nFeaturesPerDim     = 3; % best to be equal to num_Quaddles_per_trial


cfg.out_flexLearning = [];
cfg.out_flexLearning.experimentName = [];
cfg.out_flexLearning.taskFolderName = [];
cfg.out_flexLearning.iPath = [];

if ~exist(cfg.sessionPathName), mkdir(cfg.sessionPathName), end

cfg.out_flexLearning.experimentName =  sprintf('%s_IDED_2G2L_%dD_v01_Set%.2d',iExpName,nDimensions,cfg.iSet);
% task folder has to be the same
cfg.out_flexLearning.taskFolderName = cfg.out_flexLearning.experimentName;
% cfg.out_flexLearning.taskFolderName = sprintf('%s_Set_%.2d',cfg.out_flexLearning.experimentName,cfg.iSet);

cfg.out_flexLearning.iPath = [cfg.sessionPathName '/' cfg.out_flexLearning.taskFolderName '/'];

%iPath = [ cfg.sessionPathName cfg.out_flexLearning.taskFolderName];
if ~exist(cfg.out_flexLearning.iPath), mkdir(cfg.out_flexLearning.iPath), end



% --- --- --- --- --- --- --- --- ---
% --- Quaddle info's: Feature Dimensions and values
% --- --- --- --- --- --- --- --- ---
Q1 = [];
Q1.shapes = {'S01', 'S02', 'S03', 'S04', 'S05', 'S06', 'S07', 'S08', 'S09'};
Q1.patterns = {'P01', 'P02', 'P03', 'P04', 'P05', 'P06', 'P07', 'P08', 'P09'};
%  patternless_colors = {'C6070014_6070014', 'C6070059_6070059', 'C6070106_6070106', 'C6070148_6070148', 'C6070194_6070194', 'C6070287_6070287', 'C6070335_6070335','C6070240_6070240'};
Q1.patternless_colors = {'C6070014_6070014', 'C6070059_6070059', 'C6070106_6070106', 'C6070148_6070148', 'C6070194_6070194', 'C6070239_6070239', 'C6070287_6070287', 'C6070335_6070335'};%patternless C70: C7070240_7070240
Q1.patterned_colors =   {'C7070014_5000000', 'C7070059_5000000', 'C7070106_5000000', 'C7070148_5000000', 'C7070194_5000000', 'C7070240_5000000', 'C7070286_5000000', 'C7070335_5000000'};
Q1.gray_pattern_color = 'C7000000_5000000';
Q1.arms = {'A00_E01', 'A00_E02', 'A00_E03', 'A01_E00', 'A01_E01', 'A01_E02', 'A01_E03', 'A02_E00', 'A02_E01', 'A02_E02', 'A02_E03'};
% enforce same number of dimensions
% dimensionFeatureMapping = [1:8 1:8 1:8 1:8];
iMin = min([length(Q1.shapes) length(Q1.patterns) length(Q1.patternless_colors) length(Q1.arms) ]);
%dimensionFeatures = [length(Q1.shapes) length(Q1.patterns) length(Q1.patternless_colors) length(Q1.arms) ];
dimensionFeatures = [iMin iMin iMin iMin];

allLocationPossibilities =  get_locationsEquiEccentric_02(iEccentricity);


% --- --- --- --- --- --- --- --- ---
% --- initialize block information
% --- --- --- --- --- --- --- --- ---

blockdata = [];
blockdata.blockname = {};
blockdata.sequencetoken = [];
blockdata.sequenceEDID = [];
blockdata.stimValues = {};
blockdata.stimValuesIsTarget = {};
blockdata.stimNames = {};
blockdata.blockname ={};
blockdata.blocknum = [];
blockdata.minmaxtrials = [];
blockdata.numTokens = [];
blockdata.numInitialTokens = [];

%blockdata.NumPulses = [];
blockdata.PulseReward = [];
blockdata.PulseSize = [];
blockdata.BlockEndType	 = {};
blockdata.BlockEndWindow = [];
blockdata.BlockEndThreshold = [];

% --- --- --- --- --- --- --- --- ---
% --- specify token conditions
% --- --- --- --- --- --- --- --- ---

tokenCondition = [];
iCnd = 1;
tokenCondition{iCnd}.numInitialTokens = 2;
tokenCondition{iCnd}.TokenGain = 4;
tokenCondition{iCnd}.TokenLoss = -1;
tokenCondition{iCnd}.name = 'g4l1';
iCnd = 2;
tokenCondition{iCnd}.numInitialTokens = 2;
tokenCondition{iCnd}.TokenGain = 4;
tokenCondition{iCnd}.TokenLoss = -3;
tokenCondition{iCnd}.name = 'g4l3';
iCnd = 3;
tokenCondition{iCnd}.numInitialTokens = 2;
tokenCondition{iCnd}.TokenGain = 2;
tokenCondition{iCnd}.TokenLoss = -1;
tokenCondition{iCnd}.name = 'g2l1';
iCnd = 4;
tokenCondition{iCnd}.numInitialTokens = 2;
tokenCondition{iCnd}.TokenGain = 2;
tokenCondition{iCnd}.TokenLoss = -3;
tokenCondition{iCnd}.name = 'g2l3';


% --- --- --- --- --- --- --- --- ---
% ---  Specify block transition conditions:
% ---  ID ED conditions split into half and half
% ---  code is IDsameobj  = 1;
% ---  code is EDsameobj  = 2;
% ---  code is IDnewobj   = 3;
% ---  code is EDnewobj   = 4;
% --- --- --- --- --- --- --- --- ---
if nBlocks<10, error('for ID ED comparing at least 10 blocks are suggested'), end

% --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
% --- randomize ID ED transitions; 60% SAME obects and ID ED
% --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
nEDIDSAME = ceil(0.6*nBlocks);
tmp = randperm(nEDIDSAME);
tmpcnd = randperm(2);
EDIDblocks1 = zeros(1,nEDIDSAME);
EDIDblocks1(find(mod(tmp,2)==0)) = tmpcnd(1);
EDIDblocks1(find(mod(tmp,2)~=0)) = tmpcnd(2);

% --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
% --- 40% of blocks with NEW objects 
% --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
nEDIDNEW = floor(0.4*nBlocks);
tmp = randperm(nEDIDNEW);
tmpcnd = randperm(2)+2; % conditions 3 and 4
EDIDblocks2 = zeros(1,nEDIDNEW);
EDIDblocks2(find(mod(tmp,2)==0)) = tmpcnd(1);
EDIDblocks2(find(mod(tmp,2)~=0)) = tmpcnd(2);

iOrder = randperm(2);
if iOrder(1)==1
    blockdata.sequenceEDID = [ EDIDblocks1  EDIDblocks2 ];
else
    blockdata.sequenceEDID = [ EDIDblocks2  EDIDblocks1 ];
end
% add random token condtions
iCndArr = [1 2 3 4];
n = length(blockdata.sequenceEDID);
nTokenConditions = ceil(n/4);
tokenSequenceRaw = repmat(iCndArr,1,nTokenConditions);
tokenSequenceRaw = tokenSequenceRaw(randperm(length(tokenSequenceRaw)));
tokenSequenceRaw = tokenSequenceRaw(1:n);

blockdata.sequencetoken = tokenSequenceRaw;

   doShowProgress1 = 0;
if  doShowProgress1
    disp('check progress on EDID and token condition sequence'), 
    blockdata.sequenceEDID
    blockdata.sequencetoken
    pause 
end

% if 0
% if nBlocks==36
%     % --- split conditions into 18 blocks, alternate FUS and non-FUS blocks 9 times 4 are 36 blocks:
%     iCndArr = [1 2 3 4];
%     % get 9 blocks same objects ID, 9 blocks same objects ED, 9 blocks new objects ID, 9 blocks new objects ED
%     EDID = [zeros(1,9)+1 zeros(1,9)+2];
%     blocksSameObjects = EDID(randperm(length(EDID)));
%     EDID = [zeros(1,9)+3 zeros(1,9)+4];
%     blocksNewObjects  = EDID(randperm(length(EDID)));
% 
%     blockdata.sequencetoken =  [iCndArr(randperm(length(iCndArr))), iCndArr(randperm(length(iCndArr))), iCndArr(randperm(length(iCndArr))), iCndArr(randperm(length(iCndArr))), iCndArr(randperm(length(iCndArr))), iCndArr(randperm(length(iCndArr))), iCndArr(randperm(length(iCndArr))), iCndArr(randperm(length(iCndArr))), iCndArr(randperm(length(iCndArr))) ];
%     blockdata.sequenceEDID = [blocksSameObjects(1:6) blocksNewObjects(1:6) blocksSameObjects(7:12) blocksNewObjects(7:12) blocksSameObjects(13:18) blocksNewObjects(13:18)];
% 
% elseif nBlocks==16
% 
%     iCndArr = [1 2 3 4];
%     % get 9 blocks same objects ID, 9 blocks same objects ED, 9 blocks new objects ID, 9 blocks new objects ED
%     EDID = [zeros(1,4)+1 zeros(1,4)+2];
%     blocksSameObjects = EDID(randperm(length(EDID)));
%     EDID = [zeros(1,4)+3 zeros(1,4)+4];
%     blocksNewObjects  = EDID(randperm(length(EDID)));
% 
%     blockdata.sequencetoken =  [iCndArr(randperm(length(iCndArr))), iCndArr(randperm(length(iCndArr))), iCndArr(randperm(length(iCndArr))), iCndArr(randperm(length(iCndArr))) ];
%     blockdata.sequenceEDID = [blocksSameObjects(1:4) blocksNewObjects(1:4) blocksSameObjects(5:8) blocksNewObjects(5:8) ];
% 
% end
% end

% --- randomly flip which sequence comes first:
if randi(2) == 2,  blockdata.sequenceEDID = fliplr(blockdata.sequenceEDID); end


% --- --- --- --- --- --- --- --- ---
% --- determine block sequence:
% --- --- --- --- --- --- --- --- ---
% previousTargetFeatureIndex =  NaN;
% previousTargetFeatureValue =  NaN;
% previousTargetDimension =  NaN;
%
% previousDistractorFeatureIndices =  NaN;
% previousDistrctorFeatureValues =  NaN;
% previousDistractorDimension =  NaN;
prev_targetDim = NaN;
prev_distractorDim = NaN;
prev_targetFeat = NaN;
prev_DistractorFeatSameDimension = NaN;
prev_DistractorFeatOtherDimension = NaN;


iS=1;
for iB=1:length(blockdata.sequenceEDID) % first block... select randomly
    iBlockType = blockdata.sequenceEDID(iB);

    iTokenConditionName = tokenCondition{blockdata.sequencetoken(iB)}.name;

    if iB==1 % for first block generate target feature + dimension set
        blockdata(iS).blockname{iB} = sprintf('NNNew.%d',blockdata(iS).sequencetoken(iB));
        
        iEnforceDimension = [];
        iExcludeDimension = [];
        iExcludeFeaturesOfEnforcedDimension  = [];
        [dimFeat, nDF]  = get_newDimFeatureSet(dimensionFeatures,nDimensions,nFeaturesPerDim,iExcludeDimension,iEnforceDimension,iExcludeFeaturesOfEnforcedDimension );
        possibleTargetFeatures =  [1:max(nDF)]; tmp = randperm(length(possibleTargetFeatures))

        % ### --- and new target dimension
        currentDimensions = find(nDF~=0); tmp2 = randperm(length(currentDimensions));
        iTargetDim = currentDimensions(tmp2(1));
        iDistratorDim = currentDimensions(tmp2(2));

        % ### --- get new target feature
        possibleFeatures = dimFeat{iTargetDim};
        tmp = randperm(length(possibleFeatures));
        currentTargetFeature = possibleFeatures(tmp(1));
        tmp(1) = [];
        currentDistractorFeaturesSameDimension  = possibleFeatures(tmp);
        currentDistractorFeaturesOtherDimension  = dimFeat{iDistratorDim};

    elseif iBlockType == 1
        blockdata(iS).blockname{iB} = sprintf('IDSame.%d',blockdata(iS).sequencetoken(iB));

        % ### --- no new objects
        ;
        % ### --- keep dimensions all the same
        iTargetDim = prev_targetDim;
        iDistratorDim = prev_distractorDim;

        % ### --- new target feature is one of previous distractor features:
        tmp=randperm(length(prev_DistractorFeatSameDimension))
        currentTargetFeature = prev_DistractorFeatSameDimension(tmp(1));
        prev_DistractorFeatSameDimension(tmp(1)) = [];
        % --- old target is added to distractor features:
        currentDistractorFeaturesSameDimension = [prev_DistractorFeatSameDimension prev_targetFeat];
        % --- distractor dimension stays the same
        currentDistractorFeaturesOtherDimension = prev_DistractorFeatOtherDimension;

        % sanity check
        if (prev_targetDim ~=  iTargetDim) | currentTargetFeature == prev_targetFeat
            disp('fatal swirching of dimensions or maintaining same target feature in ID same '), keyboard
        end
        % EDSame if new block needs 1) same object, and 2) target is in other=extra dimension as before :   elseif iBlockSequence == 2
    elseif iBlockType == 2
        blockdata(iS).blockname{iB}= sprintf('EDSame.%d',blockdata(iS).sequencetoken(iB));

        % ### --- no new objects
        ;

        % ### --- switch target and distractor dimensions
        iTargetDim = prev_distractorDim;
        iDistratorDim = prev_targetDim ;

        % ### --- select a feature from the distractor dimension as the new target:
        tmp = randperm(length(prev_DistractorFeatOtherDimension));
        currentTargetFeature = prev_DistractorFeatOtherDimension(tmp(1));
        prev_DistractorFeatOtherDimension(tmp(1)) = [];
        % other feature of  that dimension become the new distractors of same dimension:
        currentDistractorFeaturesSameDimension = prev_DistractorFeatOtherDimension;
        % prev target become new distractor
        currentDistractorFeaturesOtherDimension = [prev_DistractorFeatSameDimension prev_targetFeat];

        % sanity check
        if (prev_targetDim ==  iTargetDim)
            disp('fatal repetition of same targett dimensino in ED same '), keyboard,
        end

        % IDNew if new block needs 1) new objects, and 2) target is new feature in the same dimension as before :
    elseif iBlockType == 3
        blockdata(iS).blockname{iB}= sprintf('IDNew.%d',blockdata(iS).sequencetoken(iB));

        % ### --- get new objects, one dimension the same as last objects
        dimFeat = []; nDF = [];cnt=1;   doBreak = 0;
        while 1
            iEnforceDimension = prev_targetDim;
            iExcludeDimension = prev_distractorDim;
            iExcludeFeaturesOfEnforcedDimension  = [prev_targetFeat prev_DistractorFeatSameDimension];
            [dimFeatNN, nDFtmp]  = get_newDimFeatureSet(dimensionFeatures,nDimensions,nFeaturesPerDim,iExcludeDimension,iEnforceDimension,iExcludeFeaturesOfEnforcedDimension );
            iDimensions = find(nDFtmp);
            % ensure the target dimension is the same BUT the distractor
            % dimension changes, ... AND that feature of the 'same' dimension are different
            if        sum(ismember(iDimensions, [prev_targetDim ])  ==1 ) ...
                    & sum(ismember(iDimensions, [prev_distractorDim ])==0 ) ...
                    & sum(ismember(dimFeatNN{prev_targetDim},[prev_targetFeat prev_DistractorFeatSameDimension])==0)
                dimFeat = dimFeatNN;
                nDF = nDFtmp;
                doBreak = 1;
                disp('...')
            end
            if doBreak, break, end
            cnt=cnt+1;
            if mod(cnt,1000000)==0, disp('while IDNew timeout'), keyboard,end
        end


        % ### --- same target diemnsion but different distr dimension
        iTargetDim = prev_targetDim;
        nDF(iTargetDim) = 0;
        tmp = find(nDF>0);  
        iDistratorDim = tmp(randi(length(tmp)));
%disp('hmm'), keyboard,
        % ### --- determine new target feature
        possibleFeatures = dimFeat{iTargetDim};
        tmp = randperm(length(possibleFeatures));
        currentTargetFeature = possibleFeatures(tmp(1));
        tmp(1) = [];
        currentDistractorFeaturesSameDimension  = possibleFeatures(tmp);
        currentDistractorFeaturesOtherDimension  = dimFeat{iDistratorDim};

        % sanity check
        if (prev_targetDim ~=  iTargetDim) | currentTargetFeature == prev_targetFeat
            disp('fatal swirching dim or repeating same target feature for ID same')
            keyboard
        end
    elseif iBlockType == 4 % EDnew
        blockdata(iS).blockname{iB} = sprintf('EDNew.%d',blockdata(iS).sequencetoken(iB));

        % ### --- get new objects, both dimensions are new
        dimFeat = []; nDF = [];cnt=1;  doBreak = 0;
        while 1
            iEnforceDimension = [];
            iExcludeDimension = [ prev_targetDim prev_distractorDim];
            iExcludeFeaturesOfEnforcedDimension  = [];
            [dimFeatNN, nDFtmp]  = get_newDimFeatureSet(dimensionFeatures,nDimensions,nFeaturesPerDim,iExcludeDimension,iEnforceDimension,iExcludeFeaturesOfEnforcedDimension );
            iDimensions = find(nDFtmp);
            % ensure the target dimension is the diff and the distractor
            % dimension changes, ... AND that feature of the 'same' dimension are different
            if sum(ismember(iDimensions, [prev_targetDim ])== 0 ) ...
                    & sum(ismember(iDimensions, [prev_distractorDim ])==0 )
                dimFeat = dimFeatNN;
                nDF = nDFtmp;
                         doBreak = 1;
                disp('...')
        
            end
            if doBreak, break, end
           cnt=cnt+1;
                if mod(cnt,1000000)==0, disp('while EDNew'), keyboard,end
        end

        % ### --- set new (ED) target dimension
        currentDimensions = find(nDF~=0); tmp2 = randperm(length(currentDimensions));
        iTargetDim = currentDimensions(tmp2(1));
        iDistratorDim = currentDimensions(tmp2(2));

        % ### --- get new target feature
        possibleFeatures = dimFeat{iTargetDim};
        tmp = randperm(length(possibleFeatures));
        currentTargetFeature = possibleFeatures(tmp(1));
        tmp(1) = [];
        currentDistractorFeaturesSameDimension  = possibleFeatures(tmp);
        currentDistractorFeaturesOtherDimension  = dimFeat{iDistratorDim};

        % sanity check
        if (prev_targetDim ==  iTargetDim)
            disp('fatal repetition of same target dimension for ED new')
            keyboard
        end
    end
    prev_targetDim = iTargetDim;
    prev_distractorDim = iDistratorDim;
    prev_targetFeat = currentTargetFeature;
    prev_DistractorFeatSameDimension = currentDistractorFeaturesSameDimension;
    prev_DistractorFeatOtherDimension = currentDistractorFeaturesOtherDimension;

    % --- get stimulus vectors
    [stimValues, isTarget] = get_objects_01(dimFeat, nDF, currentTargetFeature, iTargetDim);

    doShowProgress2 = 0;
    if iB > 3 & doShowProgress2
    stimValues, 
    previousStimValues

    isTarget
    previousTarget
    blockdata(iS).blockname{iB}, 
    disp('check progress and block transitions'), pause, 
    end

previousStimValues = stimValues; 
previousTarget = isTarget; 


    % --- map stim vector to quaddle name
    [stimNames] = get_Quaddle1Name_01(Q1,stimValues);

    blockdata.stimValues{iB} = stimValues;
    blockdata.stimValuesIsTarget{iB} = isTarget;
    blockdata.stimNames{iB} = stimNames;
end

% --- --- --- --- --- --- --- --- ---
% --- add basic block information
% --- --- --- --- --- --- --- --- ---
nBlocks = length(blockdata.blockname);
for iB=1:nBlocks
    blockdata.blockname{iB};
    blockdata.blocknum(iB) = iB;
    blockdata.contextName{iB} = iContextName; %Tile
    blockdata.minmaxtrials(iB,1:2) = minmax(numTrials_minMax);
    blockdata.numTokens(iB) = numTokens;
    blockdata.numInitialTokens(iB) = numInitialTokens;

    %blockdata.NumPulses(iB) = NumRewardPulses;
    blockdata.PulseReward{iB} = sprintf('[{"NumReward":%d,"Probability":1.0}]', NumRewardPulses); %, {"NumReward":1, "Probability":0.2}];

    blockdata.PulseSize(iB) = RewardPulseSize;
    blockdata.BlockEndType{iB}	 = 'SimpleThreshold';
    blockdata.BlockEndWindow(iB) = BlockEndWindow;
    blockdata.BlockEndThreshold(iB) = BlockEndThreshold;
    blockdata.TokensWithStimOn{iB} = 'False';
end


% --- --- --- --- --- --- --- --- ---
% --- generate stimDef (collect the unique stimuli and safe the codes for
% --- using it in individual trials)
% --- --- --- --- --- --- --- --- ---
stimDef = [];
stimDef.StimIndex = [];
stimDef.StimName = [];
tmpAll = {};
j=1;
for iB = 1:length(blockdata(j).stimNames)
    for iS = 1:length(blockdata(j).stimNames{iB})
        tmpAll{end+1} = blockdata(j).stimNames{iB}{iS};
    end
end
stimDef.StimName = unique(tmpAll);
stimDef.StimIndex = 0:length(stimDef.StimName)-1;

% --- --- --- --- --- --- --- --- ---
% --- generate trials and block information
% --- --- --- --- --- --- --- --- ---
nBlocks = length(blockdata.blockname);

trl = [];
for iB=1:nBlocks
    trl(iB).TrialID = {};
    trl(iB).blockNum = iB;
    trl(iB).ContextName = {};
    trl(iB).TargetStimIndex = [];
    trl(iB).DistractorStimsIndices = [];
    trl(iB).TargetStimLocation = [];
    trl(iB).DistractorStimsLocations = [];
    trl(iB).RandomizedLocations = [];
    trl(iB).TokenGain = [];
    trl(iB).TokenLoss = [];
    %nTrials = numTrials_minMax(randi(length(numTrials_minMax)));
    nTrials = max(numTrials_minMax);%(randi(length(numTrials_minMax)));
    for iT = 1:nTrials

        % ----- column 1:
        trl(iB).TrialID{iT} = sprintf('%s.%.4d', blockdata.blockname{iB},iT);

        % ----- column 2:
        trl(iB).ContextName{iT} = iContextName;% 'Tile';

        % ----- column 3 and 4:
        % ----- determine target and 2 distractors that have no feature in common.s
        % target stimuli indices
        tmp = find(blockdata.stimValuesIsTarget{iB});
        tIndex = tmp(randi(length(tmp)));
        % check to not repeat same stimulus ? if ~isempty(tmp)
        targetName  = blockdata.stimNames{iB}{tIndex};
        targetFeatureValues  = blockdata.stimValues{iB}(tIndex,:);
        [a,b,stimIndex]=intersect(targetName,stimDef.StimName);
        stimIndex_target = stimDef.StimIndex(stimIndex);
        trl(iB).TargetStimIndex(iT) = stimIndex_target;

        % --- find the distractors that have no feature in commmon with other
        % --- distractor or with target.
        % --- find first distractor that is different to target features:
        tmp = find(~blockdata.stimValuesIsTarget{iB});
        tmp = tmp(randperm(length(tmp)));
        for k=1:length(tmp)
            iValues  = blockdata.stimValues{iB}(tmp(k),:);
            idx = find(iValues>0);
            % --- prevent same feature in two objects
            if sum(iValues(idx) == targetFeatureValues(idx))>0, continue, end
            distractorName  = blockdata.stimNames{iB}{tmp(k)};
            distractor1FeatureValues  = blockdata.stimValues{iB}(tmp(k),:);
            [a,b,stimIndex]=intersect(distractorName,stimDef.StimName);
            stimIndex_distractor = stimDef.StimIndex(stimIndex);
            trl(iB).DistractorStimsIndices(iT,1) = stimIndex_distractor;
        end
        tmp = tmp(randperm(length(tmp)));
        for k=1:length(tmp)
            iValues  = blockdata.stimValues{iB}(tmp(k),:);
            idx = find(iValues>0);
            % --- prevent same feature in two objects
            if (sum(iValues(idx) == targetFeatureValues(idx))>0) | (sum(iValues(idx) == distractor1FeatureValues(idx))>0), continue, end
            distractorName  = blockdata.stimNames{iB}{tmp(k)};
            distractor2FeatureValues  = blockdata.stimValues{iB}(tmp(k),:);
            [a,b,stimIndex]=intersect(distractorName,stimDef.StimName);
            stimIndex_distractor = stimDef.StimIndex(stimIndex);
            trl(iB).DistractorStimsIndices(iT,2) = stimIndex_distractor;
        end

        % ----- columns 5, 6 and 7: select a random set of positions and then 3 random positions
        tmp = randperm(length(allLocationPossibilities));
        iXY = allLocationPossibilities{tmp(1)};
        tmp = randperm(size(iXY,1));
        trl(iB).TargetStimLocation{iT} = iXY(tmp(1),:);
        trl(iB).DistractorStimsLocations{iT} = iXY([tmp(2) tmp(3)],:);
        trl(iB).RandomizedLocations = 0;

        % ----- columns 8 and 9
        iTokenCnd = blockdata.sequencetoken(iB);
        trl(iB).TokenGain(iT) = tokenCondition{iTokenCnd}.TokenGain;
        trl(iB).TokenLoss(iT) = tokenCondition{iTokenCnd}.TokenLoss;
        trl(iB).numInitialTokens(iT) = tokenCondition{iTokenCnd}.numInitialTokens;

    end
end

% --- --- --- --- --- --- --- --- ---
% --- write StimDef config file
% --- --- --- --- --- --- --- --- ---
iFilename = [cfg.out_flexLearning.experimentName  '_StimDef_array.txt'];
write_StimDefConfig_FlexLearning_01(cfg.out_flexLearning.iPath, iFilename, stimDef);

% --- --- --- --- --- --- --- --- ---
% --- write BlockDef config file
% --- --- --- --- --- --- --- --- ---
iFilename = [cfg.out_flexLearning.experimentName '_BlockDef_array.txt'];
write_BlockDefConfig_FlexLearning_01(cfg.out_flexLearning.iPath, iFilename, blockdata);

% --- --- --- --- --- --- --- --- ---
% --- write TrialDef config file
% --- --- --- --- --- --- --- --- ---
iFilename = [cfg.out_flexLearning.experimentName   '_TrialDef_array.txt'];
write_TrialDefConfig_FlexLearning_01(cfg.out_flexLearning.iPath, iFilename, trl);

% --- --- --- --- --- --- --- --- ---
% --- write ConfigUiDetails jason, eventCode jason, and SynchboxDef txt file
% --- --- --- --- --- --- --- --- ---
jsonData = [];
iFilename = [cfg.out_flexLearning.experimentName '_ConfigUiDetails_json']; % this will be a jason file
write_ConfigUIDetails_FlexLearning_01(cfg.out_flexLearning.iPath, iFilename, jsonData);
%SynchBoxDefInfo = {};
%iFilename = [cfg.out_flexLearning.experimentName '_TaskDeftdf.txt'];
%write_SynchBoxDef_FlexLearning_01(cfg.out_flexLearning.iPath, iFilename, SynchBoxDefInfo)
%SynchBoxDefInfo = {};
%iFilename = [cfg.out_flexLearning.experimentName '_SyncBoxDef.txt'];
%write_SynchBoxDef_FlexLearning_01(cfg.out_flexLearning.iPath, iFilename, SynchBoxDefInfo)

if 0
    iFilename = [cfg.out_flexLearning.experimentName '_EventCodeConfig_json']; % this will be a jason file
    write_EventCode_FlexLearning_01(cfg.out_flexLearning.iPath, iFilename);
    % [iFilename, iPath] = write_ConfigUIDetails_WorkingMemory_01(iPath, iFilename, jsonData)

end


% --- --- --- --- --- --- --- --- ---
% --- write TaskDef config file
% --- --- --- --- --- --- --- --- ---
%cfg.externalStimFolderPath_Quaddle1 = '"F:\QuaddleRepository_20180515"'

taskconfig = [];
if cfg.isWebGL == 1
    taskconfig{end+1} = 'float	StartButtonScale	1.2'; %125';%(0.1, 0.1, 0.1)
    taskconfig{end+1} = 'float	ExternalStimScale	5.5';
else
    %taskconfig{end+1} = sprintf('string	ContextExternalFilePath	%s',cfg.externalFilePath);
    taskconfig{end+1} = sprintf('string	ExternalStimFolderPath	%s',cfg.externalStimFolderPath_Quaddle1);
    taskconfig{end+1} = 'float	ExternalStimScale	0.07';
end
taskconfig{end+1} = 'string	ExternalStimExtension	""'; %.fbx
taskconfig{end+1} = 'bool	StimFacingCamera	TRUE'; %.fbx
taskconfig{end+1} = 'string	ShadowType	"None"';
taskconfig{end+1} = 'Vector3	StartButtonPosition	[0, 0, 0]';
%taskconfig{end+1} = 'Vector3	ButtonScale	(5, 5, 5)';%(0.1, 0.1, 0.1)
%taskconfig{end+1} = 'float	StartButtonScale	125';%(0.1, 0.1, 0.1)
taskconfig{end+1} = 'float	StartButtonScale	1';%(0.1, 0.1, 0.1)
%taskconfig{end+1} = 'Vector3	FBSquarePosition	(0, 0, -400)';
%taskconfig{end+1} = 'float	FBSquareScale	75';
taskconfig{end+1} = 'float	TouchFeedbackDuration	0.3';
taskconfig{end+1} = 'List<string>	FeedbackControllers	["Audio", "Halo", "Token"]';
taskconfig{end+1} = 'bool	NeutralITI	false';
iFilename = [cfg.out_flexLearning.experimentName   '_TaskDef_singleType.txt'];
%[iFilename, iPath] = write_TaskConfig_01(cfg.out_flexLearning.iPath,iFilename, taskconfig);
[iFilename, iPath] = write_TaskConfig_FlexLearning_01(cfg.out_flexLearning.iPath,iFilename, taskconfig);


fprintf('\ndone with iSet %.2d',cfg.iSet)

%end
fprintf('.\n')

%disp('done, returning'), return


% --- --- --- --- --- --- --- --- ---
% --- write BlockDef config file
% --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_BlockDefConfig_FlexLearning_01(iPath, iFilename, blockdata)

fPtr = fopen([iPath iFilename],'w');
%blockdef_header=['BlockName' '\t' 'BlockCount' '\t' 'ContextName' '\t' 'MinMaxTrials' '\t' 'NumTokenBar' '\t' 'NumInitialTokens' '\t' ...
%    'NumPulses' '\t' 'PulseSize' '\t' 'BlockEndType' '\t' 'BlockEndWindow' '\t' 'BlockEndThreshold'];
blockdef_header=['BlockName' '\t' 'BlockCount' '\t' 'ContextName' '\t' 'RandomMinMaxTrials' '\t' 'TokenBarCapacity' '\t' 'NumInitialTokens' '\t' ...
    'ProbabilisticNumPulses' '\t' 'PulseSize' '\t' 'BlockEndType' '\t' 'BlockEndWindow' '\t' 'BlockEndThreshold' '\t' 'TokensWithStimOn'];

fprintf(fPtr,blockdef_header);
for iB = 1:length(blockdata.blockname)
    iMinMaxTrials =  sprintf('[%d, %d]', blockdata.minmaxtrials(iB,1),blockdata.minmaxtrials(iB,2));

    iString = sprintf('%s\t%d\t%s\t%s\t%d\t%d\t%s\t%d\t%s\t%d\t%.2f\t%s', ...
        blockdata.blockname{iB},...
        blockdata.blocknum(iB),...
        blockdata.contextName{iB}(1:end-4),...
        iMinMaxTrials,...
        blockdata.numTokens(iB), ...
        blockdata.numInitialTokens(iB),...
        blockdata.PulseReward{iB},...
        blockdata.PulseSize(iB) ,...
        blockdata.BlockEndType{iB},...
        blockdata.BlockEndWindow(iB),...
        blockdata.BlockEndThreshold(iB),...
        blockdata.TokensWithStimOn{iB});

    %disp('w'), return
    fprintf(fPtr, '\n %s', iString);
end
fclose(fPtr);

fprintf('\n wrote %s', [ iFilename ]);



% --- --- --- --- --- --- --- --- ---
% --- write CongiUI config file
% --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_ConfigUIDetails_FlexLearning_01(iPath, iFilename, jsonData)

jsonData.varsNumber.selectObjectDuration.name = 'Select Object Duration';
if ~isfield(jsonData.varsNumber.selectObjectDuration, 'value'), jsonData.varsNumber.selectObjectDuration.value = 5;end
if ~isfield(jsonData.varsNumber.selectObjectDuration, 'min'), jsonData.varsNumber.selectObjectDuration.min = 1.0;end
if ~isfield(jsonData.varsNumber.selectObjectDuration, 'max'), jsonData.varsNumber.selectObjectDuration.max = 20.0;end
jsonData.varsNumber.selectObjectDuration.precision= 1;
jsonData.varsNumber.selectObjectDuration.isRange= 1;
jsonData.varsNumber.selectObjectDuration.hidden= 0;

jsonData.varsNumber.minObjectTouchDuration.name = 'Min Object Touch Duration';
if ~isfield(jsonData.varsNumber.minObjectTouchDuration, 'value'), jsonData.varsNumber.minObjectTouchDuration.value = 0.1;end %0.2 0.05
if ~isfield(jsonData.varsNumber.minObjectTouchDuration, 'min'), jsonData.varsNumber.minObjectTouchDuration.min = 0.01;end
if ~isfield(jsonData.varsNumber.minObjectTouchDuration, 'max'), jsonData.varsNumber.minObjectTouchDuration.max = 1.0;end
jsonData.varsNumber.minObjectTouchDuration.precision= 1;
jsonData.varsNumber.minObjectTouchDuration.isRange= 1;
jsonData.varsNumber.minObjectTouchDuration.hidden= 0;

jsonData.varsNumber.maxObjectTouchDuration.name = 'Max Object Touch Duration';
if ~isfield(jsonData.varsNumber.maxObjectTouchDuration, 'value'), jsonData.varsNumber.maxObjectTouchDuration.value = 2.5;end %`
if ~isfield(jsonData.varsNumber.maxObjectTouchDuration, 'min'), jsonData.varsNumber.maxObjectTouchDuration.min = 0.01;end
if ~isfield(jsonData.varsNumber.maxObjectTouchDuration, 'max'), jsonData.varsNumber.maxObjectTouchDuration.max = 4.0;end
jsonData.varsNumber.maxObjectTouchDuration.precision= 1;
jsonData.varsNumber.maxObjectTouchDuration.isRange= 1;
jsonData.varsNumber.maxObjectTouchDuration.hidden= 0;


jsonData.varsNumber.tokenRevealDuration.name = 'Token Reveal Duration';
if ~isfield(jsonData.varsNumber.tokenRevealDuration, 'value'), jsonData.varsNumber.tokenRevealDuration.value = 0.3;end
if ~isfield(jsonData.varsNumber.tokenRevealDuration, 'min'), jsonData.varsNumber.tokenRevealDuration.min = 0;end
if ~isfield(jsonData.varsNumber.tokenRevealDuration, 'max'), jsonData.varsNumber.tokenRevealDuration.max = 20;end
jsonData.varsNumber.tokenRevealDuration.precision= 1;
jsonData.varsNumber.tokenRevealDuration.isRange= 1;
jsonData.varsNumber.tokenRevealDuration.hidden= 0;

jsonData.varsNumber.tokenUpdateDuration.name = 'Token Update Duration';
if ~isfield(jsonData.varsNumber.tokenUpdateDuration, 'value'), jsonData.varsNumber.tokenUpdateDuration.value = 0.3;end
if ~isfield(jsonData.varsNumber.tokenUpdateDuration, 'min'), jsonData.varsNumber.tokenUpdateDuration.min = 0.0;end
if ~isfield(jsonData.varsNumber.tokenUpdateDuration, 'max'), jsonData.varsNumber.tokenUpdateDuration.max = 20.0;end
jsonData.varsNumber.tokenUpdateDuration.precision= 0;
jsonData.varsNumber.tokenUpdateDuration.isRange= 1;
jsonData.varsNumber.tokenUpdateDuration.hidden= 0;


jsonData.varsNumber.tokenFlashingDuration.name = 'Token Flashing Duration';
if ~isfield(jsonData.varsNumber.tokenFlashingDuration, 'value'), jsonData.varsNumber.tokenFlashingDuration.value = 0.5;end
if ~isfield(jsonData.varsNumber.tokenFlashingDuration, 'min'), jsonData.varsNumber.tokenFlashingDuration.min = 0.0;end
if ~isfield(jsonData.varsNumber.tokenFlashingDuration, 'max'), jsonData.varsNumber.tokenFlashingDuration.max = 20.0;end
jsonData.varsNumber.tokenFlashingDuration.precision= 1;
jsonData.varsNumber.tokenFlashingDuration.isRange= 1;
jsonData.varsNumber.tokenFlashingDuration.hidden= 0;


jsonData.varsNumber.itiDuration.name = 'ITI Duration';
if ~isfield(jsonData.varsNumber.itiDuration, 'value'), jsonData.varsNumber.itiDuration.value = 0.3;end%0.5;
if ~isfield(jsonData.varsNumber.itiDuration, 'min'), jsonData.varsNumber.itiDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.itiDuration, 'max'), jsonData.varsNumber.itiDuration.max = 10.0;end
jsonData.varsNumber.itiDuration.precision= 1;
jsonData.varsNumber.itiDuration.isRange= true;
jsonData.varsNumber.itiDuration.hidden= false;

jsonData.varsNumber.fbDuration.name = 'fbDuration';
if ~isfield(jsonData.varsNumber.fbDuration, 'value'), jsonData.varsNumber.fbDuration.value = 0.5;end
if ~isfield(jsonData.varsNumber.fbDuration, 'min'), jsonData.varsNumber.fbDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.fbDuration, 'max'), jsonData.varsNumber.fbDuration.max = 10.0;end
jsonData.varsNumber.fbDuration.precision= 1;
jsonData.varsNumber.fbDuration.isRange= true;
jsonData.varsNumber.fbDuration.hidden= false;

jsonData.varsNumber.searchDisplayDelay.name = 'Search Display Delay';
if ~isfield(jsonData.varsNumber.searchDisplayDelay, 'value'), jsonData.varsNumber.searchDisplayDelay.value = 0.5;end
if ~isfield(jsonData.varsNumber.searchDisplayDelay, 'min'), jsonData.varsNumber.searchDisplayDelay.min = 0.1;end
if ~isfield(jsonData.varsNumber.searchDisplayDelay, 'max'), jsonData.varsNumber.searchDisplayDelay.max = 20.0;end
jsonData.varsNumber.searchDisplayDelay.precision= 1;
jsonData.varsNumber.searchDisplayDelay.isRange= true;
jsonData.varsNumber.searchDisplayDelay.hidden= false;


jsonData.varsNumber.gratingSquareDuration.name = 'Grating Square Duration';
if ~isfield(jsonData.varsNumber.gratingSquareDuration, 'value'), jsonData.varsNumber.gratingSquareDuration.value = 0.5;end
if ~isfield(jsonData.varsNumber.gratingSquareDuration, 'min'), jsonData.varsNumber.gratingSquareDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.gratingSquareDuration, 'max'), jsonData.varsNumber.gratingSquareDuration.max = 20.0;end
jsonData.varsNumber.gratingSquareDuration.precision= 1;
jsonData.varsNumber.gratingSquareDuration.isRange= true;
jsonData.varsNumber.gratingSquareDuration.hidden= false;


jsonData.varsBoolean = {};
jsonData.varsString = {};

configUIstring=jsonencode(jsonData,'PrettyPrint',true);
A = findstr(configUIstring,'[]');
configUIstring(A(1):A(1)+1) = '{}';
configUIstring(A(2):A(2)+1) = '{}';

fPtr = fopen([iPath iFilename '.json'],'w');
fprintf(fPtr, '%s', configUIstring);
fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);



% --- --- --- --- --- --- --- --- ---
% --- write StimDef config file
% --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_StimDefConfig_FlexLearning_01(iPath, iFilename, stimDef)

fPtr = fopen([iPath iFilename ],'w');
stimdef_header=['StimIndex' '\t' 'FileName' '\t' 'PrefabPath'];

fprintf(fPtr,stimdef_header);
for iS = 1:length(stimDef.StimIndex)
    iString = sprintf('%d\t%s\t""', ...
        stimDef.StimIndex(iS),...
        stimDef.StimName{iS});
    fprintf(fPtr, '\n %s', iString);
end
fclose(fPtr);

fprintf('\n wrote %s', [ iFilename ]);




% --- --- --- --- --- --- --- --- ---
% --- write TrialDef config file
% --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_TrialDefConfig_FlexLearning_01(iPath, iFilename, trl)

% trl(1)
%                      TrialID: {1×50 cell}
%                     blockNum: 1
%                  ContextName: {1×50 cell}
%              TargetStimIndex: [91 91 88 89 91 89 88 89 89 89 91 88 89 91 88 88 88 88 91 88 91 89 89 91 88 91 89 91 88 91 89 91 91 88 89 … ]
%       DistractorStimsIndices: [50×2 double]
%           TargetStimLocation: {1×50 cell}
%     DistractorStimsLocations: {1×50 cell}
%          RandomizedLocations: 0
%                    TokenGain: [3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3]
%                    TokenLoss: [-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 … ]
%             numInitialTokens: [5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5]

fPtr = fopen([iPath iFilename],'w');
%trialdef_header=['TrialID' '\t' 'BlockCount' '\t' 'ContextName' '\t' 'TrialStimIndices' '\t' 'TrialStimLocations' '\t' 'TrialStimTokenReward' '\t' 'RandomizedLocations' ];
trialdef_header=['TrialID' '\t' 'BlockCount' '\t' 'TrialStimIndices' '\t' 'TrialStimLocations' '\t' 'ProbabilisticTrialStimTokenReward' '\t' 'RandomizedLocations' ];

fprintf(fPtr,trialdef_header);
for iB = 1:length(trl)
    for iT = 1:length(trl(iB).TargetStimIndex)

        StimIndices = sprintf('[%d, %d, %d]', trl(iB).TargetStimIndex(iT), trl(iB).DistractorStimsIndices(iT,1), trl(iB).DistractorStimsIndices(iT,2));

        StimLocations = sprintf('[[%.1f, %.1f, 0],[%.1f, %.1f, 0],[%.1f, %.1f, 0]]', trl(iB).TargetStimLocation{iT}(1), trl(iB).TargetStimLocation{iT}(2),...
            trl(iB).DistractorStimsLocations{iT}(1,1),trl(iB).DistractorStimsLocations{iT}(1,2),...
            trl(iB).DistractorStimsLocations{iT}(2,1),trl(iB).DistractorStimsLocations{iT}(2,2));

        %StimTokenReward = sprintf('[[{"NumTokens":%d,"Probability":1}], [{"NumTokens":%d,"Probability":1}], [{"NumTokens":%d,"Probability":1}]]',trl(iB).TokenGain(iT), trl(iB).TokenLoss(iT), trl(iB).TokenLoss(iT));
        StimTokenReward = sprintf('[[{"NumReward":%d,"Probability":1}], [{"NumReward":%d,"Probability":1}], [{"NumReward":%d,"Probability":1}]]',trl(iB).TokenGain(iT), trl(iB).TokenLoss(iT), trl(iB).TokenLoss(iT));

        iString = sprintf('%s\t%d\t%s\t%s\t%s\tFALSE', ...
            trl(iB).TrialID{iT},...
            trl(iB).blockNum,...
            StimIndices, ...
            StimLocations, ...
            StimTokenReward);

        %disp('w'), return
        fprintf(fPtr, '\n %s', iString);
    end
end
fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);




%  --- --- --- --- --- --- --- ---
%  --- TaskConfig
%  --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_TaskConfig_FlexLearning_01(iPath, iFilename, taskconfig)
fPtr = fopen([iPath iFilename],'w');
for iT = 1:length(taskconfig)
    if iT == 1
        fprintf(fPtr, '%s', taskconfig{iT});
    else
        fprintf(fPtr, '\n%s', taskconfig{iT});
    end
end
fclose(fPtr);
fprintf('\n wrote %s', [iFilename ]);



