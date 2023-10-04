
% --- M-USE matlab support file
% ---
% --- make_MazeLibrary_MatFile reads a folder and its subfolders to
% --- collect the names of the mazes used in the MazeGame

% --- the mazes were generated with:
% --- the generated mazes were stored ina folder like:


% mazeLibraryPath             = [pwd filesep 'MazesLibrary_20230314/'];
mazeLibraryPath = '/Volumes/Womelsdorf Lab/Resources/LatestMazeGeneration/MazesLibrary_20230604/';

mazeLibrary = [];
mazeLibrary.name = [];
mazeLibrary.folder = [];

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
    mazeLibrary.name{j} = filelist(k).name;
    mazeLibrary.folder{j} = filelist(k).folder;%Z

end

if ~isfield(mazeLibrary,'string')
    for j=1:length(mazeLibrary.name)
        fPtr = fopen([mazeLibrary.folder{j} filesep  mazeLibrary.name{j} ]);
        mazeLibrary.string{j} = fgetl(fPtr);
        fclose(fPtr);
        if mod(j,10000)==0, sprintf('%d/n',j), end
        %{"sideRestricted":"TRUE","mDims":{"x":6,"y":6},"mPath":["A1","A2"],"mStart":"A1","mFinish":"A2","mNumTurns":0,"mNumSquares":2}'
        %       mazeLibraryPath = '/Volumes/Womelsdorf Lab/Resources/LatestMazeGeneration/MazesLibrary_20230604/';
    end
end

save('MazeLibrary_20230604_tmp','mazeLibrary','-v7.3')
%save('MazeLibrary_20230604','mazeLibrary2','-v7.3')
%save('MazeLibrary_20230604_MAT','mazeLibrary','-v7.3') ... contains also
%the folder info


