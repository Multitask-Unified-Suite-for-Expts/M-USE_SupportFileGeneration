function [iFilename, iPath] = write_TaskConfig_01(iPath, iFilename, taskconfig)
% taskconfig = [];
% taskconfig{end+1} = 'string	ContextExternalFilePath	"C:\\Users\\WomLab_Unity\\OneDrive\\Desktop\\USE_Configs\\Resources\\TextureImages"'
% taskconfig{end+1} = 'string	ExternalStimFolderPath	"C:\Users\WomLab_Unity\OneDrive\Desktop\USE_Configs\Resources\Stimuli"'
% taskconfig{end+1} = 'string	ExternalStimExtension	".fbx"'
% taskconfig{end+1} = 'float	ExternalStimScale	0.03'
% taskconfig{end+1} = 'Vector3	ButtonPosition	(0, 0, 0)'
% taskconfig{end+1} = 'Vector3	ButtonScale	(0.1, 0.1, 0.1)'
% taskconfig{end+1} = 'List<string>	FeedbackControllers	["Audio", "Halo", "Token"]'
% iFilename = [experimentName '_TaskDef.txt'];
%[iFilename, iPath] = write_TaskConfig_FlexLearn_01(iFilename, taskconfig)

%if isempty(taskconfig), taskconfig = []; end

%  --- --- --- --- --- --- --- ---
%iFilename_StimDef  = sprintf('%s_Set%02d_StimDef',iFilname);
fPtr = fopen([iPath iFilename],'w');
for iT = 1:length(taskconfig)
    if iT == 1
        fprintf(fPtr, '%s', taskconfig{iT});
    else
        fprintf(fPtr, '\n%s', taskconfig{iT});
    end
end
fclose(fPtr);


fprintf('\n wrote %s', [iFilename ]);
