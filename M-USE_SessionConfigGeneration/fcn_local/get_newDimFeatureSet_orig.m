function [dimFeat nDF] = get_newDimFeatureSet(dimensionFeatures,nDimensions,nFeatures)

rng('shuffle'),
dimFeat = cell(1,4);
nDF = [];

% --- select 3 feature values per dimension 
tmp = randperm(4);
dimensionList = tmp(1:nDimensions);
if any(ismember(dimensionList,1))
tmp = randperm(dimensionFeatures(1));
dimFeat{1} = tmp(1:nFeatures);
end
if any(ismember(dimensionList,2))
tmp = randperm(dimensionFeatures(2));
dimFeat{2} = tmp(1:nFeatures);
end
if any(ismember(dimensionList,3))
tmp = randperm(dimensionFeatures(3));
dimFeat{3} = tmp(1:nFeatures);
end
if any(ismember(dimensionList,4))
tmp = randperm(dimensionFeatures(4));
dimFeat{4} = tmp(1:nFeatures);
end

for j=1:length(dimFeat), nDF(j) = length(dimFeat{j}); end