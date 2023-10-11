function [cfg] = make_EffortControl_configs_01(cfg,iExpName,iContextNames)
%function [cfg] = make_VisualSearch_configs_02(cfg,iExpName,iContextName)
% --- this script generates the Visual Search task

if isempty(cfg)
    cfg.iSet = 1;
    cfg.isWebGL = 0;
end
if ~isfield(cfg, 'isWebGL')
    cfg.isWebGL = 0;
end
if isfield(cfg, 'effortControl_maxTrials')
    effortControl_maxTrials = cfg.effortControl_maxTrials;
else
    effortControl_maxTrials= 120;
end

% --- --- --- --- --- --- --- --- --- --- --- 
% --- if the difficultyLevel is specified explicitly
% --- --- --- --- --- --- --- --- --- --- --- 
if isfield(cfg, 'effortControl_difficultyLevel')

    if cfg.effortControl_difficultyLevel == 2
        % difficulty level 1 to learn difference in efforts / outlines, all
        % same rewards
        cfg.effortControl.conditions_effortNTouches = [1 3 8];
        cfg.effortControl.conditions_rewardNTokens_NPulses = [ 5 2;...
            5 2;...
            5 2];
    elseif cfg.effortControl_difficultyLevel == 2
        % difficulty level 1 to experience effort and tokensize effects
        cfg.effortControl.conditions_effortNTouches = [1 3 8];
        cfg.effortControl.conditions_rewardNTokens_NPulses = [ 2 1;...
            6 2;...
            10 3];
    elseif cfg.effortControl_difficultyLevel == 3
        % difficulty level 2 to get more sensitive to effort
        cfg.effortControl.conditions_effortNTouches = [2 5 9 13 ];
        cfg.effortControl.conditions_rewardNTokens_NPulses = [ 2 1;...
            5 2;...
            9 3;...
            13 4];
    elseif cfg.effortControl_difficultyLevel == 4
        cfg.effortControl.conditions_clickPerOutline = 2;
        cfg.effortControl.conditions_effortNTouches = [5 10 15 20 ];
        cfg.effortControl.conditions_rewardNTokens_NPulses = [ 2 1;...
            5 2;...
            9 3;...
            13 4];
    end
end



if ~isfield(cfg,'contexts')
    cfg.contextRepositoryFolderPath = [pwd filesep 'ContextRepository_20221206/'];
    cfg.contexts                    = get_contextNames_01(cfg.contextRepositoryFolderPath)
end
[a,typeID,c] = intersect(cfg.contexts.types,'Sky');
context_idx = find(cfg.contexts.typeID==typeID);
tmp = randperm(length(context_idx));
cSel=tmp(1);

%default context is :
%iContextNames = {'011_058_021_001_3'};
if isempty(iContextNames)
    iContextNames = cfg.contexts.name(context_idx(cSel));
    for iC=1:length(iContextNames)
        tmp = findstr(iContextNames{iC},'.'); %remove .png
        if ~isempty(tmp), iContextNames{iC}(tmp(1):end) = [];
        end
    end
end

cfg_EC = [];

cfg.out_effortControl = [];
cfg.out_effortControl.experimentName = [];
cfg.out_effortControl.taskFolderName = [];
cfg.out_effortControl.iPath = [];
if ~exist(cfg.sessionPathName), mkdir(cfg.sessionPathName), end
cfg.out_effortControl.experimentName =  sprintf('EffortControl_v01_Set%.2d',cfg.iSet);
cfg.out_effortControl.taskFolderName = cfg.out_effortControl.experimentName;
cfg.out_effortControl.iPath = [cfg.sessionPathName '/' cfg.out_effortControl.taskFolderName '/'];
if ~exist(cfg.out_effortControl.iPath), mkdir(cfg.out_effortControl.iPath), end

% --- from here onwards: custom folders
effortControlConditions = [];

if ~isfield(cfg,'effortControl') | isempty(cfg.effortControl)
    conditions_clickPerOutline = 1;
    conditions_effortNTouches = [1 3 8];
    conditions_rewardNTokens_NPulses = [ 2 1;...
        6 2;...
        10 3];
    effortControl_maxTrials = 72;
else
    conditions_clickPerOutline = cfg.effortControl.conditions_clickPerOutline;
    conditions_effortNTouches = cfg.effortControl.conditions_effortNTouches;
    conditions_rewardNTokens_NPulses = cfg.effortControl.conditions_rewardNTokens_NPulses;
end

% --- --- --- --- --- --- --- --- --- --- --- --- ---
% --- determine all combinations of effort and reward
conditions_cmb_effort_token_rewPulses = [];
conditions_cmb_effort_token_rewPulses_name = {};
iCndID = 0;
for j=1:length(conditions_effortNTouches)
    for k=1:size(conditions_rewardNTokens_NPulses,1)
        iCndID =  iCndID+1;
        conditions_cmb_effort_token_rewPulses(iCndID,:) = [iCndID conditions_effortNTouches(j) conditions_rewardNTokens_NPulses(k,1:2)];
        conditions_cmb_effort_token_rewPulses_name{iCndID}  = sprintf('EC%d_%d',conditions_effortNTouches(j),conditions_rewardNTokens_NPulses(k,1));
    end
end

% --- --- --- --- --- --- --- --- --- --- --- --- ---
% --- determine numnber of trials:
cfg_EC.conditions_cmb_effort_token_rewPulses = conditions_cmb_effort_token_rewPulses;
cfg_EC.conditions_cmb_effort_token_rewPulses_name = conditions_cmb_effort_token_rewPulses_name;

% --- --- --- --- --- --- --- --- --- --- --- --- ---
% --- specify conditions
cfg_EC.BlockDefHeader = sprintf('BlockName\tNumTrials\tNumClicksLeft\tNumClicksRight\tNumCoinsLeft\tNumCoinsRight\tClicksPerOutline\tNumPulsesLeft\tNumPulsesRight\tPulseSizeLeft\tPulseSizeRight\tContextName');
cfg_EC.BlockDefRows = {};
cfg_EC.blockName = [];
cfg_EC.blockCondition = [];

iClicksPerOutline = conditions_clickPerOutline;
iPulseSizeLeft = 500;
iPulseSizeRight = 500;

% --- get all comnbinations first to have it comprehensive
cfg_EC.BlockDefRows = {};
nCnd = size(conditions_cmb_effort_token_rewPulses,1);
iT = 0;
for j=1:nCnd
    for k=j+1:nCnd
        % --- get two conditions
        %tmp = randperm(nCnd);
        %        C1 = conditions_cmb_effort_token_rewPulses(j,:);
        %        C1s = conditions_cmb_effort_token_rewPulses_name{j};
        %        C2 = conditions_cmb_effort_token_rewPulses(k,:);
        %        C2s = conditions_cmb_effort_token_rewPulses_name{k};

        C1 = [conditions_cmb_effort_token_rewPulses(j,2) conditions_cmb_effort_token_rewPulses(j,3) conditions_cmb_effort_token_rewPulses(j,4)];
        C1s = conditions_cmb_effort_token_rewPulses_name{j};
        C2 = [conditions_cmb_effort_token_rewPulses(k,2) conditions_cmb_effort_token_rewPulses(k,3) conditions_cmb_effort_token_rewPulses(k,4)];
        C2s = conditions_cmb_effort_token_rewPulses_name{k};

        % avoid same conditions
        if strcmp(C1s,C2s), continue, end

        % --- LEFT-RIGHT
        iT = iT+1;
        iBlockName = sprintf('%s-%s', C1s, C2s);
        cfg_EC.BlockDefRows{iT} = sprintf('%s\t1\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%s', ...
            iBlockName,...
            C1(1),...
            C2(1),...
            C1(2),...
            C2(2),...
            iClicksPerOutline,...
            C1(3),...
            C2(3),...
            iPulseSizeLeft,...
            iPulseSizeRight, ...
            iContextNames{1});

        % --- RIGHT-LEFT
        iT = iT+1;
        iBlockName = sprintf('%s-%s', C2s, C1s);
        cfg_EC.BlockDefRows{iT} = sprintf('%s\t1\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%s', ...
            iBlockName,...
            C2(1),...
            C1(1),...
            C2(2),...
            C1(2),...
            iClicksPerOutline,...
            C2(3),...
            C1(3),...
            iPulseSizeRight, ...
            iPulseSizeLeft,...
            iContextNames{1});

    end
end


numBlocks = length(cfg_EC.BlockDefRows);
cfg_EC.numBlocks            = numBlocks;

% --- randomize blocks
tmp = randperm(length(cfg_EC.BlockDefRows));

if effortControl_maxTrials > length(tmp)
    length(tmp);
    nAdd = effortControl_maxTrials - length(tmp);
    tmp2 = randperm(length(cfg_EC.BlockDefRows));
    tmp = [ tmp, tmp2(1:min([nAdd length(tmp2)])) ];
end

% subset of 120 or less
iMax = min([effortControl_maxTrials length(tmp)]);
cfg_EC.BlockDefRows = cfg_EC.BlockDefRows(tmp(1:iMax));

% limit it to subset of 120 trials

%keyboard

% --- --- --- --- --- --- --- --- ---
% --- write StimDef config file
% --- --- --- --- --- --- --- --- ---
%iFilename = [cfg.out_visualSearch.experimentName '_StimDeftdf.txt'];
%write_StimDefConfig_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, stimDef);

% --- --- --- --- --- --- --- --- ---
% --- write BlockDef config file
% --- --- --- --- --- --- --- --- ---
iFilename = [cfg.out_effortControl.experimentName '_BlockDef_array.txt'];
%write_BlockDefConfig_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, blockdata);
write_BlockDefConfig_EffortControl_01(cfg.out_effortControl.iPath, iFilename, cfg_EC.BlockDefHeader, cfg_EC.BlockDefRows)


% --- --- --- --- --- --- --- --- ---
% --- write TrialDef config file
% --- --- --- --- --- --- --- --- ---
%iFilename = [cfg.out_visualSearch.experimentName '_TrialDeftdf.txt'];
%write_TrialDefConfig_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, trl);


% --- --- --- --- --- --- --- --- ---
% --- write ConfigUiDetails jason, eventCode jason, and SynchboxDef txt file
% --- --- --- --- --- --- --- --- ---
jsonData = [];
jsonData.varsNumber.itiDuration.value = 0.01;%0.5;
jsonData.varsNumber.popToFeedbackDelay.value = 0.25;
jsonData.varsNumber.minObjectTouchDuration.value = 0.1;%0.001

iFilename = [cfg.out_effortControl.experimentName '_ConfigUiDetails_json']; % this will be a jason file
write_ConfigUIDetails_EffortControl_01(cfg.out_effortControl.iPath, iFilename, jsonData);
%SynchBoxDefInfo = {};
%iFilename = [cfg.out_visualSearch.experimentName '_SyncBoxDef.txt'];
%write_SynchBoxDef_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, SynchBoxDefInfo)

iFilename = [cfg.out_effortControl.experimentName '_EventCodeConfig_json']; % this will be a jason file
write_EventCode_EffortControl_01(cfg.out_effortControl.iPath, iFilename);
% [iFilename, iPath] = write_ConfigUIDetails_WorkingMemory_01(iPath, iFilename, jsonData)

% --- --- --- --- --- --- --- --- ---
% --- write TaskDef config file
% --- --- --- --- --- --- --- --- ---

% externalFilePath =  '"C:\\Users\\WomLab_Unity\\OneDrive\\Desktop\\USE_Configs\\Resources\\TextureImages"';
% externalStimFolderPath =  '"C:\Users\WomLab_Unity\OneDrive\Desktop\USE_Configs\Resources\Stimuli"';

% taskconfig{end+1} = 'List<string>	FeedbackControllers	["Audio", "Token"]';
% taskconfig{end+1} = 'bool	IsHuman	FALSE'; %.fbx
% taskconfig{end+1} = 'string	ContextName	"011_058_004_001_3"';
% taskconfig{end+1} = 'Vector3	ButtonPosition	(0, 0, 0)';
% taskconfig{end+1} = 'float	ButtonScale	120';%(0.1, 0.1, 0.1)
%taskconfig{end+1} = 'Vector3	ButtonScale	(0.65, 0.65, 0.65)';%(0.1, 0.1, 0.1)

taskconfig = [];
if cfg.isWebGL == 1
    taskconfig{end+1} = 'float	ButtonScale	1.2';%125';%(0.1, 0.1, 0.1)
else
    taskconfig{end+1} = 'float	ButtonScale	1';%125';%(0.1, 0.1, 0.1)
end
taskconfig{end+1} = 'List<string>	FeedbackControllers	["Audio", "Token"]';
taskconfig{end+1} = 'float	TouchFeedbackDuration	0.3';%(0.1, 0.1, 0.1)
%taskconfig{end+1} = 'bool	IsHuman	FALSE'; %.fbx
%taskconfig{end+1} = 'string	ContextName	"011_058_004_001_3"';
taskconfig{end+1} = 'Vector3	ButtonPosition	[0, 0, 0]';

iFilename = [cfg.out_effortControl.experimentName  '_TaskDef_singleType.txt'];
[iFilename, iPath] = write_TaskConfig_01(cfg.out_effortControl.iPath,iFilename, taskconfig);

fprintf('\ndone with iSet %.2d',cfg.iSet)
fprintf('.\n')

% --- --- --- --- --- --- --- --- ---
% --- write Block Def file
% --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_BlockDefConfig_EffortControl_01(iPath, iFilename, blockdef_header, blockdatarows)

fPtr = fopen([iPath iFilename],'w');
fprintf(fPtr,blockdef_header);
for iB = 1:length(blockdatarows)
    fprintf(fPtr, '\n %s', blockdatarows{iB});
end
fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);

% --- --- --- --- --- --- --- --- ---
% --- write ConfigUI file
% --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_ConfigUIDetails_EffortControl_01(iPath, iFilename, jsonData)


jsonData.varsNumber.inflateDuration.name = 'InflateDuration';
if ~isfield(jsonData.varsNumber.inflateDuration, 'value')
    jsonData.varsNumber.inflateDuration.value = 70;%45
end
if ~isfield(jsonData.varsNumber.inflateDuration, 'min')
    jsonData.varsNumber.inflateDuration.min = 30;
end
if ~isfield(jsonData.varsNumber.inflateDuration, 'max')
    jsonData.varsNumber.inflateDuration.max = 90;
end
jsonData.varsNumber.inflateDuration.precision= 1;
jsonData.varsNumber.inflateDuration.isRange= 1;
jsonData.varsNumber.inflateDuration.hidden= 0;

jsonData.varsNumber.itiDuration.name = 'ItiDuration';
if ~isfield(jsonData.varsNumber.itiDuration, 'value')
    jsonData.varsNumber.itiDuration.value = 0.3;%0.5;
end
if ~isfield(jsonData.varsNumber.itiDuration, 'min')
    jsonData.varsNumber.itiDuration.min = 0.001;
end
if ~isfield(jsonData.varsNumber.itiDuration, 'max')
    jsonData.varsNumber.itiDuration.max = 1.0;
end
jsonData.varsNumber.itiDuration.precision= 1;
jsonData.varsNumber.itiDuration.isRange= 1;
jsonData.varsNumber.itiDuration.hidden= 0;


jsonData.varsNumber.scalingInterval.name = 'ScalingInterval';
if ~isfield(jsonData.varsNumber.scalingInterval, 'value')
    jsonData.varsNumber.scalingInterval.value = 20;
end
if ~isfield(jsonData.varsNumber.scalingInterval, 'min')
    jsonData.varsNumber.scalingInterval.min = 10;
end
if ~isfield(jsonData.varsNumber.scalingInterval, 'max')
    jsonData.varsNumber.scalingInterval.max = 30;
end
jsonData.varsNumber.scalingInterval.precision= 1;
jsonData.varsNumber.scalingInterval.isRange= 1;
jsonData.varsNumber.scalingInterval.hidden= 0;


jsonData.varsNumber.popToFeedbackDelay.name = 'PopToFeedbackDelay';
if ~isfield(jsonData.varsNumber.popToFeedbackDelay, 'value'), jsonData.varsNumber.popToFeedbackDelay.value = 0.05; end
if ~isfield(jsonData.varsNumber.popToFeedbackDelay, 'min'), jsonData.varsNumber.popToFeedbackDelay.min = 0.005;end
if ~isfield(jsonData.varsNumber.popToFeedbackDelay, 'max'),jsonData.varsNumber.popToFeedbackDelay.max = 0.5;end
jsonData.varsNumber.popToFeedbackDelay.precision= 1;
jsonData.varsNumber.popToFeedbackDelay.isRange= 1;
jsonData.varsNumber.popToFeedbackDelay.hidden= 0;


jsonData.varsNumber.choiceToTouchDelay.name = 'choiceToTouchDelay';
if ~isfield(jsonData.varsNumber.choiceToTouchDelay, 'value'), jsonData.varsNumber.choiceToTouchDelay.value = 0.05; end
if ~isfield(jsonData.varsNumber.choiceToTouchDelay, 'min'), jsonData.varsNumber.choiceToTouchDelay.min = 0.005; end
if ~isfield(jsonData.varsNumber.choiceToTouchDelay, 'max'),     jsonData.varsNumber.choiceToTouchDelay.max = 5; end
jsonData.varsNumber.choiceToTouchDelay.precision= 1;
jsonData.varsNumber.choiceToTouchDelay.isRange= 1;
jsonData.varsNumber.choiceToTouchDelay.hidden= 0;


jsonData.varsNumber.sbToBalloonDelay.name = 'sbToBalloonDelay';
if ~isfield(jsonData.varsNumber.sbToBalloonDelay, 'value'), jsonData.varsNumber.sbToBalloonDelay.value = 0.05; end
if ~isfield(jsonData.varsNumber.sbToBalloonDelay, 'min'),    jsonData.varsNumber.sbToBalloonDelay.min = 0.005;end
if ~isfield(jsonData.varsNumber.sbToBalloonDelay, 'max'),    jsonData.varsNumber.sbToBalloonDelay.max = 1;end
jsonData.varsNumber.sbToBalloonDelay.precision= 1;
jsonData.varsNumber.sbToBalloonDelay.isRange= 1;
jsonData.varsNumber.sbToBalloonDelay.hidden= 0;


jsonData.varsNumber.minObjectTouchDuration.name = 'minObjectTouchDuration';
if ~isfield(jsonData.varsNumber.minObjectTouchDuration, 'value'),    jsonData.varsNumber.minObjectTouchDuration.value = 0.1;end % 0.05
if ~isfield(jsonData.varsNumber.minObjectTouchDuration, 'min'),    jsonData.varsNumber.minObjectTouchDuration.min = 0.001;end
if ~isfield(jsonData.varsNumber.minObjectTouchDuration, 'max'),    jsonData.varsNumber.minObjectTouchDuration.max = 5.0;end
jsonData.varsNumber.minObjectTouchDuration.precision= 1;
jsonData.varsNumber.minObjectTouchDuration.isRange= 1;
jsonData.varsNumber.minObjectTouchDuration.hidden= 0;

jsonData.varsNumber.maxObjectTouchDuration.name = 'maxObjectTouchDuration';
if ~isfield(jsonData.varsNumber.maxObjectTouchDuration, 'value'), jsonData.varsNumber.maxObjectTouchDuration.value = 4.0;end
if ~isfield(jsonData.varsNumber.maxObjectTouchDuration, 'min'), jsonData.varsNumber.maxObjectTouchDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.maxObjectTouchDuration, 'max'), jsonData.varsNumber.maxObjectTouchDuration.max = 10.0; end
jsonData.varsNumber.maxObjectTouchDuration.precision= 1;
jsonData.varsNumber.maxObjectTouchDuration.isRange= 1;
jsonData.varsNumber.maxObjectTouchDuration.hidden= 0;

jsonData.varsBoolean = {};
jsonData.varsString = {};

configUIstring=jsonencode(jsonData,'PrettyPrint',true);
A = findstr(configUIstring,'[]');
configUIstring(A(1):A(1)+1) = '{}';
configUIstring(A(2):A(2)+1) = '{}';
%    keyboard
%else
%    configUIstring=jsonencode(jsonData,'PrettyPrint',true);
%end

fPtr = fopen([iPath iFilename '.json'],'w');
fprintf(fPtr, '%s', configUIstring);
fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);


% --- --- --- --- --- --- --- --- ---
% --- write TaskDef config file
% --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_TaskConfig_01(iPath, iFilename, taskconfig)

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



% --- --- --- --- --- --- --- --- ---
% --- write EffortControl config file
% --- --- --- --- --- --- --- --- ---
function [iFilename, iPath] = write_EventCode_EffortControl_01(iPath, iFilename)

eventCodesString = [];

eventCodes = [];
eventCodes.BalloonChosen.Value = 12026;
eventCodes.BalloonChosen.Description = 'Balloon Chosen';

eventCodesString=jsonencode(eventCodes,'PrettyPrint',true);
fPtr = fopen([iPath iFilename '.json'],'w');
fprintf(fPtr, '%s', eventCodesString);
fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);




