function stimNames = get_Quaddle1Name_01(Q1,stimValues)


% stimValues =
% 
%      1     0     2     0
%      1     0     5     0
%      1     0     8     0
%      3     0     2     0
%      3     0     5     0
%      3     0     8     0
%      6     0     2     0
%      6     0     5     0
%      6     0     8     0

% Q1 = [];
% Q1.shapes = {'S01', 'S02', 'S03', 'S04', 'S05', 'S06', 'S07', 'S08', 'S09'};
% Q1.patterns = {'P01', 'P02', 'P03', 'P04', 'P05', 'P06', 'P07', 'P08', 'P09'};
% Q1.patternless_colors = {'C6070014_6070014', 'C6070059_6070059', 'C6070106_6070106', 'C6070148_6070148', 'C6070194_6070194', 'C6070239_6070239', 'C6070287_6070287', 'C6070335_6070335'};%patternless C70: C7070240_7070240
% Q1.patterned_colors =   {'C7070014_5000000', 'C7070059_5000000', 'C7070106_5000000', 'C7070148_5000000', 'C7070194_5000000', 'C7070240_5000000', 'C7070286_5000000', 'C7070335_5000000'};
% Q1.gray_pattern_color = 'C7000000_5000000';
% Q1.arms = {'A00_E01', 'A00_E02', 'A00_E03', 'A01_E00', 'A01_E01', 'A01_E02', 'A01_E03', 'A02_E00', 'A02_E01', 'A02_E02', 'A02_E03'};
% 'S04_P00_C7070059_5000000_T00_A01_E01.fbx'
%  S04_P00_C7070059_5000000_T00_A01_E01
%  S04_P01_C7070059_5000000_T00_A01_E01

stimNames = {};
for iS = 1:size(stimValues,1)    

        if (stimValues(iS,1)>0) %shapes
            Quaddle_name = [Q1.shapes{stimValues(iS,1)} '_'];
        else
            Quaddle_name = 'S00_';
        end
 
        if (stimValues(iS,2)>0) %patterns
            Quaddle_name = [Quaddle_name Q1.patterns{stimValues(iS,2)} '_'];
        else
            Quaddle_name = [Quaddle_name 'P00_'];
        end

        if  (stimValues(iS,3)>0)%colors
            %if isnan(stimValues(iS,2)) %patternless
            if ~(stimValues(iS,2)>0) %isnan(stimValues(iS,2)) %patternless
                Quaddle_name = [Quaddle_name Q1.patternless_colors{stimValues(iS,3)} '_T00_'];
            else
                Quaddle_name = [Quaddle_name  Q1.patterned_colors{stimValues(iS,3)} '_T00_'];
            end
        else
            if ~(stimValues(iS,2)>0)%patternless
                Quaddle_name = [Quaddle_name 'C6000000_6000000_T00_'];
            else
                Quaddle_name = [Quaddle_name 'C7000000_5000000_T00_'];
            end
        end
        if (stimValues(iS,4)>0)
            Quaddle_name = [Quaddle_name Q1.arms{stimValues(iS,4)} '.fbx'];
        else
            Quaddle_name = [Quaddle_name 'A00_E00.fbx'];
        end
        stimNames{iS} = Quaddle_name;
    end
%fprintf('got Quaddle names\n')
     