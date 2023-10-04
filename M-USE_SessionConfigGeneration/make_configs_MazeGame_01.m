function [cfg] = make_MazeGame_configs_01(cfg,iExpName,iContextNames)

% --- 
% --- this script generates the maze task
% --- 
% 
% Copyright (c) 2023, Marcus Watson, Thilo Womelsdorf
%
% This file is part of the Multitask Unified Suite for Experiments (M-USE), 
% see http://m-use.psy.vanderbilt.edu for documentation and details.
%
%    Matlab scripts associated with M-USE are free software: 
%    you can redistribute it and/or modify it under the terms of the 
%    GNU General Public License as published by the Free Software 
%    Foundation,  either version 3 of the License, or (at your option) 
%    any later version.
%    
%    M-USE matlab scripts are distributed in the hope that it will be 
%    useful, but WITHOUT ANY WARRANTY; without even the implied warranty
%    of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    A copy of the GNU General Public License can be found
%    at http://www.gnu.org/licenses/
%


if isempty(cfg)
    cfg.iSet = 1;
    cfg.isWebGL = 0;
end
if ~isfield(cfg, 'isWebGL')
    cfg.isWebGL = 0;
end
if ~isfield(cfg,'mazeLibrary') | isempty(cfg.mazeLibrary)
    cfg.mazeLibrary = load([pwd filesep 'MazeLibrary_20230604.mat']);
end

if ~isfield(cfg, 'mz_guidedMazeSelection')
cfg.mz_guidedMazeSelection = 'TRUE';
end
if ~isfield(cfg, 'mz_nMazes')
    cfg.mz_nMazes = 5;
end

cfg.out_mazeGame = [];
cfg.out_mazeGame.experimentName = [];
cfg.out_mazeGame.taskFolderName = [];
cfg.out_mazeGame.iPath = [];
cfg.out_mazeGame.MazeNames = [];
cfg.out_mazeGame.MazeStrings = [];
if ~exist(cfg.sessionPathName), mkdir(cfg.sessionPathName), end
cfg.out_mazeGame.experimentName =  sprintf('%s_v01_Set%.2d',iExpName,cfg.iSet);
cfg.out_mazeGame.taskFolderName = cfg.out_mazeGame.experimentName;
cfg.out_mazeGame.iPath = [cfg.sessionPathName '/' cfg.out_mazeGame.taskFolderName '/'];
if ~exist(cfg.out_mazeGame.iPath), mkdir(cfg.out_mazeGame.iPath), end

cfg.MazeKeyFilePath =  ['"C:\\Users\\Womelsdorf Lab\\Desktop\\MUSE_Master\\' cfg.sessionName '\\' cfg.out_mazeGame.experimentName '\\MazeDef.txt"'];

currentRewardRatio = 5; % after 5 touches 1

if ~isfield(cfg,'mz_difficultyLevel') | isempty(cfg.mz_difficultyLevel)
% defaults:
TURNS = [2:4];
    PATHL = [11:13];
    VISIBLE = [0 1];
    minMaxTrials_firstBlocks = [2 20];
    minMaxTrials_repeatBlocks = [2 3];
    NPULSES = 3;

   if isfield(cfg,'mz_turns'), TURNS = cfg.mz_turns, end
   if isfield(cfg,'mz_rewardRatio'), currentRewardRatio = cfg.mz_rewardRatio, end
   if isfield(cfg,'mz_pathlength'), PATHL = cfg.mz_pathlength, end
   if isfield(cfg,'mz_guided'), VISIBLE = cfg.mz_guided, end
   if isfield(cfg,'mz_minMaxTrials_firstBlocks'), minMaxTrials_firstBlocks = cfg.mz_minMaxTrials_firstBlocks, end
   if isfield(cfg,'mz_minMaxTrials_repeatBlocks'), minMaxTrials_repeatBlocks = cfg.mz_minMaxTrials_repeatBlocks, end
   if isfield(cfg,'mz_nRewardPulses'), NPULSES = cfg.mz_nRewardPulses, end
else
    DiffLevel = cfg.mz_difficultyLevel;
end
if DiffLevel == 1
    currentRewardRatio = 5; % 1=each correct touch is rewarded
    TURNS = [0];
    PATHL = [5:8];
    VISIBLE = [1];
    minMaxTrials_firstBlocks = [5 15];
    NPULSES = 2;
    minMaxTrials_repeatBlocks = [2 3]; 
elseif DiffLevel == 2
    currentRewardRatio = 5; % 1=each correct touch is rewarded
    TURNS = [2];%1:2
    PATHL = [5:8];
    VISIBLE = [1];
    minMaxTrials_firstBlocks = [8 15];
    minMaxTrials_repeatBlocks = [2 3];
    NPULSES = 2;
elseif DiffLevel == 3
    % for wotan begin of week 3: last one is not guided anymore... 
    TURNS = [2];
    PATHL = [7:12];
    VISIBLE = [1]; 
    minMaxTrials_firstBlocks = [9 12];
    NPULSES = 3;
    minMaxTrials_repeatBlocks = [2 3];
elseif DiffLevel == 4
    TURNS = [1:3];
    PATHL = [8:10];
    VISIBLE = [0 1]; %% for 1st, 2nd, and 3rd
    minMaxTrials_firstBlocks = [2 20];
    NPULSES = 3;
    minMaxTrials_repeatBlocks = [2 3];
elseif DiffLevel == 5
    TURNS = [2:4];
    PATHL = [11:13];
    VISIBLE = [0 1];
    minMaxTrials_firstBlocks = [2 20];
    minMaxTrials_repeatBlocks = [2 3];
    NPULSES = 3;
elseif DiffLevel == 6
    TURNS = [3:5];
    PATHL = [14:16];
    VISIBLE = [0 ];
    minMaxTrials_firstBlocks = [2 20];
    minMaxTrials_repeatBlocks = [2 3];
    NPULSES = 3;
elseif DiffLevel == 7
    TURNS = [4:6];
    PATHL = [17:19];
    VISIBLE = [0 ];
    minMaxTrials_firstBlocks = [2 15];
    minMaxTrials_repeatBlocks = [2 3];
    NPULSES = 3;
elseif DiffLevel == 8
    TURNS = [5:6];
    PATHL = [18:23];
    VISIBLE = [0];
    minMaxTrials_firstBlocks = [2 15];
    minMaxTrials_repeatBlocks = [2 3];
    NPULSES = 3;
else
    error('DiffLevel for maze is not in the good range (1-8)');
end

mazeDef = [];
mazeDef.name = [];
mazeDef.mDims = [];
mazeDef.mNumTurns = [];
mazeDef.mNumSquares = [];
mazeDef.mStart = [];
mazeDef.mFinish = [];
mazeDef.mName = [];

cfg_MG = [];
cfg_MG.BlockName = {};
cfg_MG.BlockCount = {};
cfg_MG.MinMaxTrials = {};
cfg_MG.SliderInitial = {};
cfg_MG.NumPulses = {};
cfg_MG.PulseSize = {};
cfg_MG.ContextName = {};
cfg_MG.viewPath = {};
cfg_MG.MazeName = {};
cfg_MG.MazeString = {};
%cfg_MG.currentMazeNameFolderMazeName = {};

cfg_MG.RewardRatio = {};
        cfg_MG.BlockEndType = {};
        cfg_MG.BlockEndThreshold = {};
        cfg_MG.ErrorPenalty = {};


if isfield(cfg,'BlockDefRows_Repeat') % if the repeated mazes were already specificied
    cfg_MG.BlockDefHeader = cfg.BlockDefHeader_Repeat;
    cfg_MG.BlockDefRows   = cfg.BlockDefRows_Repeat;
   nTmp = length(cfg_MG.BlockDefRows);
% pick then a random subset:
   if cfg.mz_nMazes < nTmp
tmp = randperm(nTmp);
cfg_MG.BlockDefRows = cfg_MG.BlockDefRows(tmp(1:cfg.mz_nMazes));
end
    
mazeDef =  cfg.mazeDef;


else
    if ~isfield(cfg,'contexts')
        cfg.contextRepositoryFolderPath = [pwd filesep 'ContextRepository_20221206/'];
        cfg.contexts                    = get_contextNames_01(cfg.contextRepositoryFolderPath);
    end
    [a,typeID,c] = intersect(cfg.contexts.types,'Leather');
    context_idx = find(cfg.contexts.typeID==typeID);
    tmp = randperm(length(context_idx));
    cSel=tmp(1:cfg.mz_nMazes);
    iContextNames = cfg.contexts.name(context_idx(cSel));
    for iC=1:length(iContextNames)
        tmp = findstr(iContextNames{iC},'.'); %remove .png
        if ~isempty(tmp), iContextNames{iC}(tmp(1):end) = [];
        end
    end

    iMazDims = [6 6];
    XL = 'ABCDEF';
    YL = [1:6];

            % --- choose random starting point :
    allDirections = [1:4];
    randall4startDirections = repmat(randperm(length(allDirections)),1,cfg.mz_nMazes); % generate sufficient sets of 4 directions
    

    % --- bottomToTop = 1, rightToLeft = 2,TopToBottom = 3, leftToRight = 4,
    cfg_MG = [];
    for iM=1:cfg.mz_nMazes

        % ---- choose among the Pathlength and Turns:
        iTurns      = TURNS(randi(length(TURNS)));
        iLength     = PATHL(randi(length(PATHL)));
        
        % --- either random visibility or visibility according to what was specified for a specifci maze: 
        if length(VISIBLE) == cfg.mz_nMazes
            iVisibility = VISIBLE(iM); 
        else
            iVisibility = VISIBLE(randi(length(VISIBLE)));
        end
        
        if iTurns==0;
            iLength=6;
        end
        % "M3X3_T0_L2_A1_A2_0000000"
        %  M3X3 (indicates 3 x 3 maze dimensions)
        % _T0 (indicates 0 turns)
        % _L2 (indicates path length of 2)
        % _A1 (indicates start at bottom left, chess naming convention)
        % _A2 (indicates finish on tile above the start, chess naming convention)
        % _0000000 (unique id, if above info repeats it will increment)

        DOCONTROLSTARTPOSITION = 0
        if DOCONTROLSTARTPOSITION == 1

            %iStartingDirection = allDirections(randi(length(allDirections)));
            iStartingDirection = randall4startDirections(iM)
            iStart = [];

            % ---- only detemrine letter... 
            % ---- 
            
            % ---- choose randomly a start square
            if iStartingDirection==1 % rightToXX = 1,
                tmp = XL(randi(length(XL)));
                iStart = sprintf('%s1',tmp);
            elseif iStartingDirection==2 % rightToXX = 1,
                tmp = YL(randi(length(YL)));
                iStart = sprintf('F%d',tmp);
            elseif iStartingDirection==3 % TopToXX = 1,
                tmp = XL(randi(length(XL)));
                iStart = sprintf('%s6',tmp);
            elseif iStartingDirection==4 % leftToXX = 1,
                tmp = YL(randi(length(YL)));
                iStart = sprintf('A%d',tmp);
            end

            iMazeName_PreFix = [sprintf('M%dX%d',[iMazDims]) ...
                sprintf('_T%d',[iTurns]) ...
                sprintf('_L%d',[iLength]) ...
                ['_' iStart] ];

% 16×1 cell array
% 
%     {'M6X6_T1_L6_A2_E1_00000000'}
%     {'M6X6_T1_L6_A2_E1_00000001'}
%     {'M6X6_T1_L6_A3_D1_00000000'}
%     {'M6X6_T1_L6_A4_D6_00000000'}
%     {'M6X6_T1_L6_A5_E6_00000000'}
%     {'M6X6_T1_L6_D1_A3_00000000'}
%     {'M6X6_T1_L6_D6_A4_00000000'}
%     {'M6X6_T1_L6_E1_A2_00000000'}
%     {'M6X6_T1_L6_E1_A2_00000001'}
%     {'M6X6_T1_L6_E6_A5_00000000'}
%     {'M6X6_T1_L6_E6_A5_00000001'}
%     {'M6X6_T1_L6_F2_B1_00000000'}
%     {'M6X6_T1_L6_F2_B1_00000001'}
%     {'M6X6_T1_L6_F3_C1_00000000'}
%     {'M6X6_T1_L6_F4_C6_00000000'}
%     {'M6X6_T1_L6_F5_B6_00000000'}


            % iMazeName_PreFix
        else


            iMazeName_PreFix = [sprintf('M%dX%d',[iMazDims]) ...
                sprintf('_T%d',[iTurns]) ...
                sprintf('_L%d',[iLength])];
        end


        
        % --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
        % --- get a random maze
        % --- find all mazes with same prefix
        % --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

        idx = strmatch(iMazeName_PreFix,cfg.mazeLibrary.name);
        if isempty(idx)
            error(sprintf('no maze found with prefix %s',iMazeName_PreFix))
        end
        iDX = idx(randi(length(idx)));
        currentMazeName = cfg.mazeLibrary.name{iDX};
        %currentMazeNameFolder = [cfg.mazeLibrary.folder filesep];
        currentMazeNameString = cfg.mazeLibrary.string{iDX};
        
        tmp = findstr(currentMazeName,'_');
        iStart = currentMazeName(tmp(3)+1:tmp(4)-1);
        iEnd = currentMazeName(tmp(4)+1:tmp(5)-1); %(tmp(end-1)+1:tmp(end)-1)

        mazeDef.mDims{iM} = sprintf('[%d,%d]',iMazDims);
        mazeDef.mNumTurns{iM} = sprintf('%d',[iTurns]);
        mazeDef.mNumSquares{iM} =  sprintf('%d',[iLength]);
        mazeDef.mStart{iM} = iStart;
        mazeDef.mFinish{iM} = iEnd;
        mazeDef.mName{iM} = currentMazeName;
        mazeDef.mString{iM} = currentMazeNameString;


        cfg_MG.BlockName{iM} = sprintf('Block%0da',iM);
        cfg_MG.BlockCount{iM} = sprintf('%d',iM);
        cfg_MG.MinMaxTrials{iM} = sprintf('[%d,%d]',[minMaxTrials_firstBlocks]);
        cfg_MG.MinMaxTrialsRepeat{iM} = sprintf('[%d,%d]',[minMaxTrials_repeatBlocks]);
        cfg_MG.SliderInitial{iM} = '0';
        NumPulses = 3;
        PulseSize = 250;
        iRewardRatio = currentRewardRatio;
        cfg_MG.NumPulses{iM} = sprintf('%d',NumPulses);
        cfg_MG.PulseSize{iM} = sprintf('%d',PulseSize);

        cfg_MG.ContextName{iM} = iContextNames{iM};
        if iVisibility==1
            cfg_MG.viewPath{iM} = 'True';
        else
            cfg_MG.viewPath{iM} = 'False';
        end
        cfg_MG.MazeNumTurns{iM} = mazeDef.mNumTurns{iM};
        cfg_MG.MazeName{iM} = currentMazeName;
        cfg_MG.MazeString{iM} = mazeDef.mString{iM};
        %cfg_MG.currentMazeNameFolder{iM} = currentMazeName;
        cfg_MG.RewardRatio{iM} = sprintf('%d',iRewardRatio);
    
        cfg_MG.BlockEndType{iM} = 'CurrentTrialPerformance';
        cfg_MG.BlockEndThreshold{iM} = '0.5';
        cfg_MG.ErrorPenalty{iM} = 'FALSE';

    end

    %M3X3 (indicates 3 x 3 maze dimensions)
    %_T0 (indicates 0 turns)
    %_L2 (indicates path length of 2)
    %_A1 (indicates start at bottom left, chess naming convention)
    %_A2 (indicates finish on tile above the start, chess naming convention)
    %_0000000 (unique id, if above info repeats it will increment)

    % MazeDef:
    % mDims	mNumTurns	mNumSquares	mStart	mFinish	mName
    % [6,6]	0	6	A1	A6	M6X6_T0_L6_A1_A6_0000000

    cfg_MG.BlockDefHeader  = [];
    cfg_MG.BlockDefRows    = [];
    cfg_MG.BlockDefHeader_Repeat = [];
    cfg_MG.BlockDefRows_Repeat   = [];

    % ---- make block header for the first set
    cfg_MG.BlockDefHeader =['BlockName' '\t' 'BlockCount' '\t' 'RandomMinMaxTrials' '\t' 'ViewPath'  '\t' 'NumPulses' '\t' 'PulseSize'  '\t' 'ContextName' '\t'  'MazeName' '\t'   'RewardRatio' '\t'   'BlockEndType' '\t'   'BlockEndThreshold' '\t'   'ErrorPenalty'];
    cfg_MG.BlockDefHeader_Repeat = cfg_MG.BlockDefHeader;

    % --- random order for repeating the mazes
    randM = randperm(length(cfg_MG.BlockName));

    for iM=1:length(cfg_MG.BlockName)
        cfg_MG.BlockDefRows{iM} =     sprintf('%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s', ...
            cfg_MG.BlockName{iM}, ...
            cfg_MG.BlockCount{iM}, ...
            cfg_MG.MinMaxTrials{iM} , ...
            cfg_MG.viewPath{iM} , ...
            cfg_MG.NumPulses{iM} , ...
            cfg_MG.PulseSize{iM} , ...
            cfg_MG.ContextName{iM} , ...
            cfg_MG.MazeName{iM} , ...
            cfg_MG.RewardRatio{iM},...
            cfg_MG.BlockEndType{iM},...
        	cfg_MG.BlockEndThreshold{iM},...
        	cfg_MG.ErrorPenalty{iM});

        sel = randM(iM);
        iBlockName = cfg_MG.BlockName{sel};
        iBlockName(end) = 'r';
        cfg_MG.BlockDefRows_Repeat{iM} = sprintf('%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s', ...
            iBlockName, ...
            sprintf('%d',iM), ...
            cfg_MG.MinMaxTrialsRepeat{sel} , ...
            cfg_MG.viewPath{sel} , ...
            cfg_MG.NumPulses{sel} , ...
            cfg_MG.PulseSize{sel} , ...
            cfg_MG.ContextName{sel} , ...
            cfg_MG.MazeName{sel} , ...
            cfg_MG.RewardRatio{sel},...
            cfg_MG.BlockEndType{sel},...
        	cfg_MG.BlockEndThreshold{sel},...
        	cfg_MG.ErrorPenalty{sel} );
    end
    cfg.BlockDefHeader_Repeat = cfg_MG.BlockDefHeader_Repeat;
    cfg.BlockDefRows_Repeat   = cfg_MG.BlockDefRows_Repeat;
    cfg.mazeDef = mazeDef;
end

% --- determine which maze files need to be copied:
cfg.out_mazeGame.MazeNames = cfg_MG.MazeName;
cfg.out_mazeGame.MazeStrings = cfg_MG.MazeString;
%cfg.out_mazeGame.currentMazeNamesFolders = cfg_MG.currentMazeNameFolder;
% cfg_MG.MazeName{iM} = currentMazeName;
% cfg_MG.currentMazeNameFolder{iM} = currentMazeName;



% --- --- --- --- --- --- --- --- ---
% --- write StimDef config file
% --- --- --- --- --- --- --- --- ---
% iFilename = [cfg.out_visualSearch.experimentName '_StimDeftdf.txt'];
% write_StimDefConfig_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, stimDef);

% --- --- --- --- --- --- --- --- ---
% --- write BlockDef config file
% --- --- --- --- --- --- --- --- ---
iFilename = [cfg.out_mazeGame.experimentName '_BlockDef_array.txt'];
% write_BlockDefConfig_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, blockdata);
write_BlockDefConfig_MazeGame_01(cfg.out_mazeGame.iPath, iFilename, cfg_MG.BlockDefHeader, cfg_MG.BlockDefRows)


% --- --- --- --- --- --- --- --- ---
% --- write MazeDef config file
% --- --- --- --- --- --- --- --- ---
%iFilename = [cfg.out_mazeGame.experimentName 'MazeDef.txt'];
iFilename = ['MazeDef_array.txt'];
% write_BlockDefConfig_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, blockdata);
write_MazeDef_01(cfg.out_mazeGame.iPath, iFilename, mazeDef)


% --- --- --- --- --- --- --- --- ---
% --- write TrialDef config file
% --- --- --- --- --- --- --- --- ---
% iFilename = [cfg.out_visualSearch.experimentName '_TrialDeftdf.txt'];
% write_TrialDefConfig_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, trl);


% --- --- --- --- --- --- --- --- ---
% --- write ConfigUiDetails jason, eventCode jason, and SynchboxDef txt file
% --- --- --- --- --- --- --- --- ---
configUI = [];
iFilename = [cfg.out_mazeGame.experimentName '_ConfigUiDetails_json']; % this will be a jason file
write_ConfigUIDetails_MazeGame_01(cfg.out_mazeGame.iPath, iFilename, configUI);
%SynchBoxDefInfo = {};
%iFilename = [cfg.out_visualSearch.experimentName '_SyncBoxDef.txt'];
%write_SynchBoxDef_VisualSearch_01(cfg.out_visualSearch.iPath, iFilename, SynchBoxDefInfo)

eventCodeInfo = [];
iFilename = [cfg.out_mazeGame.experimentName '_EventCodeConfig_json']; % this will be a jason file
write_EventCode_MazeGame_01(cfg.out_mazeGame.iPath, iFilename);
% [iFilename, iPath] = write_ConfigUIDetails_WorkingMemory_01(iPath, iFilename, jsonData)

% --- --- --- --- --- --- --- --- ---
% --- write TaskDef config file
% --- --- --- --- --- --- --- --- ---
taskconfig = [];
if cfg.isWebGL == 1
    taskconfig{end+1} = 'float	ExternalStimScale	5.5';
    taskconfig{end+1} = 'float	StartButtonScale	1.2';% 125';%(0.1, 0.1, 0.1)
else
taskconfig{end+1} = 'float	StartButtonScale	1';%125';%(0.1, 0.1, 0.1)
taskconfig{end+1} = 'string	TileTexture	"Tile"';
end

taskconfig{end+1} = 'Dictionary<string,string>	CustomSettings	{MazeDef.txt:SingleTypeArray}'; % 125';%(0.1, 0.1, 0.1)

taskconfig{end+1} = 'float	TouchFeedbackDuration	0.3';
taskconfig{end+1} = 'Vector3	StartButtonPosition	[0, 0, 0]';
taskconfig{end+1} = 'float	TileSize	2';%7
taskconfig{end+1} = 'float	SpaceBetweenTiles	0.7'; %2.1
taskconfig{end+1} = 'List<string>	FeedbackControllers	["Audio", "Halo", "Slider"]';

taskconfig{end+1} = 'int	NumBlinks	2';
taskconfig{end+1} = 'float[]	StartColor	[0.94, 0.93, 0.48]';
taskconfig{end+1} = 'float[]	FinishColor	[0.37, 0.59, 0.94]';
taskconfig{end+1} = 'float[]	CorrectColor	[0.62, 1, 0.5]';
taskconfig{end+1} = 'float[]	LastCorrectColor	[0.2, 0.7, 0.5]';
taskconfig{end+1} = 'float[]	IncorrectRuleAbidingColor	[1, 0.5, 0.25]';
taskconfig{end+1} = 'float[]	IncorrectRuleBreakingColor	[0,0,0]';
taskconfig{end+1} = 'float[]	DefaultTileColor	[1, 1, 1]';
taskconfig{end+1} = 'bool	NeutralITI	false';
taskconfig{end+1} = 'bool	UsingFixedRatioReward	true';
taskconfig{end+1} = 'string	MazeBackgroundTexture	"MazeBackground"';
taskconfig{end+1} = 'Vector3	MazePosition	[0, 0.5, 0]';%[0, -1.3, 0]

taskconfig{end+1} = sprintf('bool	GuidedMazeSelection\t%s',cfg.mz_guidedMazeSelection); % (true = chase reaction test, false = normal maze)

iFilename = [cfg.out_mazeGame.experimentName  '_TaskDef_singleType.txt'];
[iFilename, iPath] = write_TaskConfig_MazeGame_01(cfg.out_mazeGame.iPath,iFilename, taskconfig);

fprintf('\ndone with iSet %.2d',cfg.iSet)

fprintf('.\n')





% - - - - - - -  - - - - - - -  - - - - - - -
% - write_BlockDefConfig_MazeGame_01
% - - - - - - -  - - - - - - -  - - - - - - -
function [iFilename, iPath] = write_BlockDefConfig_MazeGame_01(iPath, iFilename, blockdef_header, blockdatarows)

% --- print TrialDef file:
% if ~exist(iPath), mkdir(iPath), end
% iFilename_StimDef  = sprintf('%s_Set%02d_StimDef',iFilname);
fPtr = fopen([iPath iFilename],'w');
%blockdef_header=['BlockName' '\t' 'BlockCount' '\t' 'NumInitialTokens' '\t' 'NumTokenBar' '\t' 'NumPulses' '\t' 'PulseSize' ];
%blockdef_header = blockdataheader;

fprintf(fPtr,blockdef_header);
for iB = 1:length(blockdatarows)
    %disp('w'), return
    fprintf(fPtr, '\n %s', blockdatarows{iB});

end
fclose(fPtr);

fprintf('\n wrote %s', [ iFilename ]);



% - - - - - - -  - - - - - - -  - - - - - - -
% - write_MazeDef_01
% - - - - - - -  - - - - - - -  - - - - - - -
function [iFilename, iPath] = write_MazeDef_01(iPath, iFilename, mazeDef)

fPtr = fopen([iPath iFilename],'w');
trialdef_header=['mDims' '\t' 'mNumTurns' '\t' 'mNumSquares' '\t' 'mStart' '\t' 'mFinish' '\t' 'mName' '\t' 'mString'];

fprintf(fPtr,trialdef_header);
for iM = 1:length(mazeDef.mName)
    iString = sprintf('%s\t%s\t%s\t%s\t%s\t%s\t%s', ...
        mazeDef.mDims{iM} ,...
        mazeDef.mNumTurns{iM}  ,...
        mazeDef.mNumSquares{iM}  ,...
        mazeDef.mStart{iM}  ,...
        mazeDef.mFinish{iM}  ,...
        mazeDef.mName{iM} ,...
        mazeDef.mString{iM});

    fprintf(fPtr, '\n %s', iString);
end

fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);



% - - - - - - -  - - - - - - -  - - - - - - -
% - write_EventCode_MazeGame_01
% - - - - - - -  - - - - - - -  - - - - - - -
function [iFilename, iPath] = write_EventCode_MazeGame_01(iPath, iFilename)

eventCodesString = [];

eventCodes = [];

eventCodes.MazeStart.Value = 12076;
eventCodes.MazeStart.Description = 'First frame where the maze start tile is selected';
eventCodes.MazeFinish.Value = 12077;
eventCodes.MazeFinish.Description = 'First frame where the final tile of the maze path is selected';
eventCodes.RuleBreakingError.Value = 12078;
eventCodes.RuleBreakingError.Description = 'First frame where touch target is on a tile that does not follow the rules';
eventCodes.RuleAbidingError.Value = 12079;
eventCodes.RuleAbidingError.Description = 'First frame where touch target is on a tile that does follow the rules; but is not on the hidden path ';
eventCodes.PerseverativeError.Value = 12080;
eventCodes.PerseverativeError.Description = 'First frame where the touch target is on a tile following an error; but the tile is not the last correct touch';
eventCodes.LastCorrectSelection.Value = 12081;
eventCodes.LastCorrectSelection.Description = 'Reselected the tile that represents their current location in the maze';
eventCodes.FlashingTileFbOn.Value = 12082;
eventCodes.FlashingTileFbOn.Description = 'Last correct tile flashes green due to perseverative error';
eventCodes.FlashingTileFbOff.Value = 12083;
eventCodes.FlashingTileFbOff.Description = 'Last correct tile stops flashing green';
eventCodes.MazeOn.Value = 12084;
eventCodes.MazeOn.Description = 'Maze is made visible on the screen';
eventCodes.MazeOff.Value = 12085;
eventCodes.MazeOff.Description = 'Maze is removed from the screen';
eventCodes.TileFbOn.Value = 12086;
eventCodes.TileFbOn.Description = 'Tile feedback made visible on the screen';
eventCodes.TileFbOff.Value = 12087;
eventCodes.TileFbOff.Description = 'Tile feedback made not visible on the screen';
eventCodes.TileCode.Range = [12088, 14088];
eventCodes.TileCode.Description = '12088-14088 indicates the current tile code (must be defined by the experimenter in the Maze folder)';

eventCodesString=jsonencode(eventCodes,'PrettyPrint',true);


fPtr = fopen([iPath iFilename '.json'],'w');
fprintf(fPtr, '%s', eventCodesString);
fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);






% - - - - - - -  - - - - - - -  - - - - - - -
% - write_ConfigUIDetails_MazeGame_01
% - - - - - - -  - - - - - - -  - - - - - - -
function [iFilename, iPath] = write_ConfigUIDetails_MazeGame_01(iPath, iFilename, jsonData)

%     jsonData.varsNumber.spaceBetweenTiles.name = 'Space Between Tiles';
% if ~isfield(jsonData.varsNumber.spaceBetweenTiles, 'value'),     jsonData.varsNumber.spaceBetweenTiles.value = 0.4;end
% if ~isfield(jsonData.varsNumber.spaceBetweenTiles, 'min'), jsonData.varsNumber.spaceBetweenTiles.min = 0.1;end
% if ~isfield(jsonData.varsNumber.spaceBetweenTiles, 'max'), jsonData.varsNumber.spaceBetweenTiles.max = 20.0;end
%     jsonData.varsNumber.spaceBetweenTiles.precision= 1;
%     jsonData.varsNumber.spaceBetweenTiles.isRange= 1;
%     jsonData.varsNumber.spaceBetweenTiles.hidden= 0;
% 
%     jsonData.varsNumber.tileSize.name = 'Tile Size';
% if ~isfield(jsonData.varsNumber.tileSize, 'value'), jsonData.varsNumber.tileSize.value = 2;end
% if ~isfield(jsonData.varsNumber.tileSize, 'min'), jsonData.varsNumber.tileSize.min = 0.1;end
% if ~isfield(jsonData.varsNumber.tileSize, 'max'),     jsonData.varsNumber.tileSize.max = 20.0;end
%     jsonData.varsNumber.tileSize.precision= 1;
%     jsonData.varsNumber.tileSize.isRange= 1;
%     jsonData.varsNumber.tileSize.hidden= 0;
% 

    jsonData.varsNumber.itiDuration.name = 'iti Duration';
if ~isfield(jsonData.varsNumber.itiDuration, 'value'), jsonData.varsNumber.itiDuration.value = 1.0;end
if ~isfield(jsonData.varsNumber.itiDuration, 'min'), jsonData.varsNumber.itiDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.itiDuration, 'max'), jsonData.varsNumber.itiDuration.max = 10.0;end
    jsonData.varsNumber.itiDuration.precision= 1;
    jsonData.varsNumber.itiDuration.isRange= 1;
    jsonData.varsNumber.itiDuration.hidden= 0;

    jsonData.varsNumber.sliderSize.name = 'Slider Size';
if ~isfield(jsonData.varsNumber.sliderSize, 'value'), jsonData.varsNumber.sliderSize.value = 15.0;end%20.0;
if ~isfield(jsonData.varsNumber.sliderSize, 'min'), jsonData.varsNumber.sliderSize.min = 1.0;end
if ~isfield(jsonData.varsNumber.sliderSize, 'max'), jsonData.varsNumber.sliderSize.max = 100.0;end
    jsonData.varsNumber.sliderSize.precision= 1;
    jsonData.varsNumber.sliderSize.isRange= 1;
    jsonData.varsNumber.sliderSize.hidden= 0;

    jsonData.varsNumber.flashingFbDuration.name = 'Flashing Fb Duration';
if ~isfield(jsonData.varsNumber.flashingFbDuration, 'value'), jsonData.varsNumber.flashingFbDuration.value = 1;end
if ~isfield(jsonData.varsNumber.flashingFbDuration, 'min'), jsonData.varsNumber.flashingFbDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.flashingFbDuration, 'max'), jsonData.varsNumber.flashingFbDuration.max = 10.0;end
    jsonData.varsNumber.flashingFbDuration.precision= 1;
    jsonData.varsNumber.flashingFbDuration.isRange= 1;
    jsonData.varsNumber.flashingFbDuration.hidden= 0;

    jsonData.varsNumber.mazeOnsetDelay.name = 'Maze Onset Delay';
if ~isfield(jsonData.varsNumber.mazeOnsetDelay, 'value'), jsonData.varsNumber.mazeOnsetDelay.value = 0.1;end
if ~isfield(jsonData.varsNumber.mazeOnsetDelay, 'min'), jsonData.varsNumber.mazeOnsetDelay.min = 0.05;end
if ~isfield(jsonData.varsNumber.mazeOnsetDelay, 'max'), jsonData.varsNumber.mazeOnsetDelay.max = 20.0;end
    jsonData.varsNumber.mazeOnsetDelay.precision= 1;
    jsonData.varsNumber.mazeOnsetDelay.isRange= 1;
    jsonData.varsNumber.mazeOnsetDelay.hidden= 0;

    jsonData.varsNumber.correctFbDuration.name = 'correct FB Duration';
if ~isfield(jsonData.varsNumber.correctFbDuration, 'value'), jsonData.varsNumber.correctFbDuration.value = 0.2;end
if ~isfield(jsonData.varsNumber.correctFbDuration, 'min'), jsonData.varsNumber.correctFbDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.correctFbDuration, 'max'), jsonData.varsNumber.correctFbDuration.max = 20.0;end
    jsonData.varsNumber.correctFbDuration.precision= 1;
    jsonData.varsNumber.correctFbDuration.isRange= 1;
    jsonData.varsNumber.correctFbDuration.hidden= 0;

    jsonData.varsNumber.previousCorrectFbDuration.name = 'Previous Correct FB Duration';
if ~isfield(jsonData.varsNumber.previousCorrectFbDuration, 'value'), jsonData.varsNumber.previousCorrectFbDuration.value = 0.2;end
if ~isfield(jsonData.varsNumber.previousCorrectFbDuration, 'min'), jsonData.varsNumber.previousCorrectFbDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.previousCorrectFbDuration, 'max'), jsonData.varsNumber.previousCorrectFbDuration.max = 20.0;end
    jsonData.varsNumber.previousCorrectFbDuration.precision= 1;
    jsonData.varsNumber.previousCorrectFbDuration.isRange= 1;
    jsonData.varsNumber.previousCorrectFbDuration.hidden= 0;


    jsonData.varsNumber.incorrectRuleAbidingFbDuration.name = 'Incorrect Rule Abiding FB Duration';
if ~isfield(jsonData.varsNumber.incorrectRuleAbidingFbDuration, 'value'), jsonData.varsNumber.incorrectRuleAbidingFbDuration.value = 0.2;end
if ~isfield(jsonData.varsNumber.incorrectRuleAbidingFbDuration, 'min'), jsonData.varsNumber.incorrectRuleAbidingFbDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.incorrectRuleAbidingFbDuration, 'max'), jsonData.varsNumber.incorrectRuleAbidingFbDuration.max = 20.0;end
    jsonData.varsNumber.incorrectRuleAbidingFbDuration.precision= 1;
    jsonData.varsNumber.incorrectRuleAbidingFbDuration.isRange= 1;
    jsonData.varsNumber.incorrectRuleAbidingFbDuration.hidden= 0;

    jsonData.varsNumber.incorrectRuleBreakingFbDuration.name = 'Incorrect Rule Breaking FB Duration';
if ~isfield(jsonData.varsNumber.incorrectRuleBreakingFbDuration, 'value'), jsonData.varsNumber.incorrectRuleBreakingFbDuration.value = 0.4;end
if ~isfield(jsonData.varsNumber.incorrectRuleBreakingFbDuration, 'min'), jsonData.varsNumber.incorrectRuleBreakingFbDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.incorrectRuleBreakingFbDuration, 'max'), jsonData.varsNumber.incorrectRuleBreakingFbDuration.max = 20.0;end
    jsonData.varsNumber.incorrectRuleBreakingFbDuration.precision= 1;
    jsonData.varsNumber.incorrectRuleBreakingFbDuration.isRange= 1;
    jsonData.varsNumber.incorrectRuleBreakingFbDuration.hidden= 0;

    jsonData.varsNumber.tileBlinkingDuration.name = 'Tile Blinking Duration';
if ~isfield(jsonData.varsNumber.tileBlinkingDuration, 'value'), jsonData.varsNumber.tileBlinkingDuration.value = 0.5;end
if ~isfield(jsonData.varsNumber.tileBlinkingDuration, 'min'), jsonData.varsNumber.tileBlinkingDuration.min = 0.1;end
if ~isfield(jsonData.varsNumber.tileBlinkingDuration, 'max'), jsonData.varsNumber.tileBlinkingDuration.max = 20.0;end
    jsonData.varsNumber.tileBlinkingDuration.precision= 1;
    jsonData.varsNumber.tileBlinkingDuration.isRange= 1;
    jsonData.varsNumber.tileBlinkingDuration.hidden= 0;


    jsonData.varsNumber.maxMazeDuration.name = 'Max Maze Duration';
if ~isfield(jsonData.varsNumber.maxMazeDuration, 'value'), jsonData.varsNumber.maxMazeDuration.value = 120;end
if ~isfield(jsonData.varsNumber.maxMazeDuration, 'min'), jsonData.varsNumber.maxMazeDuration.min = 300;end
if ~isfield(jsonData.varsNumber.maxMazeDuration, 'max'), jsonData.varsNumber.maxMazeDuration.max = 20.0;end
    jsonData.varsNumber.maxMazeDuration.precision= 1;
    jsonData.varsNumber.maxMazeDuration.isRange= 1;
    jsonData.varsNumber.maxMazeDuration.hidden= 0;


    jsonData.varsNumber.minObjectTouchDuration.name = 'Min Object Touch Duration';
if ~isfield(jsonData.varsNumber.minObjectTouchDuration, 'value'), jsonData.varsNumber.minObjectTouchDuration.value = 0.1;end %0.05
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
    
    jsonData.varsBoolean = {};
    jsonData.varsString = {};

    configUIstring=jsonencode(jsonData,'PrettyPrint',true);
    A = findstr(configUIstring,'[]');
    configUIstring(A(1):A(1)+1) = '{}';
    configUIstring(A(2):A(2)+1) = '{}';
    %    keyboard


fPtr = fopen([iPath iFilename '.json'],'w');
fprintf(fPtr, '%s', configUIstring);
fclose(fPtr);
fprintf('\n wrote %s', [ iFilename ]);

% - - - - - - -  - - - - - - -  - - - - - - -
% - write_TaskConfig_MazeGame_01
% - - - - - - -  - - - - - - -  - - - - - - -
function [iFilename, iPath] = write_TaskConfig_MazeGame_01(iPath, iFilename, taskconfig)
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

