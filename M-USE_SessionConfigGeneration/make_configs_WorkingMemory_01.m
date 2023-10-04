function [cfg] = make_configs_WorkingMemory_01(cfg,iExpName,iContextName)
% --- this script generates the delayed - match- to sampe task

if isempty(cfg)
    cfg.iSet = 1;
    cfg.isWebGL = 0;
end

if ~isfield(cfg, 'isWebGL'),    cfg.isWebGL = 0; end
if isempty(iExpName), iExpName = 'WorkingMemory'; end

if nargin < 3 | isempty(iContextName)
    [a,typeID,c] = intersect(cfg.contexts.types,'Soil');
    context_idx = find(cfg.contexts.typeID==typeID);
    iContextName = cfg.contexts.name{context_idx(randi(length(context_idx)))};
    tmp = findstr(iContextName,'.png'); if ~isempty(tmp), iContextName(tmp(1):end)=[]; end
end

cfg.out_workingMemory = [];
cfg.out_workingMemory.experimentName = [];
cfg.out_workingMemory.taskFolderName = [];
cfg.out_workingMemory.iPath = [];

if ~exist(cfg.sessionPathName), mkdir(cfg.sessionPathName), end

cfg_WM = [];

cfg_WM.NumRewardPulses = 2;
cfg_WM.RewardPulseSize = 250;
cfg_WM.numTokens = 3;
cfg_WM.numInitialTokens = 0;

cfg_WM.TokenGain = 2;
cfg_WM.TokenLoss = -1;
cfg_WM.initTrialDuration = 0.2;
cfg_WM.baselineDuration =0.5;

% these 4 prametrs are not in the ioCofigUI but in the triaDef
cfg_WM.displaySampleDuration = 0.5;
cfg_WM.postSampleDelayDuration = 0.5;
cfg_WM.displayPostSampleDistractorsDuration = 0.1;
cfg_WM.preTargetDelayDuration = 0.1;

cfg_WM.maxSearchDuration = 2;
cfg_WM.selectionFbDuration = 0.3;
cfg_WM.tokenRevealDuration = 0.4;
cfg_WM.tokenUpdateDuration = 0.3;
cfg_WM.trialEndDuration = 0.5;


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
dimensionFeatures = [iMin iMin iMin iMin];
nFeaturesPerDim = 8;

% --- --- --- --- --- ---  ---  ---  ---  --- 
% --- task specific config's nTrials
% --- --- --- --- --- ---  ---  ---  ---  --- 
if ~isfield(cfg,'wm_nTrials') | isempty(cfg.wm_nTrials)
    cfg.out_workingMemory.cnd_nTrials = 200;
else
    cfg.out_workingMemory.cnd_nTrials = cfg.wm_nTrials;
end


if ~isfield(cfg, 'wm_difficultyLevel') | isempty(cfg.wm_difficultyLevel)
    cfg.wm_difficultyLevel = [];

    cfg.out_workingMemory.experimentName = sprintf('%s_DC_v01',iExpName);
    cfg.out_workingMemory.cnd_delaySec = cfg.wm_delaySec;
    cfg.out_workingMemory.cnd_distractorSetSize = cfg.wm_distractorSetSize; 

elseif cfg.wm_difficultyLevel==1 % Training Step 1 - good performance after stunningly only 2 days, but no delay dependence
 
    cfg.out_workingMemory.experimentName = sprintf('%s_D1_v01',iExpName);
    cfg.out_workingMemory.cnd_delaySec = [0.2 0.4 0.5 0.6];
    cfg.out_workingMemory.cnd_distractorSetSize = [0 1 1]; % two thirds with one distractor and test

elseif cfg.wm_difficultyLevel==2 % TraininStep 2 -

    cfg.out_workingMemory.experimentName = sprintf('%s_D2_v01',iExpName);
    cfg.out_workingMemory.cnd_delaySec = [0.2 0.5 0.9 1.4];
    cfg.out_workingMemory.cnd_distractorSetSize = [0 1 1 1]; % two thirds with one distractor and test

elseif cfg.wm_difficultyLevel==3 % TraininStep 3 -
   
    cfg.out_workingMemory.experimentName = sprintf('%s_D3_v01',iExpName);
    cfg.out_workingMemory.cnd_delaySec = [0.3 0.6 1.2 1.8];
    cfg.out_workingMemory.cnd_distractorSetSize = [0 1 3 3]; % half s with one distractor and test

elseif cfg.wm_difficultyLevel == 4 % TraininStep 3 -

    cfg.out_workingMemory.experimentName = sprintf('%s_D4_v01',iExpName);
    cfg.out_workingMemory.cnd_delaySec = [0.4 1.0 1.8 3.0];
    cfg.out_workingMemory.cnd_distractorSetSize = [1 1 3 3]; % half s with one distractor and test

end

cfg.out_workingMemory.taskFolderName = sprintf('%s_Set_%.02d',cfg.out_workingMemory.experimentName , cfg.iSet);
cfg.out_workingMemory.iPath = [cfg.sessionPathName '/' cfg.out_workingMemory.taskFolderName '/'];
    

%iPath = [ cfg.sessionPathName cfg.out_workingMemory.taskFolderName];
if ~exist(cfg.out_workingMemory.iPath), mkdir(cfg.out_workingMemory.iPath), end


allRotationPossibilities  = [90 0 0];
rotationStringOne =  ['[' num2str(allRotationPossibilities(1)) ', ' num2str(allRotationPossibilities(2)) ', ' num2str(allRotationPossibilities(3)) ']'];

% --- --- --- --- --- --- --- --- ---
% --- working memory trials...
% --- --- --- --- --- --- --- --- ---

trialDef_WM = [];
[trialDef_WM] = get_WMBlock_03(cfg.out_workingMemory.cnd_delaySec, cfg.out_workingMemory.cnd_distractorSetSize, cfg.out_workingMemory.cnd_nTrials) ;

nTrialsWM = length(trialDef_WM.cndlabel);

% --- --- --- --- --- --- --- --- ---
% ---- assign each feature vector an object ID:
% --- --- --- --- --- --- --- --- ---
stimDef = [];
stimDef.StimValues = [];
stimDef.StimName = {};
stimDef.StimCode = {};

allVectors = cat(1, trialDef_WM.probeobjectVectorAll, trialDef_WM.testobjectVectorAll);
% dimensionFeatureMapping = [1:8 1:8 1:8 1:8];

stimDef.StimValues = unique(allVectors,'rows');
[stimDef.StimName] = get_Quaddle1Name_01(Q1,stimDef.StimValues);
%stimDef.StimCode = 1:length(stimDef.StimName);
stimDef.StimCode = 0:(length(stimDef.StimName)-1); % it is an index starting with 0

% --- --- --- --- --- --- --- --- ---
% ---- define trials
% --- --- --- --- --- --- --- --- ---

TrialDef = [];
% added:
TrialDef.TrialID = {};
TrialDef.TrialNum = [];
TrialDef.BlockNum = [];
%TrialDef.ContextName = []; % this moved to BlockDef

TrialDef.TargetIndices = [];
TrialDef.PostSampleDistractorStimIndices = [];
TrialDef.TargetDistractorIndices = [];
TrialDef.SampleStimLocation = []; %target location
TrialDef.PostSampleDistractorStimLocations = []; % distractor during delay location
TrialDef.TargetSearchLocations = [];  % target/test object location
TrialDef.TargetDistractorLocations = []; % distractor location
TrialDef.TargetTokenUpdates = [];
TrialDef.DistractorTokenUpdates = [];
TrialDef.initTrialDuration = [];
TrialDef.baselineDuration = [];
TrialDef.displaySampleDuration = [];
TrialDef.postSampleDelayDuration = [];
TrialDef.displayPostSampleDistractorsDuration = [];
TrialDef.preTargetDelayDuration = [];
TrialDef.maxSearchDuration = [];
TrialDef.selectionFbDuration = [];
TrialDef.tokenRevealDuration = [];
TrialDef.tokenUpdateDuration = [];
TrialDef.trialEndDuration = [];

% --- --- --- --- --- --- --- --- ---
% ---- now assemble trials
% --- --- --- --- --- --- --- --- ---
iBlock = 1;
for iT = 1:nTrialsWM

    TrialDef(iBlock).TrialID{iT} = trialDef_WM.cndlabel{iT};
    TrialDef(iBlock).TrialNum(iT) = iT;

    % TrialDef(iBlock).ContextName{iT} = iContextName;
    TrialDef(iBlock).BlockNum(iT) = iBlock;

    % iCondition = trialDef_WM.cndlabel{iT};% (iBlock).tokenAssignment_label;

    iProbeObject = [];
    for k=1:size(trialDef_WM.probe_objectVector{iT},1)
        iObjects = trialDef_WM.probe_objectVector{iT}(k,:);
        [a,b,iInd] = intersect(iObjects ,stimDef.StimValues,'rows');
        iProbeObject(k) = stimDef.StimCode(iInd); % stimCode starts at 0
    end

    iTestObjectsObject = [];
    for k=1:size(trialDef_WM.test_objectVector{iT},1)
        iObjects = trialDef_WM.test_objectVector{iT}(k,:);
        [a,b,iInd] = intersect(iObjects ,stimDef.StimValues,'rows');
        iTestObjectsObject(k) = stimDef.StimCode(iInd);
    end

    TrialDef.TargetIndices{iT} = iProbeObject;
    TrialDef.TargetDistractorIndices{iT} = iTestObjectsObject;
    TrialDef.PostSampleDistractorStimIndices{iT} = NaN;
    nDistractors = length(TrialDef.TargetDistractorIndices{iT});

    TrialDef.SampleStimLocations{iT}         = trialDef_WM.probe_objectXYZ(iT,[1 3]);
    TrialDef.PostSampleDistractorStimLocations{iT} = [];
    TrialDef.TargetSearchLocations{iT} = trialDef_WM.test_objectXYZ{iT}(1,[1 3]);
    TrialDef.TargetDistractorLocations{iT} = trialDef_WM.test_objectXYZ{iT}(2:end,[1 3]);


    TrialDef.TargetTokenUpdates(iT) = cfg_WM.TokenGain;
    TrialDef.DistractorTokenUpdates{iT} = repmat(cfg_WM.TokenLoss,1,nDistractors);
    TrialDef.initTrialDuration(iT) = cfg_WM.initTrialDuration;
    TrialDef.baselineDuration(iT) = cfg_WM.baselineDuration;

    TrialDef.displaySampleDuration(iT) = cfg_WM.displaySampleDuration;
    % the delay
    TrialDef.postSampleDelayDuration(iT) = trialDef_WM.trialsBlankDelay(iT);%cfg_WM.postSampleDelayDuration;
    TrialDef.displayPostSampleDistractorsDuration(iT) = cfg_WM.displayPostSampleDistractorsDuration;
    TrialDef.preTargetDelayDuration(iT) = cfg_WM.preTargetDelayDuration;
    
    TrialDef.maxSearchDuration(iT) = cfg_WM.maxSearchDuration;
    TrialDef.selectionFbDuration(iT) = cfg_WM.selectionFbDuration;
    TrialDef.tokenRevealDuration(iT) = cfg_WM.tokenRevealDuration;
    TrialDef.tokenUpdateDuration(iT) = cfg_WM.tokenUpdateDuration;
    TrialDef.trialEndDuration(iT) = cfg_WM.trialEndDuration;

end


% --- --- --- --- --- --- --- --- ---
% --- initialize block information
% --- --- --- --- --- --- --- --- ---
blockdata = [];
blockdata.blockname ={};
blockdata.blocknum = [];
blockdata.contextName = [];

blockdata.numTokens = [];
blockdata.numInitialTokens = [];
blockdata.NumPulses = [];
blockdata.PulseSize = [];

nBlocks = 1;%length(blockdata.blockname);
for iB=1:nBlocks
    blockdata.blockname{iB} = 'WM';
    blockdata.blocknum(iB) = iB;
    %TrialDef(iBlock).ContextName{iT} = iContextName;
    blockdata.contextName{iB} = iContextName; 
    blockdata.numTokens(iB)  = cfg_WM.numTokens;
    blockdata.numInitialTokens(iB) = cfg_WM.numInitialTokens;
    blockdata.NumPulses(iB) = cfg_WM.NumRewardPulses;
    blockdata.PulseSize(iB) = cfg_WM.RewardPulseSize;
end

% --- --- --- --- --- --- --- --- ---
% --- write StimDef config file
% --- --- --- --- --- --- --- --- ---
iFilename = [cfg.out_workingMemory.experimentName  '_StimDef_array.txt'];
write_StimDefConfig_WorkingMemory_01(cfg.out_workingMemory.iPath, iFilename, stimDef);


% --- --- --- --- --- --- --- --- ---
% --- write BlockDef config file
% --- --- --- --- --- --- --- --- ---
iFilename = [cfg.out_workingMemory.experimentName '_BlockDef_array.txt'];
write_BlockDefConfig_WorkingMemory_01(cfg.out_workingMemory.iPath, iFilename, blockdata);

% --- --- --- --- --- --- --- --- ---
% --- write ConfigUiDetails jason, eventCode jason, and SynchboxDef txt file
% --- --- --- --- --- --- --- --- ---
jsonData = [];
iFilename = [cfg.out_workingMemory.experimentName '_ConfigUiDetails_json']; % this will be a jason file
write_ConfigUIDetails_WorkingMemory_01(cfg.out_workingMemory.iPath, iFilename, jsonData);

%SynchBoxDefInfo = {};
%iFilename = [cfg.out_workingMemory.experimentName '_SyncBoxDef.txt'];
%write_SynchBoxDef_WorkingMemory_01(cfg.out_workingMemory.iPath, iFilename, SynchBoxDefInfo)
%eventCodeInfo = [];
%iFilename = [cfg.out_workingMemory.experimentName '_EventCodeConfig']; % this will be a jason file
%write_EventCode_WorkingMemory_01(cfg.out_workingMemory.iPath, iFilename, eventCodeInfo);
% [iFilename, iPath] = write_ConfigUIDetails_WorkingMemory_01(iPath, iFilename, jsonData)

% --- --- --- --- --- --- --- --- ---
% --- write TrialDef config file
% --- --- --- --- --- --- --- --- ---
iFilename = [cfg.out_workingMemory.experimentName '_TrialDef_array.txt'];
write_TrialDefConfig_WorkingMemory_01(cfg.out_workingMemory.iPath, iFilename, TrialDef);

% --- --- --- --- --- --- --- --- ---
% --- write TaskDef config file
% --- --- --- --- --- --- --- --- ---

taskconfig = [];
if cfg.isWebGL == 1
    taskconfig{end+1} = 'float	ExternalStimScale	0.8'; % is 5.5 in FlexLearn
    taskconfig{end+1} = 'float	StartButtonScale	1.2';
    taskconfig{end+1} = 'bool	MakeStimPopOut false';
else
%    taskconfig{end+1} = sprintf('string	ContextExternalFilePath	%s',cfg.externalFilePath);
    taskconfig{end+1} = sprintf('string	ExternalStimFolderPath	%s',cfg.externalStimFolderPath_Quaddle1);

    taskconfig{end+1} = 'bool	StimFacingCamera	TRUE';
    taskconfig{end+1} = 'float	ExternalStimScale	0.07';
    taskconfig{end+1} = 'string	ShadowType	"None"';
    %taskconfig{end+1} = 'bool	UsingRewardPump	FALSE';
    taskconfig{end+1} = 'float	StartButtonScale	1';% 125';%(0.1, 0.1, 0.1)
    %taskconfig{end+1} = 'Vector3	ButtonScale	[0.5, 0.5, 0.5]';
    %taskconfig{end+1} = 'List<string>	FeedbackControllers	["Audio", "Halo", "Token"]';
end
taskconfig{end+1} = 'string	ExternalStimExtension	""'; %.fbx    
taskconfig{end+1} = 'Vector3	StartButtonPosition	[0, 0, 0]';    
taskconfig{end+1} = 'float	TouchFeedbackDuration	0.3';
    taskconfig{end+1} = 'List<string>	FeedbackControllers	["Audio", "Halo", "Token"]';
taskconfig{end+1} = 'bool	NeurtralITI	false';

iFilename = [cfg.out_workingMemory.experimentName '_TaskDef_singleType.txt'];
[iFilename, iPath] = write_TaskConfig_WorkingMemory_01(cfg.out_workingMemory.iPath,iFilename, taskconfig);




fprintf('\ndone with WM iSet %.2d',cfg.iSet),
fprintf('.\n')







% --- --- --- --- --- --- --- --- --- ---
% --- TrialDef
% --- --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_TrialDefConfig_WorkingMemory_01(iPath, iFilename, TrialDef)
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

% --- print TrialDef file:
% if ~exist(iPath), mkdir(iPath), end
% iFilename_StimDef  = sprintf('%s_Set%02d_StimDef',iFilname);
fPtr = fopen([iPath iFilename],'w');

%trialdef_header=['TrialID' '\t' 'BlockCount' '\t' 'ContextName' '\t' ...
%'TargetIndices' '\t' 'TargetDistractorIndices' '\t' 'PostSampleDistractorStimIndices' '\t' 'SampleStimLocations' '\t' 'TargetSearchLocations' '\t' 'PostSampleDistractorStimLocations' ...
% '\t' 'TargetDistractorLocations' '\t' 'TargetTokenUpdates' '\t' 'iDistractorTokenUpdates' '\t' 'initTrialDuration' '\t' 'baselineDuration' ...
% '\t' 'displaySampleDuration' '\t' 'postSampleDelayDuration' '\t' 'displayPostSampleDistractorsDuration' '\t' 'preTargetDelayDuration' ...
% '\t' 'maxSearchDuration' '\t' 'TrialDef.selectionFbDuration' '\t' 'tokenRevealDuration' '\t' 'tokenUpdateDuration' '\t' 'trialEndDuration'];
%trialdef_header = ['TrialID' '\t' 'BlockCount' '\t' 'ContextName' '\t' ...

%DisplaySampleDuration
%PostSampleDelayDuration
%DisplayPostSampleDistractorsDuration
%PreTargetDelayDuration


trialdef_header = ['TrialID' '\t' 'BlockCount' '\t'  'DisplaySampleDuration' '\t' 'PostSampleDelayDuration' '\t' 'DisplayPostSampleDistractorsDuration' '\t' 'PreTargetDelayDuration' '\t' ...
    'SampleStimLocation' '\t'  'SearchStimIndices' '\t' 'SearchStimLocations' '\t' 'SearchStimTokenReward' '\t'  'PostSampleDistractorStimIndices' '\t' 'PostSampleDistractorStimLocations'];

iBlockNum = 1;
fprintf(fPtr,trialdef_header);
for iT = 1:length(TrialDef.TargetIndices)


    iSampleStimLocation = [];
    iSearchStimIndices = [];
    iSearchStimLocations = [];
    iSearchStimTokenReward = [];
    iPostSampleDistractorStimIndices = [];
    iPostSampleDistractorStimLocations = [];

    % --- --- --- --- --- --- --- --- --- --- ---
    % --- collect the sample target and distractor indices
    % --- --- --- --- --- --- --- --- --- --- ---

    % ... distracting stimuli during delay:
    iTargetDistractorIndices = [];
    nStimuli = length(TrialDef.TargetDistractorIndices{iT});
    for j=1:length(TrialDef.TargetDistractorIndices{iT})
        if j>1
            iTargetDistractorIndices  = sprintf('%s, %d',iTargetDistractorIndices,TrialDef.TargetDistractorIndices{iT}(j));
        else
            iTargetDistractorIndices  = sprintf('%d',TrialDef.TargetDistractorIndices{iT}(j));
        end
    end
    %iSearchStimIndices = sprintf('[%d, %s]',TrialDef.TargetIndices{iT}, iTargetDistractorIndices);
    iSearchStimIndices = sprintf('[%s]',iTargetDistractorIndices);


    % --- --- --- --- --- --- --- --- --- --- ---
    % --- collect postsample distractor indices
    % --- --- --- --- --- --- --- --- --- --- ---
    iPostSampleDistractorStimIndicesTMP = [];
    if isnan(TrialDef.PostSampleDistractorStimIndices{iT})
        iPostSampleDistractorStimIndicesTMP = '';
    else
        for j=1:length(TrialDef.PostSampleDistractorStimIndices{iT})
            if j>1
                iPostSampleDistractorStimIndicesTMP  = sprintf('%s, %d',iPostSampleDistractorStimIndicesTMP,TrialDef.PostSampleDistractorStimIndices{iT}(j));
            else
                iPostSampleDistractorStimIndicesTMP  = sprintf('%d',TrialDef.PostSampleDistractorStimIndices{iT}(j));
            end
        end
    end
    iPostSampleDistractorStimIndices = sprintf('[%s]',iPostSampleDistractorStimIndicesTMP);


    % --- --- --- --- --- --- --- --- --- --- ---
    % --- location of target and distractor during test phase;=:
    % --- --- --- --- --- --- --- --- --- --- ---
    iTargetSearchLocationsTMP = [];
    for j=1:size(TrialDef.TargetSearchLocations{iT},1)
        if j>1
            iTargetSearchLocationsTMP   = sprintf('%s,[.1f, %.1f, 0]',iTargetSearchLocationsTMP ,TrialDef.TargetSearchLocations{iT}(j,1),TrialDef.TargetSearchLocations{iT}(j,2));
        else
            iTargetSearchLocationsTMP   = sprintf('[%.1f, %.1f, 0]',TrialDef.TargetSearchLocations{iT}(j,1),TrialDef.TargetSearchLocations{iT}(j,2));
        end
    end

    iTargetDistractorLocations = [];
    for j=1:size(TrialDef.TargetDistractorLocations{iT},1)
        if j>1
            iTargetDistractorLocations = sprintf('%s,[%.1f, %.1f, 0]',iTargetDistractorLocations,TrialDef.TargetDistractorLocations{iT}(j,1),TrialDef.TargetDistractorLocations{iT}(j,2));
        else
            iTargetDistractorLocations = sprintf('[%.1f, %.1f, 0]',TrialDef.TargetDistractorLocations{iT}(j,1),TrialDef.TargetDistractorLocations{iT}(j,2));
        end
    end
    iSearchStimLocations = sprintf('[%s, %s]',iTargetSearchLocationsTMP, iTargetDistractorLocations);

    % --- --- --- --- --- --- --- --- --- --- ---
    % --- during-delay distractor locations
    % --- --- --- --- --- --- --- --- --- --- ---
    iPostSampleDistractorStimLocationsTMP = [];
    for j=1:size(TrialDef.PostSampleDistractorStimLocations{iT},1)
        if j>1
            iPostSampleDistractorStimLocationsTMP = sprintf('%s,[%.1f, %.1f, 0]',iPostSampleDistractorStimLocationsTMP,TrialDef.PostSampleDistractorStimLocations{iT}(j,1),TrialDef.PostSampleDistractorStimLocations{iT}(j,2));
        else
            iPostSampleDistractorStimLocationsTMP = sprintf('[%.1f, %.1f, 0]',TrialDef.PostSampleDistractorStimLocations{iT}(j,1),TrialDef.PostSampleDistractorStimLocations{iT}(j,2));
        end
    end
    iPostSampleDistractorStimLocations = sprintf('[%s]',iPostSampleDistractorStimLocationsTMP);

    %iSampleStimLocations = sprintf('[%s]',iSampleStimLocations);


    % --- --- --- --- --- --- --- --- --- --- ---
    % --- sample location of target
    % --- --- --- --- --- --- --- --- --- --- ---
    iSampleStimLocationsTMP = [];
    for j=1:size(TrialDef.SampleStimLocations{iT},1)
        if j>1
            iSampleStimLocationsTMP  = sprintf('%s,[.1f, %.1f, 0]',iSampleStimLocationsTMP,TrialDef.SampleStimLocations{iT}(j,1),TrialDef.SampleStimLocations{iT}(j,2));
        else
            iSampleStimLocationsTMP  = sprintf('[%.1f, %.1f, 0]',TrialDef.SampleStimLocations{iT}(j,1),TrialDef.SampleStimLocations{iT}(j,2));
        end
    end
    iSampleStimLocation = iSampleStimLocationsTMP;

    % token for target and for distractors
    iSearchStimTokenReward='';
%    iSearchStimTokenReward = sprintf('[{"NumTokens":%d,"Probability":1}]', TrialDef.TargetTokenUpdates(iT));
%    % to nStimuli -1 because it contains the targte already
%    for iS=1:(nStimuli-1)
%        iSearchStimTokenReward = sprintf('%s, [{"NumTokens":%d,"Probability":1}]',iSearchStimTokenReward,TrialDef.DistractorTokenUpdates{iT}(j));
%    end
    iSearchStimTokenReward = sprintf('%d', TrialDef.TargetTokenUpdates(iT));
    % to nStimuli -1 because it contains the targte already
    for iS=1:(nStimuli-1)
        iSearchStimTokenReward = sprintf('%s, %d',iSearchStimTokenReward,TrialDef.DistractorTokenUpdates{iT}(j));
    end

    
    iSearchStimTokenReward = sprintf('[%s]',iSearchStimTokenReward);


%  DisplaySampleDuration
%  PostSampleDelayDuration
%  DisplayPostSampleDistractorsDuration
%  PreTargetDelayDuration

    
    % --- make string
    iString = sprintf('%s\t%d\t%.2f\t%.2f\t%.2f\t%.2f\t%s\t%s\t%s\t%s\t%s\t%s', ...
        TrialDef.TrialID{iT},...
        TrialDef.BlockNum(iT),...
  TrialDef.displaySampleDuration(iT),... 
    TrialDef.postSampleDelayDuration(iT),... 
    TrialDef.displayPostSampleDistractorsDuration(iT),... 
    TrialDef.preTargetDelayDuration(iT),... 
        iSampleStimLocation,...
        iSearchStimIndices,...
        iSearchStimLocations,...
        iSearchStimTokenReward,...
        iPostSampleDistractorStimIndices,...
        iPostSampleDistractorStimLocations);

    % iString = sprintf('%s\t%d\t%s\t%s\t%s\t%s\t%s\t%s', ...
    %     TrialDef.TrialID{iT},...
    %     TrialDef.BlockNum(iT),...
    %     iSampleStimLocation,...
    %     iSearchStimIndices,...
    %     iSearchStimLocations,...
    %     iSearchStimTokenReward,...
    %     iPostSampleDistractorStimIndices,...
    %     iPostSampleDistractorStimLocations);
    fprintf(fPtr, '\n %s', iString);
    %TrialDef.ContextName{iT},...
end
fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);



% --- --- --- --- --- --- --- --- --- ---
% --- BlockDef
% --- --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_BlockDefConfig_WorkingMemory_01(iPath, iFilename, blockdata)

fPtr = fopen([iPath iFilename],'w');
blockdef_header=['BlockName' '\t' 'BlockCount' '\t' 'ContextName' '\t' 'NumInitialTokens' '\t' 'TokenBarCapacity' '\t' 'NumPulses' '\t' 'PulseSize' ];

fprintf(fPtr,blockdef_header);
for iB = 1:length(blockdata.blockname)

    iString = sprintf('%s\t%d\t%s\t%d\t%d\t%d\t%d', ...
        blockdata.blockname{iB}, ...
        blockdata.blocknum(iB), ...
        blockdata.contextName{iB}, ...
        blockdata.numInitialTokens(iB), ...
        blockdata.numTokens(iB), ...
        blockdata.NumPulses(iB), ...
        blockdata.PulseSize(iB)	);
    fprintf(fPtr, '\n %s', iString);
end
fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);




% --- --- --- --- --- --- --- --- --- ---
% --- ConfigUIDef
% --- --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_ConfigUIDetails_WorkingMemory_01(iPath, iFilename, jsonData)


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
if ~isfield(jsonData.varsNumber.tokenRevealDuration, 'max'),     jsonData.varsNumber.tokenRevealDuration.max = 10;end
jsonData.varsNumber.tokenRevealDuration.precision= 0;
jsonData.varsNumber.tokenRevealDuration.isRange= 1;
jsonData.varsNumber.tokenRevealDuration.hidden= 0;

jsonData.varsNumber.tokenUpdateDuration.name = 'Token Update Duration';
if ~isfield(jsonData.varsNumber.tokenUpdateDuration, 'value'), jsonData.varsNumber.tokenUpdateDuration.value = 0.3;end
if ~isfield(jsonData.varsNumber.tokenUpdateDuration, 'min'), jsonData.varsNumber.tokenUpdateDuration.min = 0.0;end
if ~isfield(jsonData.varsNumber.tokenUpdateDuration, 'max'), jsonData.varsNumber.tokenUpdateDuration.max = 10.0;end
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

jsonData.varsNumber.maxSearchDuration.name = 'Max Search Duration';
if ~isfield(jsonData.varsNumber.maxSearchDuration, 'value'), jsonData.varsNumber.maxSearchDuration.value = 10.0;end
if ~isfield(jsonData.varsNumber.maxSearchDuration, 'min'), jsonData.varsNumber.maxSearchDuration.min = 0.0;end
if ~isfield(jsonData.varsNumber.maxSearchDuration, 'max'), jsonData.varsNumber.maxSearchDuration.max = 20.0;end
jsonData.varsNumber.maxSearchDuration.precision= 0;
jsonData.varsNumber.maxSearchDuration.isRange= true;
jsonData.varsNumber.maxSearchDuration.hidden= false;

jsonData.varsNumber.fbDuration.name = 'FB Duration';
if ~isfield(jsonData.varsNumber.fbDuration, 'value'), jsonData.varsNumber.fbDuration.value = 0.3;end
if ~isfield(jsonData.varsNumber.fbDuration, 'min'), jsonData.varsNumber.fbDuration.min = 0.0;end
if ~isfield(jsonData.varsNumber.fbDuration, 'max'), jsonData.varsNumber.fbsDuration.max = 10.0;end
jsonData.varsNumber.fbDuration.precision= 0;
jsonData.varsNumber.fbDuration.isRange= true;
jsonData.varsNumber.fbDuration.hidden= false;

if 0
% cfg_WM.displaySampleDuration = 0.5;
% cfg_WM.postSampleDelayDuration = 0.5;
% cfg_WM.displayPostSampleDistractorsDuration = 0.1;
% cfg_WM.preTargetDelayDuration = 0.1;

jsonData.varsNumber.displaySampleDuration.name = 'Display Sample Duration';
if ~isfield(jsonData.varsNumber.displaySampleDuration, 'value'), jsonData.varsNumber.displaySampleDuration.value = 1.0;end
if ~isfield(jsonData.varsNumber.displaySampleDuration, 'min'), jsonData.varsNumber.displaySampleDuration.min = 0.0;end
if ~isfield(jsonData.varsNumber.displaySampleDuration, 'max'), jsonData.varsNumber.displaySampleDuration.max = 10.0;end
jsonData.varsNumber.displaySampleDuration.precision= 0;
jsonData.varsNumber.displaySampleDuration.isRange= true;
jsonData.varsNumber.displaySampleDuration.hidden= false;

jsonData.varsNumber.postSampleDelayDuration.name = 'Post-Sample Delay Duration';
if ~isfield(jsonData.varsNumber.postSampleDelayDuration, 'value'), jsonData.varsNumber.postSampleDelayDuration.value = 0.5;end
if ~isfield(jsonData.varsNumber.postSampleDelayDuration, 'min'), jsonData.varsNumber.postSampleDelayDuration.min = 0.0;end
if ~isfield(jsonData.varsNumber.postSampleDelayDuration, 'max'), jsonData.varsNumber.postSampleDelayDuration.max = 10.0;end
jsonData.varsNumber.postSampleDelayDuration.precision= 0;
jsonData.varsNumber.postSampleDelayDuration.isRange= true;
jsonData.varsNumber.postSampleDelayDuration.hidden= false;

jsonData.varsNumber.displayPostSampleDistractorsDuration.name = 'Display Post-Sample Distractors Duration';
if ~isfield(jsonData.varsNumber.displayPostSampleDistractorsDuration, 'value'), jsonData.varsNumber.displayPostSampleDistractorsDuration.value = 0.5;end
if ~isfield(jsonData.varsNumber.displayPostSampleDistractorsDuration, 'min'), jsonData.varsNumber.displayPostSampleDistractorsDuration.min = 0.0;end
if ~isfield(jsonData.varsNumber.displayPostSampleDistractorsDuration, 'max'), jsonData.varsNumber.displayPostSampleDistractorsDuration.max = 10.0;end
jsonData.varsNumber.displayPostSampleDistractorsDuration.precision= 0;
jsonData.varsNumber.displayPostSampleDistractorsDuration.isRange= true;
jsonData.varsNumber.displayPostSampleDistractorsDuration.hidden= false;

jsonData.varsNumber.preTargetDelayDuration.name = 'Pre-Target Delay Duration';
if ~isfield(jsonData.varsNumber.preTargetDelayDuration, 'value'), jsonData.varsNumber.preTargetDelayDuration.value = 0.5;end
if ~isfield(jsonData.varsNumber.preTargetDelayDuration, 'min'), jsonData.varsNumber.preTargetDelayDuration.min = 0.0;end
if ~isfield(jsonData.varsNumber.preTargetDelayDuration, 'max'), jsonData.varsNumber.preTargetDelayDuration.max = 10.0;end
jsonData.varsNumber.preTargetDelayDuration.precision= 0;
jsonData.varsNumber.preTargetDelayDuration.isRange= true;
jsonData.varsNumber.preTargetDelayDuration.hidden= false;
end


jsonData.varsNumber.itiDuration.name = 'ITI Duration';
if ~isfield(jsonData.varsNumber.itiDuration, 'value'), jsonData.varsNumber.itiDuration.value = 0.3;end
if ~isfield(jsonData.varsNumber.itiDuration, 'min'), jsonData.varsNumber.itiDuration.min = 0.0;end
if ~isfield(jsonData.varsNumber.itiDuration, 'max'), jsonData.varsNumber.itiDuration.max = 10.0;end
jsonData.varsNumber.itiDuration.precision= 0;
jsonData.varsNumber.itiDuration.isRange= true;
jsonData.varsNumber.itiDuration.hidden= false;

% jsonData.varsBoolean = {};
% jsonData.varsString = {};
% 
% configUIstring=jsonencode(jsonData,'PrettyPrint',true);
% 

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





% --- --- --- --- --- --- --- --- --- ---
% --- StimDef
% --- --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_StimDefConfig_WorkingMemory_01(iPath, iFilename, stimDef)

%iFilename_StimDef  = sprintf('%s_Set%02d_StimDef',iFilname);
fPtr = fopen([iPath iFilename ],'w');
stimdef_header=['StimIndex' '\t' 'FileName' '\t' 'PrefabPath' ];

fprintf(fPtr,stimdef_header);
for iS = 1:length(stimDef.StimCode)
    iString = sprintf('%d\t%s\t""', ...
        stimDef.StimCode(iS),...
        stimDef.StimName{iS});
    %       StimDef.tokenReward{iS},...
    fprintf(fPtr, '\n %s', iString);
end
fclose(fPtr);
fprintf('\n wrote %s.\n', [ iFilename ]);






%  --- --- --- --- --- --- --- ---
%  --- TaskConfig
%  --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_TaskConfig_WorkingMemory_01(iPath, iFilename, taskconfig)
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


