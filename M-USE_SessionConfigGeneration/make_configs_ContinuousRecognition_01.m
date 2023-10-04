function [cfg] = make_ContinuousRecognition_configs_01(cfg,iExpName)
% --- this script generates the Set shifting "FlexLearningGainLoss" task
% --- it varies for 2D
if isempty(cfg)
    cfg.iSet = 1;
    cfg.isWebGL = 0;
end
if ~isfield(cfg, 'isWebGL')
    cfg.isWebGL = 0;
end

if ~isfield(cfg, 'CR_nblocks')
    cfg_CR.nBlocks = 2;
else
    cfg_CR.nBlocks = cfg.CR_nblocks;
end

cfg.out_continuousRecognition = [];
cfg.out_continuousRecognition.experimentName = [];
cfg.out_continuousRecognition.taskFolderName = [];
cfg.out_continuousRecognition.iPath = [];

if ~exist(cfg.sessionPathName), mkdir(cfg.sessionPathName), end

%experimentName      = sprintf('VisualSearch_12d_%s_Set%.2d',iExpName,cfg.iSet);

if isempty(iExpName)
    cfg.out_continuousRecognition.experimentName =  sprintf('ContinuousRecognition_v01');
    cfg.out_continuousRecognition.taskFolderName = sprintf('ContinuousRecognition_Set_%.2d/',cfg.iSet);
else
    cfg.out_continuousRecognition.experimentName =  iExpName;
    cfg.out_continuousRecognition.taskFolderName = sprintf('%s_Set_%.2d/',iExpName,cfg.iSet);
end

cfg.out_continuousRecognition.iPath = [cfg.sessionPathName '/' cfg.out_continuousRecognition.taskFolderName];

%iPath = [ cfg.sessionPathName cfg.out_flexLearn.taskFolderName];
if ~exist(cfg.out_continuousRecognition.iPath), mkdir(cfg.out_continuousRecognition.iPath), end

iContext = {'011_058_014_001_4','011_058_069_001_2'}

for iBL = 1: cfg_CR.nBlocks

    cfg_CR.blockconditionName{iBL}  = sprintf('CR_Q1_4D_rnd_3-1-1_b%d',iBL); %Q1 quaddles 1's, 4D... 4 features vary, rnd=random selection quaddle feature values
    cfg_CR.numObjectsMinMax{iBL}    = [2 7]; % is maximal number of stimuli
    cfg_CR.nObjects{iBL}            = max(cfg_CR.numObjectsMinMax{iBL}) .* 2;
    cfg_CR.stimulusRatio{iBL}       = [3 1 1]; % proportion of stimuli that were: prev Chosen, prev not chosen, new
    cfg_CR.contextName{iBL}         = iContext{iBL};%'Dirt'; %
    cfg_CR.xLocations{iBL}          = [-2.5:0.33:2.5]; %
    cfg_CR.yLocations{iBL}          = [-2.0:0.33:2.0]; %
    cfg_CR.numTokens(iBL)           = 3;
end

% iBL = 2;
% cfg_CR.blockconditionName{iBL}  = 'CR_Q1_4D_rnd_3-1-1_b2';
% cfg_CR.numObjectsMinMax{iBL}    = [2 7]; % is maximal number of stimuli
% cfg_CR.nObjects{iBL}            = max(cfg_CR.numObjectsMinMax{iBL}) .* 2;
% cfg_CR.stimulusRatio{iBL}       = [3 1 1];
% cfg_CR.contextName{iBL}         = 'Gravel';
% cfg_CR.xLocations{iBL}          = [-2.5:0.33:2.5]; %
% cfg_CR.yLocations{iBL}          = [-2.0:0.33:2.0]; %
% cfg_CR.numTokens(iBL)           = 3;

%ContextName	FindAllStim	ManuallySpecifyLocation	StimFacingCamera	NumTokenBar	NumRewardPulses	PulseSize	RewardMag	BlockName	BlockStimIndices	NumObjectsMinMax	InitialStimRatio	DisplayStimsDuration	ChooseStimDuration	TrialEndDuration	TouchFeedbackDuration	DisplayResultDuration	TokenUpdateDuration	TokenRevealDuration	BlockStimLocations	X_Locations	Y_Locations	X_FbLocations	Y_FbLocations
%FindAllStim

%cfg_CR.TokenGain           = 1;
%cfg_CR.TokenLoss           = 0;
%cfg_CR.numInitialTokens = 0;
cfg_CR.FindAllStim = 'TRUE';
cfg_CR.NumRewardPulses = 3;
cfg_CR.PulseSize = 50;%cfg_CR.RewardPulseSize = 50;
cfg_CR.RewardMag = 2;
cfg_CR.ChooseStimDuration = 2;
cfg_CR.TouchFeedbackDuration = 0.3;
cfg_CR.TokenRevealDuration = 0.4;
cfg_CR.TokenUpdateDuration  = 0.3;
cfg_CR.TrialEndDuration = 0.5;



contextNames = {'Concrete';
    'Desert';
    'Dirt';
    'Fall';
    'Grass';
    'Gravel';
    'Ice';
    'Moss';
    'Mud';
    'Snow';
    'Tile';
    'Winter';
    'Blank'}

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
cfg_CR.nFeaturesPerDim = 8;

blockdef = [];
stimDef = [];
[blockdef, stimDef] = get_continuousRecognitionBlock_01(cfg_CR)
% only show
% [stimDef.StimCode,bIndices]=unique(stimDef.StimCode,'rows');
% stimDef.StimValues = stimDef.StimValues(bIndices);
[stimDef.StimName] = get_Quaddle1Name_01(Q1,stimDef.StimValues);



% --- --- --- --- --- --- --- --- ---
% --- write StimDef config file
% --- --- --- --- --- --- --- --- ---

iFilename = [cfg.out_continuousRecognition.experimentName '_StimDef_array.txt'];
write_StimDefConfig_ContinuousRecognition_01(cfg.out_continuousRecognition.iPath, iFilename, stimDef);


% --- --- --- --- --- --- --- --- ---
% --- write BlockDef config file
% --- --- --- --- --- --- --- --- ---
iFilename = [cfg.out_continuousRecognition.experimentName '_BlockDef_array.txt'];
write_BlockDefConfig_ContinuousRecognition_01(cfg.out_continuousRecognition.iPath, iFilename, blockdef);


% --- --- --- --- --- --- --- --- ---
% --- write ConfigUiDetails jason, eventCode jason, and SynchboxDef txt file
% --- --- --- --- --- --- --- --- ---
jsonData = [];

iFilename = [cfg.out_continuousRecognition.experimentName '_ConfigUiDetails_json']; % this will be a jason file
%write_ContinuousRecognition_01(cfg.out_continuousRecognition.iPath, iFilename, jsonData);
%SynchBoxDefInfo = {};
%iFilename = [cfg.out_continuousRecognition.experimentName '_SyncBoxDef.txt'];
%write_ContinuousRecognition_FlexLearning_01(cfg.out_continuousRecognition.iPath, iFilename, SynchBoxDefInfo)
%eventCodeInfo = [];
%iFilename = [cfg.out_continuousRecognition.experimentName '_EventCodeConfig']; % this will be a jason file
%write_ContinuousRecognition_FlexLearning_01(cfg.out_continuousRecognition.iPath, iFilename, eventCodeInfo);
jsonData = [];
if cfg.isWebGL == 1
    jsonData.varsNumber.chooseStimDuration.value = 6;
    jsonData.varsNumber.chooseStimDuration.min = 1;
    jsonData.varsNumber.chooseStimDuration.max = 20;

    jsonData.varsNumber.minObjectTouchDuration.value = 0.001;
    jsonData.varsNumber.minObjectTouchDuration.min = 0.001;
    jsonData.varsNumber.minObjectTouchDuration.max = 5.0;
end
[iFilename, iPath] = write_ConfigUIDetails_ContinuousRecognition_01(cfg.out_continuousRecognition.iPath, iFilename, jsonData)



% --- --- --- --- --- --- --- --- ---
% --- write TaskDef config file
% --- --- --- --- --- --- --- --- ---
taskconfig = [];
if cfg.isWebGL == 1
    taskconfig{end+1} = 'float	ExternalStimScale	0.8';
    taskconfig{end+1} = 'Vector3	ButtonPosition	(0,0,0)';
    taskconfig{end+1} = 'float	ButtonScale	1.2';
    taskconfig{end+1} = 'bool	MakeStimPopOut false';
    taskconfig{end+1} = 'float	TouchFeedbackDuration   0.3';
    taskconfig{end+1} = 'List<string>	FeedbackControllers	["Audio", "Halo", "Token"]';
    taskconfig{end+1} = 'float	ShadowType   1';
    taskconfig{end+1} = 'float	StimFacingCamera   1';

else
    taskconfig{end+1} = sprintf('string	ContextExternalFilePath	%s',cfg.externalFilePath);
    taskconfig{end+1} = sprintf('string	ExternalStimFolderPath	%s',cfg.externalStimFolderPath_Quaddle1);
    taskconfig{end+1} = 'string	ExternalStimExtension	""'; %".fbx" fbx ending needed here if the stimdef does not specify ending
    taskconfig{end+1} = 'float	ExternalStimScale	0.03';
    taskconfig{end+1} = 'Vector3	ButtonPosition	[0, 0, 0]';
    taskconfig{end+1} = 'Vector3	ButtonScale	[0.1, 0.1, 0.1]';
    taskconfig{end+1} = 'List<string>	FeedbackControllers	["Audio", "Halo", "Token"]';
end
iFilename = [cfg.out_continuousRecognition.experimentName  '_TaskDef_singleType.txt'];
[iFilename, iPath] = write_TaskConfig_ContinuousRecognition_01(cfg.out_continuousRecognition.iPath,iFilename, taskconfig);

fprintf('\ndone with iSet %.2d',cfg.iSet)
sprintf('returning...\n')
return,


% --- --- --- --- --- --- --- --- --- ---
% --- StimDef
% --- --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_StimDefConfig_ContinuousRecognition_01(iPath, iFilename, stimDef)

fPtr = fopen([iPath iFilename ],'w');
stimdef_header=['StimIndex' '\t' 'FileName' '\t' 'PrefabPath'];

fprintf(fPtr,stimdef_header);
for iS = 1:length(stimDef.StimCode)
    iString = sprintf('%d\t%s\t""', ...
        stimDef.StimCode(iS),...
        stimDef.StimName{iS});
    fprintf(fPtr, '\n %s', iString);
end
fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);


% --- --- --- --- --- --- --- --- --- ---
% --- BlockDef
% --- --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_BlockDefConfig_ContinuousRecognition_01(iPath, iFilename, blockdef)

fPtr = fopen([iPath iFilename],'w');
%blockdef_header=['BlockName' '\t' 'FindAllStim' '\t' 'ManuallySpecifyLocation' '\t' 'StimFacingCamera' '\t' 'ContextName' '\t'...
%    'NumInitialTokens', '\t' 'TokenBarCapacity' '\t' 'NumRewardPulses' '\t' 'PulseSize' '\t' 'RewardMag' '\t' 'BlockStimIndices' '\t' 'NumObjectsMinMax' '\t' 'InitialStimRatio' '\t' ...
blockdef_header=['BlockName' '\t' 'FindAllStim' '\t' 'ManuallySpecifyLocation'  '\t' 'ContextName' '\t'...
    'NumInitialTokens', '\t' 'TokenBarCapacity' '\t' 'NumRewardPulses' '\t' 'PulseSize' '\t' 'RewardMag' '\t' 'BlockStimIndices' '\t' 'NumObjectsMinMax' '\t' 'InitialStimRatio' '\t' ...
    'DisplayStimsDuration' '\t' 'ChooseStimDuration' '\t' 'TrialEndDuration' '\t' 'TouchFeedbackDuration ' '\t' 'DisplayResultDuration' '\t' 'TokenUpdateDuration' '\t'	...
    'TokenRevealDuration' '\t' 'BlockStimLocations' '\t' 'X_Locations' '\t' 'Y_Locations' '\t' 'X_FbLocations' '\t' 'Y_FbLocations'  '\t' 'ShakeStim']

%removed:
%3    ShadowType,...
%6    StimFacingCamera, ...
%UseStarfield,...
    

iBL = 1;

% --- adding some defaults
ShadowType =  'None';
UseStarfield =  'false';
InitialTokenAmount = 0;

fprintf(fPtr,blockdef_header);
iString = sprintf('%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s', ...
    blockdef(iBL).BlockName, ...
    blockdef(iBL).FindAllStim, ...
    blockdef(iBL).ManuallySpecifyLocation, ...
    blockdef(iBL).ContextName, ...
    InitialTokenAmount,...
    blockdef(iBL).NumTokenBar, ...
    blockdef(iBL).NumRewardPulses, ...
    blockdef(iBL).PulseSize, ...
    blockdef(iBL).RewardMag, ...
    blockdef(iBL).BlockStimIndices, ...
    blockdef(iBL).NumObjectsMinMax, ...
    blockdef(iBL).InitialStimRatio, ...
    blockdef(iBL).DisplayStimsDuration, ...
    blockdef(iBL).ChooseStimDuration, ...
    blockdef(iBL).TrialEndDuration, ...
    blockdef(iBL).TouchFeedbackDuration, ...
    blockdef(iBL).DisplayResultDuration, ...
    blockdef(iBL).TokenUpdateDuration, ...
    blockdef(iBL).TokenRevealDuration, ...
    blockdef(iBL).BlockStimLocations, ...
    blockdef(iBL).X_Locations, ...
    blockdef(iBL).Y_Locations, ...
    blockdef(iBL).X_FbLocations, ...
    blockdef(iBL).Y_FbLocations,...
    'false');

fprintf(fPtr, '\n %s', iString);
%end
fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);



% --- --- --- --- --- --- --- --- --- ---
% --- ConfigUIDef
% --- --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_ConfigUIDetails_ContinuousRecognition_01(iPath, iFilename, jsonData)

if isempty(jsonData), jsonData = []; end

jsonData.varsNumber.chooseStimDuration.name = 'Choose Stim Duration';
if ~isfield(jsonData.varsNumber.chooseStimDuration, 'value'), jsonData.varsNumber.chooseStimDuration.value = 0.4; end
if ~isfield(jsonData.varsNumber.chooseStimDuration, 'min'), jsonData.varsNumber.chooseStimDuration.min = 0;end
if ~isfield(jsonData.varsNumber.chooseStimDuration, 'max'), jsonData.varsNumber.chooseStimDuration.max = 10;end
jsonData.varsNumber.chooseStimDuration.precision= 0;
jsonData.varsNumber.chooseStimDuration.isRange= 1;
jsonData.varsNumber.chooseStimDuration.hidden= 0;

jsonData.varsNumber.minObjectTouchDuration.name = 'Min Object Touch Duration';
if ~isfield(jsonData.varsNumber.minObjectTouchDuration, 'value'), jsonData.varsNumber.minObjectTouchDuration.value = 0.05;end
if ~isfield(jsonData.varsNumber.minObjectTouchDuration, 'min'), jsonData.varsNumber.minObjectTouchDuration.min = 0.01;end
if ~isfield(jsonData.varsNumber.minObjectTouchDuration, 'max'), jsonData.varsNumber.minObjectTouchDuration.max = 5.0;end
jsonData.varsNumber.minObjectTouchDuration.precision= 1;
jsonData.varsNumber.minObjectTouchDuration.isRange= 1;
jsonData.varsNumber.minObjectTouchDuration.hidden= 0;

jsonData.varsNumber.maxObjectTouchDuration.name = 'Max Object Touch Duration';
if ~isfield(jsonData.varsNumber.maxObjectTouchDuration, 'value'), jsonData.varsNumber.maxObjectTouchDuration.value = 4.0;end
if ~isfield(jsonData.varsNumber.maxObjectTouchDuration, 'min'), jsonData.varsNumber.maxObjectTouchDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.maxObjectTouchDuration, 'max'), jsonData.varsNumber.maxObjectTouchDuration.max = 10.0;end
jsonData.varsNumber.maxObjectTouchDuration.precision= 1;
jsonData.varsNumber.maxObjectTouchDuration.isRange= 1;
jsonData.varsNumber.maxObjectTouchDuration.hidden= 0;


jsonData.varsNumber.gratingSquareDuration.name = 'Grating Square Duration';
if ~isfield(jsonData.varsNumber.gratingSquareDuration, 'value'), jsonData.varsNumber.gratingSquareDuration.value = 0.3;end
if ~isfield(jsonData.varsNumber.gratingSquareDuration, 'min'), jsonData.varsNumber.gratingSquareDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.gratingSquareDuration, 'max'), jsonData.varsNumber.gratingSquareDuration.max = 20.0;end
jsonData.varsNumber.gratingSquareDuration.precision= 1;
jsonData.varsNumber.gratingSquareDuration.isRange= 1;
jsonData.varsNumber.gratingSquareDuration.hidden= 0;

jsonData.varsNumber.displayStimDuration.name = 'Display Stim Duration';
if ~isfield(jsonData.varsNumber.displayStimDuration, 'value'), jsonData.varsNumber.displayStimDuration.value = 0.2;end
if ~isfield(jsonData.varsNumber.displayStimDuration, 'min'), jsonData.varsNumber.displayStimDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.displayStimDuration, 'max'), jsonData.varsNumber.displayStimDuration.max = 0.5;end
jsonData.varsNumber.displayStimDuration.precision= 0;
jsonData.varsNumber.displayStimDuration.isRange= 1;
jsonData.varsNumber.displayStimDuration.hidden= 0;

jsonData.varsNumber.itiDuration.name = 'Iti Duration';
if ~isfield(jsonData.varsNumber.itiDuration, 'value'), jsonData.varsNumber.itiDuration.value = 0.01;end
if ~isfield(jsonData.varsNumber.itiDuration, 'min'), jsonData.varsNumber.itiDuration.min = 0.01;end
if ~isfield(jsonData.varsNumber.itiDuration, 'max'), jsonData.varsNumber.itiDuration.max = 10.0;end
jsonData.varsNumber.itiDuration.precision= 0;
jsonData.varsNumber.itiDuration.isRange= 1;
jsonData.varsNumber.itiDuration.hidden= 0;

jsonData.varsNumber.touchFbDuration.name = 'Touch FB Duration';
if ~isfield(jsonData.varsNumber.touchFbDuration, 'value'), jsonData.varsNumber.touchFbDuration.value = 0.25;end
if ~isfield(jsonData.varsNumber.touchFbDuration, 'min'), jsonData.varsNumber.touchFbDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.touchFbDuration, 'max'), jsonData.varsNumber.touchFbDuration.max = 10.0;end
jsonData.varsNumber.touchFbDuration.precision= 0;
jsonData.varsNumber.touchFbDuration.isRange= 1;
jsonData.varsNumber.touchFbDuration.hidden= 0;


jsonData.varsNumber.tokenRevealDuration.name = 'Token Reveal Duration';
if ~isfield(jsonData.varsNumber.tokenRevealDuration, 'value'), jsonData.varsNumber.tokenRevealDuration.value = 0.5;end
if ~isfield(jsonData.varsNumber.tokenRevealDuration, 'min'), jsonData.varsNumber.tokenRevealDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.tokenRevealDuration, 'max'), jsonData.varsNumber.tokenRevealDuration.max = 3.0;end
jsonData.varsNumber.tokenRevealDuration.precision= 0;
jsonData.varsNumber.tokenRevealDuration.isRange= 1;
jsonData.varsNumber.tokenRevealDuration.hidden= 0;


jsonData.varsNumber.tokenUpdateDuration.name = 'Token Update Duration';
if ~isfield(jsonData.varsNumber.tokenUpdateDuration, 'value'), jsonData.varsNumber.tokenUpdateDuration.value = 0.5;end
if ~isfield(jsonData.varsNumber.tokenUpdateDuration, 'min'), jsonData.varsNumber.tokenUpdateDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.tokenUpdateDuration, 'max'), jsonData.varsNumber.tokenUpdateDuration.max = 3.0;end
jsonData.varsNumber.tokenUpdateDuration.precision= 0;
jsonData.varsNumber.tokenUpdateDuration.isRange= 1;
jsonData.varsNumber.tokenUpdateDuration.hidden= 0;

jsonData.varsNumber.displayResultsDuration.name = 'Display Results Duration';
if ~isfield(jsonData.varsNumber.displayResultsDuration, 'value'), jsonData.varsNumber.displayResultsDuration.value = 5.0;end
if ~isfield(jsonData.varsNumber.displayResultsDuration, 'min'), jsonData.varsNumber.displayResultsDuration.min = 1.0;end
if ~isfield(jsonData.varsNumber.displayResultsDuration, 'max'), jsonData.varsNumber.displayResultsDuration.max = 20.0;end
jsonData.varsNumber.displayResultsDuration.precision= 0;
jsonData.varsNumber.displayResultsDuration.isRange= 1;
jsonData.varsNumber.displayResultsDuration.hidden= 0;


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


%  --- --- --- --- --- --- --- ---
%  --- TaskConfig
%  --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_TaskConfig_ContinuousRecognition_01(iPath, iFilename, taskconfig)
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



