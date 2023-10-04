function [dimFeat nDF] = get_newDimFeatureSet(dimensionFeatures,nDimensions,nFeatures,iExcludeDimension,iEnforceDimension,iExcludeFeaturesOfEnforcedDimension)

rng('shuffle'),
dimFeat = cell(1,4);
nDF = [];

dimensionList = 1:4;
% --- exclude some dimensions from consideration ?
if ~isempty(iExcludeDimension)
    [a,b,c] = intersect(dimensionList,iExcludeDimension);
    dimensionList(b)=[];
end

% --- cut down to relevant nDimensions
tmp = randperm(length(dimensionList));
dimensionList  = dimensionList(tmp(1:nDimensions));

% --- enforce a specific dimension ?
if ~isempty(iEnforceDimension)
    tmp = find(dimensionList==iEnforceDimension);
    % if enforcedDimension is not yet in the list, add it
    if isempty(tmp)
        % first remove a selected dimension before adding a new
        dimensionList(end) = [];
        dimensionList(end+1) = iEnforceDimension;
    end
end

if any(ismember(dimensionList,1))
    allFeatures = randperm(dimensionFeatures(1));
    if iEnforceDimension==1 & ~isempty(iExcludeFeaturesOfEnforcedDimension)
        [a,b,c]=intersect(allFeatures,iExcludeFeaturesOfEnforcedDimension);
        allFeatures(b) = [];
    end
    dimFeat{1} = allFeatures(1:nFeatures);
end
if any(ismember(dimensionList,2))
    allFeatures = randperm(dimensionFeatures(2));
    if iEnforceDimension==2 & ~isempty(iExcludeFeaturesOfEnforcedDimension)
        [a,b,c]=intersect(allFeatures,iExcludeFeaturesOfEnforcedDimension);
        allFeatures(b) = [];
    end
    dimFeat{2} = allFeatures(1:nFeatures);
end
if any(ismember(dimensionList,3))
    allFeatures = randperm(dimensionFeatures(3));
    if iEnforceDimension==3 & ~isempty(iExcludeFeaturesOfEnforcedDimension)
        [a,b,c]=intersect(allFeatures,iExcludeFeaturesOfEnforcedDimension);
        allFeatures(b) = [];
    end
    dimFeat{3} = allFeatures(1:nFeatures);
end
if any(ismember(dimensionList,4))
    allFeatures = randperm(dimensionFeatures(4));
    if iEnforceDimension==4 & ~isempty(iExcludeFeaturesOfEnforcedDimension)
        [a,b,c]=intersect(allFeatures,iExcludeFeaturesOfEnforcedDimension);
        allFeatures(b) = [];
    end
    dimFeat{4} = allFeatures(1:nFeatures);
end

for j=1:length(dimFeat), nDF(j) = length(dimFeat{j}); end