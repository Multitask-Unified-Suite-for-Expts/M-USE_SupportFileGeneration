function [sessionData] = write_SessionConfig_01(sessionData)

%sessionData(iSession).iPath             = cfg.sessionPath;
%sessionData(iSession).iFilename         = cfg.sessionName; 

% sessionData = [].
% sessionData(iS).iPath             = 
% sessionData(iS).iFilename         = 
% sessionData(iS).taskSequence      = '{VisualSearch:VisualSearch, WorkingMemory:WorkingMemory}';
% sessionData(iS).taskIconSequence  = '{VisualSearch:VisualSearch, WorkingMemory:WorkingMemory}';
% sessionData(iS).ContextName       = '"Winter"';
% sessionData(iS).ContextExternalFilePath = '"C:\\Users\\WomLab_Unity\\OneDrive\\Desktop\\USE_Configs\\Resources\\TextureImages"';
% sessionData(iS).TaskIconsFolderPath = '"C:\\Users\\WomLab_Unity\\OneDrive\\Desktop\\USE_Configs\\Resources\\TaskIcons"';
% sessionData(iS).TaskSelectionTimeout = '0';
% sessionData(iS).StoreData            = 'true';
% sessionData(iS).EventCodesActive     = 'true';
% sessionData(iS).SyncBoxActive        = 'false';
% sessionData(iS).SerialPortAddress    = '"\\\\.\\COM3"';
% sessionData(iS).SerialPortSpeed      = '115200';

%if ~exist(sessionData.sessionPathName), mkdir(sessionData.sessionPathName), end

iS = 1;

Str = {};
if isfield(sessionData, 'taskSequence') & ~isempty(sessionData(iS).taskSequence)
Str{end+1}     =  sprintf('OrderedDictionary<string,string>\tTaskMappings\t%s', sessionData(iS).taskSequence);
end
if isfield(sessionData, 'taskIconSequence') & ~isempty(sessionData(iS).taskIconSequence)
Str{end+1} =  sprintf('Dictionary<string,string>\tTaskIcons\t%s', sessionData(iS).taskIconSequence); 
end
if isfield(sessionData, 'ContextExternalFilePath') & ~isempty(sessionData(iS).ContextExternalFilePath)
%Str{end+1} =  sprintf('string\tContextName\t%s', sessionData(iS).ContextName);
Str{end+1} =  sprintf('string\tContextExternalFilePath\t%s',  sessionData(iS).ContextExternalFilePath);	
end
if isfield(sessionData, 'TaskIconsFolderPath') & ~isempty(sessionData(iS).TaskIconsFolderPath)
Str{end+1} =  sprintf('string\tTaskIconsFolderPath\t%s',  sessionData(iS).TaskIconsFolderPath);
end
if isfield(sessionData, 'TaskSelectionTimeout') & ~isempty(sessionData(iS).TaskSelectionTimeout)
Str{end+1} =  sprintf('float\tTaskSelectionTimeout\t%s',  sessionData(iS).TaskSelectionTimeout);	
end
if isfield(sessionData, 'GuidedTaskSelection') & ~isempty(sessionData(iS).GuidedTaskSelection)
Str{end+1} =  sprintf('bool\tGuidedTaskSelection\t%s',  sessionData(iS).GuidedTaskSelection);	
end
if isfield(sessionData, 'MacMainDisplayBuild	') & ~isempty(sessionData(iS).MacMainDisplayBuild	)
Str{end+1} =  sprintf('bool\tMacMainDisplayBuild	\t%s',  sessionData(iS).MacMainDisplayBuild	);	
end
if isfield(sessionData, 'IsHuman') & ~isempty(sessionData(iS).IsHuman)
Str{end+1} =  sprintf('bool\tIsHuman\t%s',  sessionData(iS).IsHuman);	
end

if isfield(sessionData, 'RewardHotKeyNumPulses') & ~isempty(sessionData(iS).RewardHotKeyNumPulses)
Str{end+1} =  sprintf('int\tRewardHotKeyNumPulsest%d',  sessionData(iS).RewardHotKeyNumPulses);	
end
if isfield(sessionData, 'RewardHotKeyPulseSize') & ~isempty(sessionData(iS).RewardHotKeyPulseSize)
Str{end+1} =  sprintf('int\tRewardHotKeyPulseSize\t%s',  sessionData(iS).RewardHotKeyPulseSize);	
end
if isfield(sessionData, 'ShotgunRaycastCircleSize_DVA') & ~isempty(sessionData(iS).ShotgunRaycastCircleSize_DVA)
Str{end+1} =  sprintf('float\tShotgunRaycastCircleSize_DVA\t%s',  sessionData(iS).ShotgunRaycastCircleSize_DVA);	
end
if isfield(sessionData, 'ParticipantDistance_CM') & ~isempty(sessionData(iS).ParticipantDistance_CM)
Str{end+1} =  sprintf('float\tParticipantDistance_CM\t%s',  sessionData(iS).ParticipantDistance_CM);	
end
if isfield(sessionData, 'ShotgunRaycastSpacing_DVA') & ~isempty(sessionData(iS).ShotgunRaycastSpacing_DVA)
Str{end+1} =  sprintf('float\tShotgunRaycastSpacing_DVA\t%s',  sessionData(iS).ShotgunRaycastSpacing_DVA);	
end
if isfield(sessionData, 'StoreData') & ~isempty(sessionData(iS).StoreData)
Str{end+1} =  sprintf('bool\tStoreData\t%s',  sessionData(iS).StoreData);	
end
if isfield(sessionData, 'EventCodesActive') & ~isempty(sessionData(iS).EventCodesActive)
Str{end+1} =  sprintf('bool\tEventCodesActive\t%s',  sessionData(iS).EventCodesActive);	
end
if isfield(sessionData, 'SyncBoxActive') & ~isempty(sessionData(iS).SyncBoxActive)
Str{end+1} =  sprintf('bool\tSyncBoxActive\t%s',  sessionData(iS).SyncBoxActive);	
end
if isfield(sessionData, 'SerialPortActive') & ~isempty(sessionData(iS).SerialPortActive)
Str{end+1} =  sprintf('bool\tSerialPortActive\t%s',  sessionData(iS).SerialPortActive);	
end
if isfield(sessionData, 'SerialPortSpeed') & ~isempty(sessionData(iS).SerialPortSpeed)
Str{end+1} =  sprintf('int\tSerialPortSpeed\t%s',  sessionData(iS).SerialPortSpeed);	
end
if isfield(sessionData, 'SplitBytes') & ~isempty(sessionData(iS).SplitBytes)
Str{end+1} =  sprintf('int\tSplitBytes\t%s',  sessionData(iS).SplitBytes);	
end
if isfield(sessionData, 'SerialPortAddress') & ~isempty(sessionData(iS).SerialPortAddress)
Str{end+1} =  sprintf('string\tSerialPortAddress\t%s', sessionData(iS).SerialPortAddress  );   
end
if isfield(sessionData, 'SyncBoxInitCommands') & ~isempty(sessionData(iS).SyncBoxInitCommands)
Str{end+1} =  sprintf('List<string>\tSyncBoxInitCommands\t%s', sessionData(iS).SyncBoxInitCommands );
end
if isfield(sessionData, 'TaskButtonGridPositions') & ~isempty(sessionData(iS).SyncBoxInitCommands)
Str{end+1} =  sprintf('List<int>\tTaskButtonGridPositions\t%s', sessionData(iS).TaskButtonGridPositions );
end

% sessionData(iS).TaskIconLocations_N = [];
% sessionData(iS).TaskIconLocations_N{1}      = [-310.0,0.0,0.0];
% sessionData(iS).TaskIconLocations_N{2}      = [0.0,100.0,0.0];
% sessionData(iS).TaskIconLocations_N{3}      = [310.0,0.0,0.0];
% if isfield(sessionData, 'TaskIconLocations_N')
%     if ~isempty(sessionData(iS).TaskIconLocations_N)
%         tmp = '';
%         for ij=1:length(sessionData(iS).TaskIconLocations_N)
%             tmp = [tmp sprintf('[%.1f,%.1f,%.1f ],', sessionData(iS).TaskIconLocations_N{ij}(1),sessionData(iS).TaskIconLocations_N{ij}(2),sessionData(iS).TaskIconLocations_N{ij}(3))];
%         end
%         tmp(end)=[];
%         Str{end+1} =  sprintf('Vector3[]	TaskIconLocations	[%s]',tmp);
%     end
% end
% 

if ~exist(sessionData(iS).sessionPathName), mkdir(sessionData(iS).sessionPathName), end

fPtr = fopen([sessionData(iS).sessionPathName '/' sessionData(iS).sessionName  '_singleType.txt'],'w');
for iSt=1:length(Str)
        fprintf(fPtr, '%s\n', Str{iSt});
end
    
fclose(fPtr);

fprintf('\n wrote %s', [ sessionData(iS).sessionName ]);

