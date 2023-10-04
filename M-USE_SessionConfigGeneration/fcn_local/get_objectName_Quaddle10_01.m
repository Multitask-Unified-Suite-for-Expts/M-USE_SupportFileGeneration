function iObjectName = get_objectName_Quaddle10_01(iObjectVector)
% expect a vector with 4 numbers. ) mean neutral.

% iObjectVector = iObject_set_1D_sameDimU(1,:);
% --- select quaddle objects
 shapes = {'S01', 'S02', 'S03', 'S04', 'S05', 'S06', 'S07', 'S08', 'S09'};
 patterns = {'P01', 'P02', 'P03', 'P04', 'P05', 'P06', 'P07', 'P08', 'P09'};
% % use patternless color if no (i.e. a nuetral')pattern is specified
 patternless_colors = {'C6070014_6070014', 'C6070059_6070059', 'C6070106_6070106', 'C6070148_6070148', 'C6070194_6070194', 'C6070287_6070287', 'C6070335_6070335','C6070240_6070240'};
 patterned_colors =   {'C7070014_5000000', 'C7070059_5000000', 'C7070106_5000000', 'C7070148_5000000', 'C7070194_5000000', 'C7070286_5000000', 'C7070335_5000000','C7070240_5000000'};
 gray_pattern_color = 'C7000000_5000000';
 %arms = {'A00_E01', 'A00_E02','A00_E03', 'A01_E00', 'A02_E00'}; %limit because background makes it tougher to discriminate
 arms = {'A00_E01', 'A00_E02','A00_E03', 'A01_E00', 'A01_E01', 'A01_E02', 'A01_E03', 'A02_E00', 'A02_E01', 'A02_E02', 'A02_E03'};

iObjectName = '';

        if iObjectVector(1) ~= 0
            iObjectName = [shapes{iObjectVector(1)} '_'];
        else
            iObjectName = 'S00_';
        end
        if iObjectVector(2) ~= 0 
            iObjectName = [iObjectName patterns{iObjectVector(2)} '_'];
        else
            iObjectName = [iObjectName 'P00_'];
        end
        if iObjectVector(3) ~= 0
            if iObjectVector(2) == 0 % if there is no pattern (=0) then do patternless color
                iObjectName = [iObjectName patternless_colors{iObjectVector(3)} '_T00_'];
            else
                iObjectName = [iObjectName  patterned_colors{iObjectVector(3)} '_T00_'];
            end
        else
            if iObjectVector(2) == 0 % if there is no pattern (=0) then do patternless color
                iObjectName = [iObjectName 'C6000000_6000000_T00_'];
            else 
                iObjectName = [iObjectName 'C7000000_5000000_T00_'];
            end
        end
        if iObjectVector(4) ~= 0
            iObjectName = [iObjectName arms{iObjectVector(4)} ];
            %iObjectName = [iObjectName arms{iObjectVector(4)} '.fbx'];
        else
            iObjectName = [iObjectName 'A00_E00'];
            %iObjectName = [iObjectName 'A00_E00.fbx'];
        end
        