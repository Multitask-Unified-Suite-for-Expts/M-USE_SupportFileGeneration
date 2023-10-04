function [target_array, distractor_array] = get_targetDistractor_Quaddle_01(dimFeat, nDF, iTargetFeat, iTargetDim)
% function [active_array, rule_array] = get_activeAndruleArrays(dimFeat, nDF, iTargetFeat, iTargetDim)

nTrials = 1
% nDF =     3     0     3     0
% dimFeat =  1×4 cell array  {[5 4 9]}    {0×0 double}    {[5 3 6]}    {0×0 double}
% nDF =     0     3     3     3
% iTargetFeat = 2
% iTargetDim = 3

for iT = 1:nTrials 

    


end


return;
        active_array = [];
        rule_array = [];
        shape_str = [];        pattern_str = [];       color_str = [];        arm_str = [];
       
        allDims = find(nDF~=0);
        for j=1:length(allDims)
        if  allDims(j) == 1 &&  ~isempty(dimFeat{1}) %shape
            shape_str =    ['[' strjoin(arrayfun(@(x) num2str(x),dimFeat{1},'UniformOutput',false),',') ']'];
            if iTargetDim==allDims(j), rule_array = ['[' num2str(dimFeat{1}(iTargetFeat)) '],[-1],[-1],[-1],[-1]']; end %since stimuli are chosen at random jsut set 1st one as rewarded
        elseif allDims(j) == 2 && ~isempty(dimFeat{2}) %pattern
            pattern_str =       ['[' strjoin(arrayfun(@(x) num2str(x),dimFeat{2},'UniformOutput',false),',') ']'];
            if iTargetDim==allDims(j), rule_array = ['[-1],[' num2str(dimFeat{2}(iTargetFeat)) '],[-1],[-1],[-1]']; end %since stimuli are chosen at random jsut set 1st one as rewarded
        elseif allDims(j) == 3 && ~isempty(dimFeat{3})%color
            color_str =              ['[' strjoin(arrayfun(@(x) num2str(x),dimFeat{3},'UniformOutput',false),',') ']'];
            if iTargetDim==allDims(j), rule_array = ['[-1],[-1],[' num2str(dimFeat{3}(iTargetFeat)) '],[-1],[-1]']; end
        elseif allDims(j) == 4 && ~isempty(dimFeat{4})%arms
            arm_str =                          ['[' strjoin(arrayfun(@(x) num2str(x),dimFeat{4},'UniformOutput',false),',') ']'];
            if iTargetDim==allDims(j), rule_array = ['[-1],[-1],[-1],[-1],[' num2str(dimFeat{4}(iTargetFeat)) ']']; end
        else
            error('ER #tyuo873:  Stimulus not recognized')
        end
        end
        if isempty(shape_str), shape_str = '[0]'; end
        if isempty(pattern_str), pattern_str = '[0]'; end
        if isempty(color_str), color_str = '[0]'; end
        if isempty(arm_str), arm_str = '[0]'; end
        
        active_array = [ '[' shape_str ',' pattern_str ',' color_str ',[0],' arm_str ']' ];
        
        
%        active_array
%        rule_array