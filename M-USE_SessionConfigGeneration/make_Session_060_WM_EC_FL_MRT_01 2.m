% --- 
% --- this script generates the session configuration files 
% --- with 4 tasks: Visual Search, Flexible Learning, Effort Control
% --- and the guided Maze-Response Task
% --- 

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

cd /Users/thiwom/Main/projects/201912_P_KioskFluBehavior/#ms_CognitiveGames_Kiosk/GAMES_MATLAB
nSessions = 10;
randomizeTaskOrder = 0;
DF =4 ;% for wotan 

 iNAME_COMBINATION = 'WM_EC_FL_MRT'; % 42
% iNAME_COMBINATION = 'FL_VS_EC_MRT'; % 43
% iNAME_COMBINATION = 'EC_FL_VS_MRT'; % 44
% iNAME_COMBINATION = 'EC_VS_FL_MRT'; % 45
% iNAME_COMBINATION = 'VS_FL_EC_MRT'; % 46
% iNAME_COMBINATION = 'FL_EC_VS_MRT'; % 47
[iTYPENUM] = get_sessionConfigTypes_01(iNAME_COMBINATION);
identifierStr = 'SESSIONCONFIGS_060ies'

if randomizeTaskOrder==0
sessionName_Prefix = sprintf('SessionConfig_%03d_%s',iTYPENUM,iNAME_COMBINATION);
else
    sessionName_Prefix = sprintf('SessionConfig_%03dr_%s',iTYPENUM,iNAME_COMBINATION);
end


% --- load the mazes ones at the beginning
if ~exist('mazeLibrary')
mazeLibrary =[];
if  (~isempty(findstr(sessionName_Prefix,'MZ')) | ~isempty(findstr(sessionName_Prefix,'MRT')))
    sprintf('loading maze library: MazeLibrary_20230604.mat\n')
    tmp = load([pwd filesep 'MazeLibrary_20230604.mat']);
    mazeLibrary =tmp.mazeLibrary;clear('tmp');
end
end

rng('shuffle'), %rng(1498826567);
for iSession  = 1:nSessions
    
    cfg = [];
    cfg.iSet                    = iSession;
    cfg.taskSequence            = {};
    cfg.taskIconSequence        = {};
%   cfg.sessionName             = sprintf('%s_DF2_v01_Set%02d',sessionName_Prefix, iSession);% had only mazeguided with 0 or 1 turn only
    cfg.sessionName             = sprintf('%s_DF%d_v04_Set%02d',sessionName_Prefix, DF, iSession);
    cfg.sessionPathName         =  [ pwd '/' identifierStr  '/' cfg.sessionName];
    cfg.contextRepositoryFolderPath = [pwd filesep 'ContextRepository_20221206/'];
    cfg.contexts                    = get_contextNames_01(cfg.contextRepositoryFolderPath)
    cfg.mazeLibrary                 = mazeLibrary;

    cfg.externalStimFolderPath_Quaddle1 =  '"C:\\Users\\Womelsdorf Lab\\Desktop\\QuaddleRepository_20180515"';
    cfg.ContextExternalFilePath = '"C:\\Users\\Womelsdorf Lab\\Desktop\\MUSE\\Resources\\TextureImages"';
    cfg.TaskIconsFolderPath = '"C:\\Users\\Womelsdorf Lab\\Desktop\\MUSE\\Resources\\TaskIcons"';

    % --- --- --- --- --- --- --- --- --- --- ---
    % --- prepare session data
    % --- --- --- --- --- --- --- --- --- --- ---
    sessionData = [];
    sessionData(iSession).iSession          = iSession;
    sessionData(iSession).sessionPathName   = cfg.sessionPathName;
    sessionData(iSession).sessionName       = cfg.sessionName;
    sessionData(iSession).SerialPortAddress    = '"\\\\.\\COM5"';


     
tasksequence = [1 2 3 4 5];
% allow "r" for randomized task order 
if randomizeTaskOrder==1
    tasksequence = tasksequence(randperm(length(tasksequence)));
end


    % % --- --- --- --- --- --- --- --- --- --- ---
    % % --- VisualSearch 1
    % % --- --- --- --- --- --- --- --- --- --- ---
    %     iExpName = 'T1';
    % [a,typeID,c] = intersect(cfg.contexts.types,'Grass');
    % context_idx = find(cfg.contexts.typeID==typeID);
    % iContextName = cfg.contexts.name{context_idx(randi(length(context_idx)))};
    % cfg.nVisualSearchTrials = 200;
    % [cfg] = make_configs_VisualSearch_01(cfg,iExpName,iContextName);
    % cfg.taskSequence{end+1} = sprintf('%s:VisualSearch',cfg.out_visualSearch.taskFolderName);
    % cfg.taskIconSequence{end+1} = cfg.taskSequence{end};
   


for iTaskNumber=tasksequence
% --- --- --- --- --- --- --- --- --- --- --- 
% --- WorkingMemory:WorkingMemory
% --- --- --- --- --- --- --- --- --- --- --- 
    if iTaskNumber == 1
iExpName = 'WorkingMemory1';
%cfg.wm_difficultyLevel = 4;
cfg.wm_nTrials = 150;
if 0 %DF == 3 
%cfg.wm_difficultyLevel = 3
    cfg.wm_delaySec = [0.25 0.5 0.5 ];
cfg.wm_distractorSetSize = [2 1 0];
elseif 1 % DF == 4 
%cfg.wm_difficultyLevel = 4
    cfg.wm_delaySec = [ 0.25 0.5 0.75 1.25 1.75 ];
cfg.wm_distractorSetSize = [1 1 2];
end
[cfg] = make_configs_WorkingMemory_01(cfg,iExpName);
cfg.taskSequence{end+1} = sprintf('%s:WorkingMemory',cfg.out_workingMemory.taskFolderName);
cfg.taskIconSequence{end+1} = cfg.taskSequence{end};
    end

    % --- --- --- --- --- --- --- --- --- --- --- 
% --- Effort Control, EC1:EffortControl, 
% --- --- --- --- --- --- --- --- --- --- --- 
    if iTaskNumber == 2
    iExpName = 'EC1';
    cfg.effortControl_maxTrials = 80;
    cfg.effortControl_difficultyLevel = 4; %4 is increasing the number of outlines... 
    iContextName = {'011_058_021_001_3'};
    [cfg] = make_configs_EffortControl_01(cfg,iExpName,iContextName);
    cfg.taskSequence{end+1} = sprintf('%s:EffortControl',cfg.out_effortControl.taskFolderName);
    cfg.taskIconSequence{end+1} = cfg.taskSequence{end};
    end



    % --- --- --- --- --- --- --- --- --- --- ---
    % --- FlexLearning 1
    % --- --- --- --- --- --- --- --- --- --- ---
    if iTaskNumber == 3
    iExpName = 'FlexLearning1'; 
    %cfg.flexLearning_nBlocks = 36; 
    cfg.fl_nBlocks = 16; %  
    %cfg.flexLearning_numTrials_minMax = [32 50];
    cfg.fl_numTrials_minMax = [27 36];
    [cfg] = make_configs_FlexLearning_01(cfg,iExpName);
    cfg.taskSequence{end+1} = sprintf('%s:FlexLearning',cfg.out_flexLearning.taskFolderName);
    cfg.taskIconSequence{end+1} = cfg.taskSequence{end};
    end

    % --- --- --- --- --- --- --- --- --- --- ---
    % --- MazeGame guided, i.e. leaving feedback squares on, MChaseReactionTest
    % --- --- --- --- --- --- --- --- --- --- ---
    if iTaskNumber == 4
    iExpName = 'MazeGuided';
    cfg.mz_guidedMazeSelection = 'true'; %(true = chase reaction test, false = normal maze)
    if 0
    cfg.mz_difficultyLevel    = 1;
    cfg.mz_nMazes = 1;
    elseif 0
    cfg.mz_difficultyLevel    = 2;
    cfg.mz_nMazes = 2;
    else
    cfg.mz_difficultyLevel    = 3;
    cfg.mz_nMazes = 2;
    end
    [cfg] = make_configs_MazeGame_01(cfg,iExpName,[]);
    cfg.taskSequence{end+1} = sprintf('%s:MazeGame',cfg.out_mazeGame.taskFolderName);
    cfg.taskIconSequence{end+1} = cfg.taskSequence{end};
    end


  % --- --- --- --- --- --- --- --- --- --- ---
    % --- MazeGame guided, i.e. leaving feedback squares on, MChaseReactionTest
    % --- --- --- --- --- --- --- --- --- --- ---
    if iTaskNumber == 5
    iExpName = 'Maze1';
    cfg.mz_guidedMazeSelection = 'false'; %(true = chase reaction test, false = normal maze)
    if 1    cfg.mz_difficultyLevel    = 3;
    cfg.mz_nMazes = 1;
    end
    [cfg] = make_configs_MazeGame_01(cfg,iExpName,[]);
    cfg.taskSequence{end+1} = sprintf('%s:MazeGame',cfg.out_mazeGame.taskFolderName);
    cfg.taskIconSequence{end+1} = cfg.taskSequence{end};
    end

end

    if 0
        % --- --- --- --- --- --- --- --- --- --- ---
        % --- Continuous Recognition
        % --- --- --- --- --- --- --- --- --- --- ---

        % [cfg] = make_configs_ContinuousRecognition_01(cfg, sessionData(iSession).iSession)
        % cfg.taskSequence{end+1} = sprintf('%s:ContinuousRecognition',cfg.out_continuousRecognition.taskFolderName);
        % cfg.taskIconSequence{end+1} = cfg.taskSequence{end};

    end


    taskSequenceString = cfg.taskSequence{1};
    taskIconSequenceString = cfg.taskIconSequence{1};
    for iTS=2:length(cfg.taskSequence)
        taskSequenceString     = [taskSequenceString  ', '   cfg.taskSequence{iTS}];
        taskIconSequenceString = [taskIconSequenceString ', ' cfg.taskIconSequence{iTS}];
    end
    taskSequenceString = ['{' taskSequenceString '}'];
    taskIconSequenceString = ['{' taskIconSequenceString '}'];

    % --- --- --- --- --- --- --- --- --- --- ---
    % --- Specify and write session config:
    % --- --- --- --- --- --- --- --- --- --- ---
    %sessionData = [];
    sessionData(iSession).taskSequence      = taskSequenceString;
    sessionData(iSession).taskIconSequence  = taskIconSequenceString;
    sessionData(iSession).ContextExternalFilePath = cfg.ContextExternalFilePath; % '"C:\\Users\\WomLab_Unity\\OneDrive\\Desktop\\USE_Configs\\Resources\\TextureImages"';
    sessionData(iSession).TaskIconsFolderPath  = cfg.TaskIconsFolderPath; % '"C:\\Users\\WomLab_Unity\\OneDrive\\Desktop\\USE_Configs\\Resources\\TaskIcons"';
    sessionData(iSession).TaskSelectionTimeout = '20';%'3';
    sessionData(iSession).GuidedTaskSelection  = 'true';
    sessionData(iSession).IsHuman              = 'false';
    sessionData(iSession).StoreData            = 'true';
    sessionData(iSession).EventCodesActive     = 'true';
    sessionData(iSession).SyncBoxActive        = 'true';
    sessionData(iSession).SerialPortActive      = 'true';    
    sessionData(iSession).SerialPortSpeed      = '115200';
    sessionData(iSession).SyncBoxInitCommands      = '{"INI", "ECH 0", "TIM 0", "LIN 33", "LVB 0", "NSU 2", "NPD 10", "NHD 2", "NDW 16", "CAO 20000", "TBP 1000", "TBW 50", "TIB 1", "LOG 1"}';
    sessionData(iSession).SplitBytes      = '2';
    % --- set position of task icons/buttons
    %taskButtonPositionsInGrid = 'random';%'sequential';
    taskButtonPositionsInGrid = 'sequential';%;
    nTaskPositions = max([8 length(cfg.taskIconSequence)]);gridSpots=10:14;
    if nTaskPositions>5, gridSpots = [5:14], elseif nTaskPositions>10, gridSpots = [0:19], end
    iSel = 1:length(cfg.taskIconSequence); % default is 'sequential'
    if strcmp(taskButtonPositionsInGrid,'random'), iSel = randperm(length(cfg.taskIconSequence)); end
    iString=sprintf('%d, ',gridSpots(iSel)); iString(end-1:end)=[];
    sessionData(iSession).TaskButtonGridPositions = ['{' iString '}'];


 
    % --- write session config file
    write_SessionConfig_01(sessionData(iSession))

    % --- write sessionEvent config file
    eventCodes = write_SessionEventCodeConfig_01(cfg);% needs: cfg.sessionPathName
    
    if mod(iSession,10)==0, fprintf('#finished session %02d\n',iSession), end


end
