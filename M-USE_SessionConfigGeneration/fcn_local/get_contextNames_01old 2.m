function contextNames = get_contextNames_01(contextTypes)

contextNames = [];

if isempty(contextTypes)
    contextTypes = 'WorkingMemory';
end

% --- this should become 
contexts = [];

contexts.defaultSet = {'Concrete';
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
'Blank'};

contexts.grassland = {'aland'; 'bland'};

iFieldNames = fieldnames(contexts)
%contextNames = getfield(contexts,iFieldNames{1})

% --- assign context names
if strcmp(contextTypes,'WorkingMemory')
    contextNames = getfield(contexts,'defaultSet')
end