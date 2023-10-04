function [cfg] = make_VisualSearch_configs_01(cfg,iExpName,iContextName)
% --- this script generates the Visual Search task


if isempty(cfg)
    cfg.iSet = 1;
    cfg.isWebGL = 0;
end
if ~isfield(cfg, 'isWebGL')
    cfg.isWebGL = 0;
end

% iExpName = 'VisualSearch1';
% [a,typeID,c] = intersect(cfg.contexts.types,'Grass');
% context_idx = find(cfg.contexts.typeID==typeID);
% cfg.vs_contextName = cfg.contexts.name{context_idx(randi(length(context_idx)))};
% cfg.vs_nSearchTrials = 200;
% [cfg] = make_configs_VisualSearch_01(cfg,iExpName)
if nargin<3
    iContextName = cfg.vs_contextName
elseif isempty(iContextName)
    iContextName        = 'Grass';
end

cfg.out_visualSearch = [];
cfg.out_visualSearch.experimentName = [];
cfg.out_visualSearch.taskFolderName = [];
cfg.out_visualSearch.iPath = [];
if ~exist(cfg.sessionPathName), mkdir(cfg.sessionPathName), end

% numTrials_minMax = [26 50];
cfg_VS = [];
cfg_VS.numTokens     = 8;
cfg_VS.numInitialTokens    = 2;
cfg_VS.NumRewardPulses     = 3;
cfg_VS.RewardPulseSize     = 250;

experimentName      = sprintf('VisualSearch_12d_%s_Set%.2d',iExpName,cfg.iSet);
cfg.out_visualSearch.experimentName = experimentName;
% task folder has to be the same name as exp name
cfg.out_visualSearch.taskFolderName = experimentName;%sprintf('VisualSearch_%s_Set_%.2d',iExpName,cfg.iSet);

cfg.out_visualSearch.iPath = [ cfg.sessionPathName '/'  cfg.out_visualSearch.taskFolderName '/'];
if ~exist(cfg.out_visualSearch.iPath), mkdir(cfg.out_visualSearch.iPath), end

nDimensions         = 2; % 3;



%cfg_VS.iEccentricity       = 5.5;


% --- --- --- --- --- --- --- --- ---
% --- Contexts
% --- --- --- --- --- --- --- --- ---

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
nFeaturesPerDim = 8;
%allLocationPossibilities =  get_locationsEquiEccentric_02(iEccentricity);




% --- --- --- --- --- --- --- --- ---
% --- initialize block information
% --- --- --- --- --- --- --- --- ---
blockdata = [];
blockdata.blockname ={};
blockdata.blocknum = [];
blockdata.ContextName = {};
blockdata.minmaxtrials = [];
blockdata.numTokens = [];
blockdata.numInitialTokens = [];
blockdata.PulseReward = {};
%blockdata.NumPulses = [];
blockdata.PulseSize = [];

% --- --- --- --- --- --- --- --- ---
% --- specify token conditions
% --- --- --- --- --- --- --- --- ---

tokenCondition = [];
iCnd = 1;
tokenCondition{iCnd}.numInitialTokens = 0;
tokenCondition{iCnd}.TokenGain = 2;
tokenCondition{iCnd}.TokenLoss = 0;
tokenCondition{iCnd}.name = 'g2l0';

% --- --- --- --- --- --- --- --- ---
% ---  get trials definitions
% --- --- --- --- --- --- --- --- ---
[a,b,CTX_ind]=intersect('Grass',contextNames);
cfg_VS.setSizeConditions = [3 6 9 12];
cfg_VS.contextName = contextNames{CTX_ind};
cfg_VS.nFeaturesPerDim = nFeaturesPerDim;

if ~isfield(cfg,'vs_nSearchTrials')
    cfg_VS.nTrials  = 300;
else
    cfg_VS.nTrials  = cfg.vs_nSearchTrials;
end
[trl] = get_visualSearchBlock_02(cfg_VS)
trl.ContextName = {};
trl.TokenGain = [];
trl.TokenLoss = [];
iCnd = 1;
for iT=1:length(trl.objectVector)
    trl.TokenGain(iT) = tokenCondition{iCnd}.TokenGain;
    trl.TokenLoss(iT) = tokenCondition{iCnd}.TokenLoss;
end
% --- --- --- --- --- --- --- --- ---
% ---  get stimulus definitions for targets and distractor:
% --- --- --- --- --- --- --- --- ---
stimDef = [];
stimDef.StimIndex = [];
stimDef.StimName = [];
stimDef.stimValues = [];


[a,b,c]=unique(trl.objectVectorAll,'rows');
stimDef.stimValues = trl.objectVectorAll(b,:);
[stimDef.StimName] = get_Quaddle1Name_01(Q1,stimDef.stimValues);
stimDef.StimIndex = 0:length(stimDef.StimName)-1;


% disp('fff'), return

% --- add the stimcode to the individual trials
trl.objectVectorCode = {};
for iT=1:length(trl.objectVector)
    for iV=1:size(trl.objectVector{iT},1)
[a,b,stimcodeIDX]=intersect(trl.objectVector{iT}(iV,:),stimDef.stimValues,'rows');
        % stimindices correspond to (stimValues number - 1)
        trl.objectVectorCode{iT}(iV)=stimDef.StimIndex(stimcodeIDX);% stimcodeIDX;
        %trl.objectVectorCode{iT}(iV)=stimcodeIDX;
    end
end

% --- --- --- --- --- --- --- --- ---
% --- add basic block information
% --- --- --- --- --- --- --- --- ---
nBlocks = 1;%length(blockdata.blockname);
for iB=1:nBlocks
    blockdata.blockname{iB} = 'VisSearch';
    blockdata.blocknum(iB) = iB;
    blockdata.ContextName{iB}  = cfg_VS.contextName;
    blockdata.numTokens(iB)  = cfg_VS.numTokens;
    blockdata.numInitialTokens(iB) = cfg_VS.numInitialTokens;
    %blockdata.NumPulses(iB) = cfg_VS.NumRewardPulses;
    blockdata.PulseReward{iB} = sprintf('[{"NumReward":%d,"Probability":1.0}]', cfg_VS.NumRewardPulses); %, {"NumReward":1, "Probability":0.2}];
    blockdata.PulseSize(iB) = cfg_VS.RewardPulseSize;


    blockdata.TokensWithStimOn{iB} = 'False';
end

% --- --- --- --- --- --- --- --- ---
% --- write StimDef config file
% --- --- --- --- --- --- --- --- ---
iFilename = [cfg.out_visualSearch.experimentName '_StimDef_array.txt'];
write_StimDefConfig_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, stimDef);

% --- --- --- --- --- --- --- --- ---
% --- write BlockDef config file
% --- --- --- --- --- --- --- --- ---
iFilename = [cfg.out_visualSearch.experimentName '_BlockDef_array.txt'];
write_BlockDefConfig_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, blockdata);

% --- --- --- --- --- --- --- --- ---
% --- write TrialDef config file
% --- --- --- --- --- --- --- --- ---
iFilename = [cfg.out_visualSearch.experimentName '_TrialDef_array.txt'];
write_TrialDefConfig_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, trl);


% --- --- --- --- --- --- --- --- ---
% --- write ConfigUiDetails jason, eventCode jason, and SynchboxDef txt file
% --- --- --- --- --- --- --- --- ---
jsonData = [];
iFilename = [cfg.out_visualSearch.experimentName '_ConfigUiDetails_json']; % this will be a jason file
write_ConfigUIDetails_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, jsonData);
%SynchBoxDefInfo = {};
%iFilename = [cfg.out_visualSearch.experimentName '_SyncBoxDef.txt'];
%write_SynchBoxDef_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, SynchBoxDefInfo)
%eventCodeInfo = [];
%iFilename = [cfg.out_visualSearch.experimentName '_EventCodeConfig']; % this will be a jason file
%write_EventCode_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, eventCodeInfo);
% [iFilename, iPath] = write_ConfigUIDetails_WorkingMemory_01(iPath, iFilename, jsonData)



% --- --- --- --- --- --- --- --- ---
% --- write TaskDef config file
% --- --- --- --- --- --- --- --- ---
taskconfig = [];
if cfg.isWebGL == 1
    taskconfig{end+1} = 'float	ExternalStimScale	5.5';
    taskconfig{end+1} = 'float	StartButtonScale	1.2';% 125';%(0.1, 0.1, 0.1)
else
    taskconfig{end+1} = sprintf('string	ExternalStimFolderPath	%s',cfg.externalStimFolderPath_Quaddle1);
    taskconfig{end+1} = 'float	ExternalStimScale	0.07';
    %taskconfig{end+1} = 'Vector3	ButtonScale	(5, 5, 5)';%(0.1, 0.1, 0.1)
    taskconfig{end+1} = 'float	StartButtonScale	1';% 125';%(0.1, 0.1, 0.1)
    %taskconfig{end+1} = 'Vector3	FBSquarePosition	(0, 0, -400)';
    %taskconfig{end+1} = 'float	FBSquareScale	75';
    %taskconfig{end+1} = sprintf('string	ContextExternalFilePath	%s',cfg.externalFilePath);
    %taskconfig{end+1} = sprintf('string	ExternalStimFolderPath	%s',cfg.externalStimFolderPath_Quaddle1);
    %taskconfig{end+1} = 'string	ExternalStimExtension	""'; %".fbx" fbx ending needed here if the stimdef does not specify ending
    %taskconfig{end+1} = 'float	ExternalStimScale	0.03';
    %taskconfig{end+1} = 'Vector3	ButtonPosition	(0, 0, 0)';
    %taskconfig{end+1} = 'Vector3	ButtonScale	(0.1, 0.1, 0.1)';
    %taskconfig{end+1} = 'List<string>	FeedbackControllers	["Audio", "Halo", "Token"]';
end
taskconfig{end+1} = 'float	TouchFeedbackDuration	0.3';
taskconfig{end+1} = 'string	ExternalStimExtension	""'; %.fbx
taskconfig{end+1} = 'bool	StimFacingCamera	TRUE'; %.fbx
taskconfig{end+1} = 'Vector3	StartButtonPosition	[0, 0, 0]';
taskconfig{end+1} = 'string	ShadowType	"None"';
taskconfig{end+1} = 'List<string>	FeedbackControllers	["Audio", "Halo", "Token"]';
taskconfig{end+1} = 'bool	NeutralITI	false';

iFilename = [cfg.out_visualSearch.experimentName  '_TaskDef_singleType.txt'];
[iFilename, iPath] = write_TaskConfig_VisualSearch_01(cfg.out_visualSearch.iPath,iFilename, taskconfig);

fprintf('\ndone with iSet %.2d',cfg.iSet)

% end
fprintf('.\n')

%disp('done, returning'), return





%% --- --- --- --- --- --- --- --- --- ---
% --- StimDef
% --- --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_StimDefConfig_VisualSearch_01(iPath, iFilename, stimDef)

fPtr = fopen([iPath iFilename ],'w');
%stimdef_header=['StimIndex' '\t' 'ExternalFilePath' '\t' 'PrefabPath'];
stimdef_header=['StimIndex' '\t' 'FileName' '\t' 'PrefabPath'];

fprintf(fPtr,stimdef_header);
for iS = 1:length(stimDef.StimIndex)
    iString = sprintf('%d\t%s\t""', ...
        stimDef.StimIndex(iS),...
        stimDef.StimName{iS});
    %       StimDef.tokenReward{iS},...
    fprintf(fPtr, '\n %s', iString);
end
fclose(fPtr);

fprintf('\n wrote %s', [ iFilename ]);


%% --- --- --- --- --- --- --- --- --- ---
% --- Trialdef
% --- --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_TrialDefConfig_VisualSearch_01(iPath, iFilename, trl)
fPtr = fopen([iPath iFilename],'w');
trialdef_header=['TrialID' '\t' 'BlockCount' '\t' 'TrialStimIndices' '\t' 'TrialStimLocations' '\t' 'ProbabilisticTrialStimTokenReward' '\t' 'RandomizedLocations' ];

iBlockNum = 1;
fprintf(fPtr,trialdef_header);
for iT = 1:length(trl.objectVectorCode)
    StimIndices   = '';
    StimLocations = '';
    StimTokenReward='';
    for iS=1:length(trl.objectVectorCode{iT})
        if iS==1
            StimIndices = sprintf('%d',trl.objectVectorCode{iT}(iS));
            StimLocations = sprintf('[%.2f,%.2f, 0.0]',trl.objectXYZ{iT}(iS,1),trl.objectXYZ{iT}(iS,3));
            StimTokenReward = sprintf('[{"NumReward":%d,"Probability":1}]', trl.TokenGain(iT));
            %StimTokenReward = sprintf('[{"NumTokens":%d,"Probability":1}]', trl.TokenGain(iT));
            % '[[{"NumTokens":3,"Probability":1}], [{"NumTokens":-1,"Probability":1}]]'
            % '[[{"NumTokens":3,"Probability":1}], [{"NumTokens":-1,"Probability":1}]]'
        else
            StimIndices = sprintf('%s,%d',StimIndices,trl.objectVectorCode{iT}(iS));
            StimLocations = sprintf('%s,[%.2f, %.2f, 0.0]',StimLocations,trl.objectXYZ{iT}(iS,1),trl.objectXYZ{iT}(iS,3));
            StimTokenReward = sprintf('%s, [{"NumReward":%d,"Probability":1}]',StimTokenReward,trl.TokenLoss(iT));
        end
    end
    StimIndices   = sprintf('[%s]',StimIndices);
    StimLocations = sprintf('[%s]',StimLocations);
    StimTokenReward = sprintf('[%s]',StimTokenReward);

    iString = sprintf('%s\t%d\t%s\t%s\t%s\tFALSE', ...
        trl.TrialID{iT},...
        iBlockNum,...
        StimIndices, ...
        StimLocations, ...
        StimTokenReward);

    %disp('w'), return
    fprintf(fPtr, '\n %s', iString);
end

fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);



%% --- --- --- --- --- --- --- --- --- ---
% --- BlockDefDef
% --- --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_BlockDefConfig_VisualSearch_01(iPath, iFilename, blockdata)
fPtr = fopen([iPath iFilename],'w');
%blockdef_header=['BlockName' '\t' 'BlockCount' '\t' 'ContextName' '\t' 'NumInitialTokens' '\t' 'NumTokenBar' '\t' 'ProbabilisticNumPulses' '\t' 'PulseSize' '\t' 'TokensWithStimOn'];
blockdef_header=['BlockName' '\t' 'BlockCount' '\t' 'ContextName' '\t' 'NumInitialTokens' '\t' 'TokenBarCapacity' '\t' 'ProbabilisticNumPulses' '\t' 'PulseSize' '\t' 'TokensWithStimOn'];

fprintf(fPtr,blockdef_header);
for iB = 1:length(blockdata.blockname)

    iString = sprintf('%s\t%d\t%s\t%d\t%d\t%s\t%d\t%s', ...
        blockdata.blockname{iB}, ...
        blockdata.blocknum(iB), ...
        blockdata.ContextName{iB},...
        blockdata.numInitialTokens(iB), ...
        blockdata.numTokens(iB), ...
        blockdata.PulseReward{iB}, ...
        blockdata.PulseSize(iB),...
        blockdata.TokensWithStimOn{iB});
    fprintf(fPtr, '\n %s', iString);

    %    [{"NumReward":3,"Probability":0.8}, {"NumReward":1, "Probability":0.2}]

end
fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);



% --- --- --- --- --- --- --- --- --- ---
% --- ConfigUIDef
% --- --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_ConfigUIDetails_VisualSearch_01(iPath, iFilename, jsonData)



jsonData.varsNumber.selectObjectDuration.name = 'Select Object Duration';
if ~isfield(jsonData.varsNumber.selectObjectDuration, 'value'), jsonData.varsNumber.selectObjectDuration.value = 5;end
if ~isfield(jsonData.varsNumber.selectObjectDuration, 'min'), jsonData.varsNumber.selectObjectDuration.min = 1.0;end
if ~isfield(jsonData.varsNumber.selectObjectDuration, 'max'), jsonData.varsNumber.selectObjectDuration.max = 20.0;end
jsonData.varsNumber.selectObjectDuration.precision= 1;
jsonData.varsNumber.selectObjectDuration.isRange= 1;
jsonData.varsNumber.selectObjectDuration.hidden= 0;

jsonData.varsNumber.minObjectTouchDuration.name = 'Min Object Touch Duration';
if ~isfield(jsonData.varsNumber.minObjectTouchDuration, 'value'), jsonData.varsNumber.minObjectTouchDuration.value = 0.1; end%0.05
if ~isfield(jsonData.varsNumber.minObjectTouchDuration, 'min'), jsonData.varsNumber.minObjectTouchDuration.min = 0.01;end
if ~isfield(jsonData.varsNumber.minObjectTouchDuration, 'max'), jsonData.varsNumber.minObjectTouchDuration.max = 1.0;end
jsonData.varsNumber.minObjectTouchDuration.precision= 1;
jsonData.varsNumber.minObjectTouchDuration.isRange= 1;
jsonData.varsNumber.minObjectTouchDuration.hidden= 0;

jsonData.varsNumber.maxObjectTouchDuration.name = 'Max Object Touch Duration';
if ~isfield(jsonData.varsNumber.maxObjectTouchDuration, 'value'), jsonData.varsNumber.maxObjectTouchDuration.value = 2.5; end%`
if ~isfield(jsonData.varsNumber.maxObjectTouchDuration, 'min'), jsonData.varsNumber.maxObjectTouchDuration.min = 0.01;end
if ~isfield(jsonData.varsNumber.maxObjectTouchDuration, 'max'), jsonData.varsNumber.maxObjectTouchDuration.max = 4.0;end
jsonData.varsNumber.maxObjectTouchDuration.precision= 1;
jsonData.varsNumber.maxObjectTouchDuration.isRange= 1;
jsonData.varsNumber.maxObjectTouchDuration.hidden= 0;

jsonData.varsNumber.tokenRevealDuration.name = 'Token Reveal Duration';
if ~isfield(jsonData.varsNumber.tokenRevealDuration, 'value'), jsonData.varsNumber.tokenRevealDuration.value = 0.2;end
if ~isfield(jsonData.varsNumber.tokenRevealDuration, 'min'), jsonData.varsNumber.tokenRevealDuration.min = 0.0;end
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
jsonData.varsNumber.itiDuration.precision= 1 ;
jsonData.varsNumber.itiDuration.isRange= true;
jsonData.varsNumber.itiDuration.hidden= false;

jsonData.varsNumber.fbDuration.name = 'fbDuration';
if ~isfield(jsonData.varsNumber.fbDuration, 'value'), jsonData.varsNumber.fbDuration.value = 0.25;end
if ~isfield(jsonData.varsNumber.fbDuration, 'min'), jsonData.varsNumber.fbDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.fbDuration, 'max'), jsonData.varsNumber.fbDuration.max = 10.0;end
jsonData.varsNumber.fbDuration.precision= 1;
jsonData.varsNumber.fbDuration.isRange= true;
jsonData.varsNumber.fbDuration.hidden= false;

jsonData.varsNumber.searchDisplayDelay.name = 'Search Display Delay';
if ~isfield(jsonData.varsNumber.searchDisplayDelay, 'value'), jsonData.varsNumber.searchDisplayDelay.value = 0.3;end
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





%  --- --- --- --- --- --- --- ---
%  --- TaskConfig
%  --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_TaskConfig_VisualSearch_01(iPath, iFilename, taskconfig)
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
