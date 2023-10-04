function mazeNames = get_mazeNames_01(mazeLibraryPath)

mazeNames = [];
% mazeLibraryPath =    '/Users/thiwom/Main/projects/201912_P_KioskFluBehavior/#ms_CognitiveGames_Kiosk/GAMES_MATLAB/MazesLibrary_20230314/'

if ~strcmp(mazeLibraryPath(end),filesep), mazeLibraryPath = [mazeLibraryPath filesep ]; end

%filelist = dir(fullfile(mazeLibraryPath, '**/*.*')); %get list of files and folders in any subfolder
filelist = dir(fullfile(mazeLibraryPath, '**/*')); %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);  %remove folders from list
j=0;
for k=1:length(filelist), 
    if strcmp(filelist(k).name,'.DS_Store'), continue, end
    if filelist(k).isdir==1, error('huu'), end
    if isempty(findstr(filelist(k).name,'M')), continue, end
    j=j+1;
    mazeNames.name{j} = filelist(k).name;
    mazeNames.folder{j} = filelist(k).folder;%Z
%     for iC=1:length(contexts.types), 
%         if ~isempty(findstr(contexts.types{iC},contexts.folder{j})), 
%             contexts.typeID(j) = iC;
%             break, 
%         end
%     end
end

% for mazes we have context type Leather
%[a,typeID,c] = intersect(contexts.types,'Leather');
%context_idx = find(contexts.typeID==typeID);
%sel = randi(length(context_idx))

