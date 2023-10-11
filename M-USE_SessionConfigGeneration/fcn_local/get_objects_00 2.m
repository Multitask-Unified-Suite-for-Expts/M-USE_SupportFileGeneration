function [stimValues, isTarget] = get_objects_00(dimFeat, nDF, iTargetFeat, iTargetDim);
%function [active_array, rule_array] = get_activeAndruleArrays(dimFeat, nDF, iTargetFeat, iTargetDim)
%

% dimFeat =  1×4 cell array {0×0 double}    {[6 5 7]}    {[3 1 7]}    {[9 6 2]}
% nDF =     0     3     3     3
%iTargetFeat = 2
%iTargetDim = 3

% add the actual target to all stimuli (is separated later)
dimFeat{iTargetDim}(end+1) = iTargetFeat;
stimValues = zeros(1,4); iS=0;
isTarget = [];

if isempty(dimFeat{1}) dimFeat{1} = 0; end
if isempty(dimFeat{2}) dimFeat{2} = 0; end
if isempty(dimFeat{3}) dimFeat{3} = 0; end
if isempty(dimFeat{4}) dimFeat{4} = 0; end


% dimensionFeatures = [length(shapes) length(patterns) length(patternless_colors) length(arms) ];
for j=1:length(dimFeat{1})
    for k=1:length(dimFeat{2})
        for m=1:length(dimFeat{3})
            for n=1:length(dimFeat{4})
                iS=iS+1;
                stimValues(iS,1:4) = [ dimFeat{1}(j) dimFeat{2}(k) dimFeat{3}(m) dimFeat{4}(n)];
                if stimValues(iS,iTargetDim) == iTargetFeat,
                    isTarget(iS) = 1;
                else
                    isTarget(iS) = 0;
                end

            end
        end
    end
end
[a,b,c]=unique(stimValues,'rows');
stimValues = stimValues(b,:);
isTarget = isTarget(b)';

%fprintf('got object feature values for target and distractors\n')
%stimValues
%isTarget
%
%     iS = 1
% stimVal(iS,1:4) = [sim]
%
% nDF
%
% dimFeat{3}(m)
%
%
%
% shape_str = [];        pattern_str = [];       color_str = [];        arm_str = [];
%
% allDims = find(nDF~=0);
% %--- get all combinations of objects
% allDims
% for j=1;length(allDims)
%
%
%
% dimFeat{allDims(j)}
%
% for j=1:length(allDims)
%     if  allDims(j) == 1 &&  ~isempty(dimFeat{1}) %shape
%         shape_str =    ['[' strjoin(arrayfun(@(x) num2str(x),dimFeat{1},'UniformOutput',false),',') ']'];
%
%         if iTargetDim==allDims(j), rule_array = ['[' num2str(dimFeat{1}(iTargetFeat)) '],[-1],[-1],[-1],[-1]']; end %since stimuli are chosen at random jsut set 1st one as rewarded
%     elseif allDims(j) == 2 && ~isempty(dimFeat{2}) %pattern
%         pattern_str =       ['[' strjoin(arrayfun(@(x) num2str(x),dimFeat{2},'UniformOutput',false),',') ']'];
%
%         if iTargetDim==allDims(j), rule_array = ['[-1],[' num2str(dimFeat{2}(iTargetFeat)) '],[-1],[-1],[-1]']; end %since stimuli are chosen at random jsut set 1st one as rewarded
%     elseif allDims(j) == 3 && ~isempty(dimFeat{3})%color
%         color_str =              ['[' strjoin(arrayfun(@(x) num2str(x),dimFeat{3},'UniformOutput',false),',') ']'];
%
%         if iTargetDim==allDims(j), rule_array = ['[-1],[-1],[' num2str(dimFeat{3}(iTargetFeat)) '],[-1],[-1]']; end
%     elseif allDims(j) == 4 && ~isempty(dimFeat{4})%arms
%         arm_str =                          ['[' strjoin(arrayfun(@(x) num2str(x),dimFeat{4},'UniformOutput',false),',') ']'];
%
%         if iTargetDim==allDims(j), rule_array = ['[-1],[-1],[-1],[-1],[' num2str(dimFeat{4}(iTargetFeat)) ']']; end
%     else
%         error('ER #tyuo873:  Stimulus not recognized')
%     end
% end
%
%
% if isempty(shape_str), shape_str = '[0]'; end
% if isempty(pattern_str), pattern_str = '[0]'; end
% if isempty(color_str), color_str = '[0]'; end
% if isempty(arm_str), arm_str = '[0]'; end
%
% active_array = [ '[' shape_str ',' pattern_str ',' color_str ',[0],' arm_str ']' ];


%        active_array
%        rule_array