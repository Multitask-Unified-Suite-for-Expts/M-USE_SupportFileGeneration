function contexts = get_contextNames_01(contextRepositoryFolderPath)

% contextRepositoryFolderPath = [pwd filesep 'ContextRepository_20221206/'];

contexts = [];
contexts.types = {'Carpet';'Clouds';'Coal';'Copper';'Fire';'Grass';'Leather'; ... 
            'Leaves';'Rock';'Sand';'Sky';'Soil';'Stars';'Water';'Wood'}
contexts.typeID = []
contexts.name = {};
contexts.folder = {};

%contextRepositoryFolderPath = [pwd filesep 'ContextRepository_20221206/']
filelist = dir(fullfile(contextRepositoryFolderPath, '**/*.*')); %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);  %remove folders from list
j=0;
for k=1:length(filelist), 
    if strcmp(filelist(k).name,'.DS_Store'), continue, end
    if filelist(k).isdir==1, error('huu'), end
    j=j+1;
    contexts.name{j} = filelist(k).name;
    contexts.folder{j} = filelist(k).folder;
    for iC=1:length(contexts.types), 
        if ~isempty(findstr(contexts.types{iC},contexts.folder{j})), 
            contexts.typeID(j) = iC;
            break, 
        end
    end
end

% for mazes we have context type Leather
%[a,typeID,c] = intersect(contexts.types,'Leather');
%context_idx = find(contexts.typeID==typeID);
%sel = randi(length(context_idx))
