function [stimValues, isTarget] = get_objects_01(dimFeat, nDF, iTargetFeat, iTargetDim);
%function [active_array, rule_array] = get_activeAndruleArrays(dimFeat, nDF, iTargetFeat, iTargetDim)

% --- get stimuli with all feature combinations and detemrine which
% --- stimulus vectors contain the target feature.

stimValues = zeros(1,4); iS=0;
isTarget = [];

if isempty(dimFeat{1}) dimFeat{1} = 0; end % shapes
if isempty(dimFeat{2}) dimFeat{2} = 0; end % patterns
if isempty(dimFeat{3}) dimFeat{3} = 0; end % patternless_colors
if isempty(dimFeat{4}) dimFeat{4} = 0; end % arms

for j=1:length(dimFeat{1})
    for k=1:length(dimFeat{2})
        for m=1:length(dimFeat{3})
            for n=1:length(dimFeat{4})
                iS=iS+1;
                stimValues(iS,1:4) = [ dimFeat{1}(j) dimFeat{2}(k) dimFeat{3}(m) dimFeat{4}(n)];
                % if stimulus vectors contains the target feature in the
                % target dimension:
                if stimValues(iS,iTargetDim) == iTargetFeat,
                    isTarget(iS) = 1;
                else
                    isTarget(iS) = 0;
                end
            end
        end
    end
end