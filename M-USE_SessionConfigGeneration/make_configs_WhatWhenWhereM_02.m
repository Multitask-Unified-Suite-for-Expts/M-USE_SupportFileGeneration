function [cfg] = make_configs_WhatWhenWhere_01(cfg,iExpName)

if ~isfield(cfg,'out_whatWhenWhere'), cfg.out_whatWhenWhere = []; end
cfg.out_whatWhenWhere.iPath = [];
if ~exist(cfg.sessionPathName), mkdir(cfg.sessionPathName), end
cfg.out_whatWhenWhere.experimentName =  sprintf('WhatWhenWhere_v01_Set%.2d',cfg.iSet);
cfg.out_whatWhenWhere.taskFolderName = cfg.out_whatWhenWhere.experimentName;
cfg.out_whatWhenWhere.iPath = [cfg.sessionPathName '/' cfg.out_whatWhenWhere.taskFolderName '/'];
if ~exist(cfg.out_whatWhenWhere.iPath), mkdir(cfg.out_whatWhenWhere.iPath), end


%% Adjust Difficulty Level
difficulty_level = cfg.difficultyLevel;
rng('shuffle');
iBlockDefPath = [cfg.identifierStr  '/' cfg.sessionName '/' cfg.out_whatWhenWhere.taskFolderName];
iPath = cfg.out_whatWhenWhere.iPath;

iContextExternalFilePath = iPath;
experimentName = sprintf("WWW_%s_Set%.2d",iExpName,cfg.iSet);

disp(isfield(cfg.out_whatWhenWhere,'print_repeat') && cfg.out_whatWhenWhere.print_repeat == true)

% CHECK IF ONLY PRINTING REPEAT BLOCK
if isfield(cfg.out_whatWhenWhere,'print_repeat') && cfg.out_whatWhenWhere.print_repeat == true

	
	reshuffled_indices = cfg.out_whatWhenWhere.reshuffled_indices;
	repeated_blocks = cfg.out_whatWhenWhere.repeated_blocks;

	previous_stimuli_config_path = cfg.out_whatWhenWhere.previous_stimuli_config_path;
	previous_stimuli_path = cfg.out_whatWhenWhere.previous_stimuli_path;

	% write block def
	iFilename_BlockDef  = sprintf('WhatWhenWhere_BlockDeftdf_array');
	subfolder_iPath = iPath;

	if ~exist(subfolder_iPath), mkdir(subfolder_iPath), end
	fid = fopen([subfolder_iPath iFilename_BlockDef '.txt'],'w');
	fprintf(fid, 'BlockName\tContextName\tCorrectObjectTouchOrder\tnRepetitionsMinMax\tSearchStimsIndices\tSearchStimsLocations\tSliderGain\tSliderLoss\tSliderInitial\tRandomizedLocations\tDistractorStimsIndices\tDistractorStimsLocations\tNumPulses\tPulseSize\tBlockEndType\tBlockEndWindow\tBlockEndThreshold\tLeaveFeedbackOn\tErrorThreshold\n');
	writeBlocksDef(repeated_blocks, reshuffled_indices, fid);

	% write stim def
	config_path = previous_stimuli_config_path; % path to config files
	stimuli_path = previous_stimuli_path; % path to stimuli files

	iFilename_StimDef  = sprintf('WhatWhenWhere_StimDeftdf_array');
	write_StimDef_WWW(config_path, stimuli_path ,subfolder_iPath, iFilename_StimDef)

	% write task def
	iFilename_TaskDef  = sprintf('WhatWhenWhere_TaskDef_singletype');
	write_TaskDef_WWW(subfolder_iPath, iFilename_TaskDef)

	% write EventCode files
	iFilename_EventCode =  sprintf('WhatWhenWhere_EventCodeConfig_json');
	write_EventCode_WWW_01(subfolder_iPath, iFilename_EventCode);
	iFilename_ConfigUIDetails =  sprintf('WhatWhenWhere_ConfigUiDetails_json');
	write_ConfigUIDetails_WWW(subfolder_iPath, iFilename_ConfigUIDetails);

	disp("REPEAT DONE"), return
end

switch difficulty_level
	case 1
		is_object_structure_reversing = true;
		is_context_change = true;
		is_equal_reward = true;
		using_gray_context = false;
		isDistractor = false;
		is_repeat= true;
		is_repetition_with_extra = false;
		object_squence_type = '12';
		reward_structure_type = '0';
		num_blocks = 6;
		num_object_per_block = [2,3]; % [2,3]
		num_pulse_per_block = [1,2];
		num_pulse_size = [250, 250];
		proportions = [1, 0];
		num_different_type_block = split_even_blocks(num_blocks, proportions, is_object_structure_reversing);
	case 2
		is_object_structure_reversing = true;
		is_equal_reward = true;
		using_gray_context = false;
		is_context_change = true;
		isDistractor = false;
		is_repeat= false;
		object_squence_type = '12';
		reward_structure_type = '0';
		num_blocks = 40;
		num_object_per_block = [2,3,4];
		num_pulse_per_block = [1,2,4];
		num_pulse_size = [250, 250, 250];

		proportions = [0.2, 0.4, 0.4];
		num_different_type_block = split_even_blocks(num_blocks, proportions, is_object_structure_reversing);
	case 3
		is_object_structure_reversing = true;
		is_equal_reward = true;
		isDistractor = false;
		using_gray_context = false;
		is_context_change = true;
		is_repeat= false;


		object_squence_type = '12';
		reward_structure_type = '0';

		% Important thing to change
		num_blocks = 40;
		num_object_per_block = [3,4,5];

		num_pulse_per_block = [2,3,5];
		num_pulse_size = [250, 250, 250];

		proportions = [0.4, 0.4, 0.2];
		num_different_type_block = split_even_blocks(num_blocks, proportions, is_object_structure_reversing);

	case 3.2
		is_object_structure_reversing = true;
		is_equal_reward = true;
		isDistractor = false;
		using_gray_context = false;
		is_context_change = true;

		is_repeat= false;

		object_squence_type = '12';
		reward_structure_type = '0';

		% Important thing to change
		num_blocks = 40;
		num_object_per_block = [3,4,5];

		num_pulse_per_block = [2,3,5];
		num_pulse_size = [250, 250, 250];

		proportions = [0.2, 0.4, 0.4];
		num_different_type_block = split_even_blocks(num_blocks, proportions, is_object_structure_reversing);

	case 3.3
		is_object_structure_reversing = true;
		isDistractor = true;

		is_equal_reward = true;
		using_gray_context = false;
		is_context_change = true;

		is_repeat= true;

		object_squence_type = '12';
		reward_structure_type = '0';

		% Important thing to change
		num_blocks = 16;
		num_object_per_block = [3,4,5];

		num_pulse_per_block = [4,6,8];
		num_pulse_size = [250, 250, 250];

		proportions = [0.4, 0.4, 0.2];
		num_different_type_block = split_even_blocks(num_blocks, proportions, is_object_structure_reversing);

		is_repetition_with_extra = true;
		num_blocks_repetition_with_extra = 4;

	otherwise
		disp('Manually Defined Difficulty Level')
		difficulty_level = 'Manual_';

		is_object_structure_reversing = true;
		isDistractor = true;

		is_equal_reward = true;
		using_gray_context = false;
		is_context_change = true;

		is_repeat= true;

		object_squence_type = '12';
		reward_structure_type = '0';

		% Important thing to change
		num_blocks = 10;
		num_object_per_block = [2,3,4];

		num_pulse_per_block = [2,3,5];
		num_pulse_size = [250, 250, 250];

		proportions = [0.6, 0.2, 0.2];
		num_different_type_block = split_even_blocks(num_blocks, proportions, is_object_structure_reversing);

		is_repetition_with_extra = true;
		num_blocks_repetition_with_extra = 4;

end
randomize_location = 'TRUE';
block_end_type = "SimpleThreshold";
block_end_window = 5;
block_end_threshold = 0.8;
leave_feedback_on = 'TRUE';
error_threshold = 3;
cfg.out_whatWhenWhere.print_repeat = is_repeat;

% % check if the folder exists, and if so, it will add a numbered suffix to the folder name.
% counter = 1;
% iBlockDefPathWithCounter = iBlockDefPath;
% while exist(iPath, 'dir') == 7
% 	iBlockDefPathWithCounter = [iBlockDefPath, '_', sprintf('%03d', counter)];
% 	iPath = [pwd '/' iBlockDefPathWithCounter '/'];
% 	counter = counter + 1;
% end
% iBlockDefPath = iBlockDefPathWithCounter;
% mkdir(iPath);


contextRepositoryFolderPath = cfg.contextNameFolder;
context_path = contextRepositoryFolderPath;% change this to above path for context

% set block object number
total_number_object_allblock = sum(num_object_per_block .* num_different_type_block);

% get pathes and context background
[contexts, pathes] = getContextBackground(using_gray_context, num_blocks, is_context_change, context_path);

if is_repeat
	[new_context, if_changed] = changeContext(contexts, is_context_change, context_path);
	final_context = combineContexts(contexts, new_context, if_changed);
end
% get object orders
[object_orders, samples, distractors_orders, distractors_samples] = getStimuliConfig(num_object_per_block, num_different_type_block, is_object_structure_reversing, iBlockDefPath, isDistractor);

% get slider gain and loss
slider_gains = getSliderGainLoss(num_object_per_block, num_different_type_block, is_object_structure_reversing, is_equal_reward);
slider_initial = 1;



%% Create Blocks
blocks = cell(num_blocks,1);
temp_index = 1;
for i = 1:length(num_different_type_block)
	for j = 1:num_different_type_block(i)

		context_background = contexts(temp_index);

		num_object = num_object_per_block(i);
		locXYZ = getlocationxyz(18, 6);% radius = 5, number of slot = 6, random every block so put it here

		object_search_stims_indices = object_orders{temp_index} - 1;
		slider_gain = slider_gains{temp_index};
		slider_loss = slider_gain;

		if num_object == 2 || num_object == 3 || num_object == 4 || num_object == 5
			n_repetitions_minmax = [30, 31];
		else
			n_repetitions_minmax = [40, 41];
		end

		num_pulses = num_pulse_per_block(i);
		pulse_size = num_pulse_size(i);

		str_id = sprintf('ID%03d_', temp_index);
		if is_object_structure_reversing
			if mod(temp_index, 2) == 0
				order_id = sprintf('Order%02d_', 1);
				context_id = sprintf('Context%02d_', 1);
			else
				order_id = sprintf('Order%02d_', 2);
				context_id = sprintf('Context%02d_', 2);
			end
		else
			order_id = sprintf('Order%02d_', 1);
			context_id = sprintf('Context%02d_', 1);
		end

		if ~isDistractor
			DistractorStimsIndices = '[]';
			DistractorStimsLocations = '[]';
			distractor_id = sprintf('Distractor%02d', 0);
		else
			DistractorStimsIndices = distractors_orders{temp_index} - 1;
			DistractorStimsLocations = '[]';
			distractor_id = sprintf('Distractor%02d', 1);
		end

		object_num_id =  sprintf('ObjectN%02d_', num_object);
		block_id =  [str_id order_id context_id object_num_id distractor_id];

		object_touch_order = 1:num_object;

		% If you want to specify values, please add below this line
		block = getsingleblock(block_id, num_object, context_background, object_touch_order, object_search_stims_indices, n_repetitions_minmax, randomize_location,locXYZ, slider_gain, ...
			slider_loss, slider_initial, num_pulses, pulse_size, block_end_type,block_end_window, block_end_threshold,DistractorStimsIndices, DistractorStimsLocations, leave_feedback_on, error_threshold);
		blocks{temp_index} = block;

        temp_index = temp_index + 1;
	end
end

%% Make BlockDef file

iFilename_BlockDef  = sprintf('WhatWhenWhere_BlockDeftdf_array');
subfolder_iPath = iPath;
if ~exist(subfolder_iPath), mkdir(subfolder_iPath), end
fid = fopen([subfolder_iPath iFilename_BlockDef '.txt'],'w');

% Write the header line
fprintf(fid, 'BlockName\tContextName\tCorrectObjectTouchOrder\tnRepetitionsMinMax\tSearchStimsIndices\tSearchStimsLocations\tSliderGain\tSliderLoss\tSliderInitial\tRandomizedLocations\tDistractorStimsIndices\tDistractorStimsLocations\tNumPulses\tPulseSize\tBlockEndType\tBlockEndWindow\tBlockEndThreshold\tLeaveFeedbackOn\tErrorThreshold\n');

num_blocks = numel(blocks);

% Initialize shuffled_indices to the indices of the blocks array
shuffled_indices = 1:num_blocks;

% Generate all possible groups of two from the remaining indices
remaining_indices = 5:num_blocks;
groups = reshape(remaining_indices(1:2*floor((num_blocks-4)/2)), 2, []);
num_groups = size(groups, 2);

% Shuffle the groups of two and append the first four indices
shuffled_groups = randperm(num_groups);
shuffled_indices(5:end) = reshape(groups(:, shuffled_groups), [], 1);

% PRINT
if is_repetition_with_extra
	writeBlocksDef(blocks, shuffled_indices(1:end-num_blocks_repetition_with_extra), fid);
else
	writeBlocksDef(blocks, shuffled_indices, fid);
end

if is_repeat
	repeated_blocks = blocks;
	% Create a copy of shuffled_indices for reshuffling
	reshuffled_indices = shuffled_indices;
	% Re-group the shuffled indices
	reshuffled_groups = reshape(reshuffled_indices(5:end), 2, []);
	% Shuffle the 2-group indices again
	num_reshuffled_groups = size(reshuffled_groups, 2);
	reshuffled_groups = reshuffled_groups(:, randperm(num_reshuffled_groups));
	% Flatten the reshuffled groups back to a single row vector
	reshuffled_indices(5:end) = reshape(reshuffled_groups, 1, []);

	for i = reshuffled_indices
		repeated_blocks{i}.ContextName{1} = final_context{i}{1};
	end
	% IF writen in same file
	% 	writeBlocksDef(repeated_blocks, reshuffled_indices, fid);

	cfg.out_whatWhenWhere.repeated_blocks = repeated_blocks;
	cfg.out_whatWhenWhere.reshuffled_indices = reshuffled_indices;
	cfg.out_whatWhenWhere.iPath = iPath;
end


% Close the file
fclose(fid);

%% Make Quaddle
export_png = 'True';
export_fbx = 'True';%'False';%'True';
blender_path = '/Applications/Blender.app/Contents/MacOS/Blender'; % Change this to your Blender path
% blender_path = '/Applications/Blender.app/Contents/MacOS/Blender'

blender_file_path = '/Users/wenxuan/Documents/Blender/makeQuaddle.blend';
% blender_file_path = '/Users/thiwom/Main/projects/201912_P_KioskFluBehavior/#ms_CognitiveGames_Kiosk/GAMES_MATLAB/blender-quaddle-main/makeQuaddle.blend',

python_script = '/Users/wenxuan/Documents/Blender/parser.py'; % Change this to your Python script path
% python_script = '/Users/thiwom/Main/projects/201912_P_KioskFluBehavior/#ms_CognitiveGames_Kiosk/GAMES_MATLAB/blender-quaddle-main/parser.py';

input_path = [pwd '/' iBlockDefPath '/StimuliConfig'];
output_path = [pwd '/' iBlockDefPath];
command = sprintf('"%s" --background "%s" --python "%s" -- --input_path "%s" --output_path "%s" --export_fbx "%s" --export_png "%s"', blender_path, blender_file_path, python_script, input_path, output_path, export_fbx, export_png);
system(command);

%keyboard

movefile([output_path '/' 'Stimuli'], [output_path '/' cfg.out_whatWhenWhere.experimentName '_Stimuli']);


%% Make StimDef file
% get the list of all fbx files in the folder, Order them by Config file
% order

config_path = fullfile([output_path '/' 'StimuliConfig']); % path to config files
stimuli_path = fullfile([output_path '/' cfg.out_whatWhenWhere.experimentName '_Stimuli']); % path to stimuli files
cfg.out_whatWhenWhere.previous_stimuli_path = stimuli_path;
cfg.out_whatWhenWhere.previous_stimuli_config_path = config_path;
iFilename_StimDef  = sprintf('WhatWhenWhere_StimDeftdf_array');
subfolder_iPath = iPath;

write_StimDef_WWW(config_path, stimuli_path, subfolder_iPath, iFilename_StimDef)

%% Make TaskDef file

iFilename_TaskDef  = sprintf('WhatWhenWhere_TaskDef_singletype');
subfolder_iPath = iPath;
write_TaskDef_WWW(subfolder_iPath, iFilename_TaskDef)


%% Make EventCode file
iFilename_EventCode =  sprintf('WhatWhenWhere_EventCodeConfig_json');
write_EventCode_WWW_01(subfolder_iPath, iFilename_EventCode);
iFilename_ConfigUIDetails =  sprintf('WhatWhenWhere_ConfigUiDetails_json');
write_ConfigUIDetails_WWW(subfolder_iPath, iFilename_ConfigUIDetails);

disp('done.'), return
end


%% Helper Functions

function write_TaskDef_WWW(subfolder_iPath, iFilename_TaskDef)
iTaskDef = {};
% iTaskDef{end+1} = 'string	ContextExternalFilePath	"C:\\Users\\WomLab_Unity\\OneDrive\\Desktop\\USE_Configs\\Resources\\TextureImages"';
iTaskDef{end+1} = 'string	ExternalStimFolderPath	"C:\\Users\\Womelsdorf Lab\\Desktop\\MUSE\\Resources\\Stimuli"';
iTaskDef{end+1} = 'float	ExternalStimScale	0.1';
iTaskDef{end+1} = 'List<string>	FeedbackControllers	["Audio", "Halo", "Slider"]';
iTaskDef{end+1} = 'bool	NeutralITI	false';
iTaskDef{end+1} = 'bool	StimFacingCamera	TRUE';
iTaskDef{end+1} = 'string	ShadowType	"None"';
iTaskDef{end+1} = 'Vector3	ButtonPosition	[0, 0, 0]';
iTaskDef{end+1} = 'float	StartButtonScale	1';

if ~exist(subfolder_iPath), mkdir(subfolder_iPath), end
fPtr = fopen([subfolder_iPath iFilename_TaskDef '.txt'],'w');
for iT = 1:length(iTaskDef)
	fprintf(fPtr, '%s', iTaskDef{iT});
	if iT ~= length(iTaskDef)
		fprintf(fPtr, '\n');
	end
end
fclose(fPtr);
end

function write_StimDef_WWW(config_path, stimuli_path,subfolder_iPath, iFilename_StimDef)

% Hard-coded abbreviations
abbreviations = struct('Body', 'BOD', 'BMain_Colour', 'BMC', 'BComp_Colour', 'BCC', ...
	'BPattern', 'BPT', 'Fractal', 'FRC', 'Head', 'HEA', 'HMain_Colour', 'HMC', ...
	'HComp_Colour', 'HCC', 'HPattern', 'HPT', 'Ear_Left_Type', 'ELT', ...
	'Ear_Right_Type', 'ERT', 'Ear_Left_Length', 'ELL', 'Ear_Right_Length', 'ERL', ...
	'Arm_Position', 'AP', 'Arm_Angle_Left', 'AAL', 'Arm_Angle_Right', 'AAR', 'Beak', 'BEK');

% Get all .txt files in the StimuliConfig folder
config_files = dir(fullfile(config_path, '*.txt'));

% Initialize a struct to store .fbx file names and indices
fbx_files = struct('name', {}, 'idx', {});

% Loop over all config files
for i = 1:length(config_files)
	% Open the file
	fid = fopen(fullfile(config_path, config_files(i).name));

	% Initialize name string for the .fbx file
	name = '';

	% Read the file line by line
	tline = fgets(fid);
	while ischar(tline)
		% Extract the numerical value
		num = sscanf(tline, '%*[^[][%d]');

		% Extract the dimension name
		dimension = regexp(tline, '^[^:\s]*', 'match', 'once');

		% Get the abbreviation for the dimension
		prefix = abbreviations.(dimension);

		% Append the abbreviation and numerical value to the name string
		name = [name, prefix, num2str(num), '_'];

		% Get the next line
		tline = fgets(fid);
	end

	% Close the file
	fclose(fid);

	% Remove trailing underscore and append .fbx extension
	name = [name(1:end-1), '.fbx'];

	% Check if the .fbx file exists in the Stimuli folder
	if ~isfile(fullfile(stimuli_path, name))
		error('File %s does not exist in the Stimuli folder.', name);
	end

	% Store the name and index in the struct
	fbx_files(i).name = name;
	fbx_files(i).idx = i-1;
end

if ~exist(subfolder_iPath), mkdir(subfolder_iPath), end
fid = fopen([subfolder_iPath iFilename_StimDef '.txt'],'w');

% write the header
fprintf(fid,'StimIndex\tFileName\tPrefabPath\n');

% loop through the .fbx files and write the information to the file
for i = 1:length(fbx_files)
	fprintf(fid,'%d\t%s\t""\n', fbx_files(i).idx, fbx_files(i).name);
end

% close the file
fclose(fid);

end

function new_string = formatString(old_string)
old_string = strrep(old_string, '[', '[[');
old_string = strrep(old_string, ']', ']]');
new_string = strrep(old_string, ';', '],[');
end

function new_string = formatString_addcomma(old_string)
new_string = strrep(old_string, ' ', ',');
end

function new_string = formatString_addSquarePara(old_string)
new_string = ['[' old_string ']'];
end


function num_different_type_block = split_even_blocks(num_blocks, proportions, is_object_structure_reversing)
% Ensure the sum of proportions is 1
if abs(sum(proportions) - 1) > 1e-9
	error("ERROR: Proportions must sum to 1")
end

num_parts = length(proportions);
num_different_type_block = zeros(1, num_parts);

% Calculate the number of blocks for each part and round to the nearest even number if necessary
for i = 1:num_parts
	num_blocks_part = round(num_blocks * proportions(i));

	% Ensure each part has an even number of blocks if is_object_structure_reversing is true
	if mod(num_blocks_part, 2) == 1 && is_object_structure_reversing == true
		num_blocks_part = num_blocks_part + 1;
	end

	num_different_type_block(i) = num_blocks_part;
end

% Adjust the last part if the sum of all parts is not equal to num_blocks
diff_blocks = num_blocks - sum(num_different_type_block);
if abs(diff_blocks) > 1
	error("ERROR: Unable to evenly distribute blocks")
elseif diff_blocks ~= 0
	num_different_type_block(end) = num_different_type_block(end) + diff_blocks;
end

% Error check for odd number of blocks if is_object_structure_reversing is true
if any(mod(num_different_type_block, 2) == 1) && is_object_structure_reversing == true
	error("ERROR: Odd number for reversing blocks")
end
end


function [iFilename, iPath] = write_EventCode_WWW_01(iPath, iFilename)

eventCodes = [];
eventCodes.SlotError.Value = 14164;
eventCodes.SlotError.Description = 'selected an object in the incorrect sequence';
eventCodes.RepetitionError.Value = 14165;
eventCodes.RepetitionError.Description = 'selected an object that has previously been selected within the trial';

eventCodesString=jsonencode(eventCodes,'PrettyPrint',true);
fPtr = fopen([iPath iFilename '.json'],'w');
fprintf(fPtr, '%s', eventCodesString);
fclose(fPtr);
fprintf('\n wrote %s \n', [ iFilename ]);
disp('done.'), return
end

function [iFilename, iPath] = write_ConfigUIDetails_WWW(iPath, iFilename, jsonData)
if nargin < 3
	jsonData = struct();

	% Create the variables structure
	varsNumber = struct();
	varsBoolean = struct();
	varsString = struct();

	% Add the variables to the structure
	varsNumber.selectObjectDuration.value = 10.0;
	varsNumber.selectObjectDuration.min = 1.0;
	varsNumber.selectObjectDuration.max = 20.0;
	varsNumber.selectObjectDuration.precision = 1;
	varsNumber.selectObjectDuration.isRange = true;
	varsNumber.selectObjectDuration.name = 'Select Object Duration';
	varsNumber.selectObjectDuration.hidden = false;

	varsNumber.minObjectTouchDuration.value = 0.1;
	varsNumber.minObjectTouchDuration.min = 0.01;
	varsNumber.minObjectTouchDuration.max = 5.0;
	varsNumber.minObjectTouchDuration.precision = 1;
	varsNumber.minObjectTouchDuration.isRange = true;
	varsNumber.minObjectTouchDuration.name = 'Min Object Touch Duration';
	varsNumber.minObjectTouchDuration.hidden = false;

	varsNumber.maxObjectTouchDuration.value = 2.0;
	varsNumber.maxObjectTouchDuration.min = 0.1;
	varsNumber.maxObjectTouchDuration.max = 5.0;
	varsNumber.maxObjectTouchDuration.precision = 1;
	varsNumber.maxObjectTouchDuration.isRange = true;
	varsNumber.maxObjectTouchDuration.name = 'Max Object Touch Duration';
	varsNumber.maxObjectTouchDuration.hidden = false;

	varsNumber.itiDuration.value = 0.5;
	varsNumber.itiDuration.min = 0.1;
	varsNumber.itiDuration.max = 10.0;
	varsNumber.itiDuration.precision = 1;
	varsNumber.itiDuration.isRange = true;
	varsNumber.itiDuration.name = 'Iti Duration';
	varsNumber.itiDuration.hidden = false;

	varsNumber.sliderSize.value = 15.0;
	varsNumber.sliderSize.min = 1.0;
	varsNumber.sliderSize.max = 100.0;
	varsNumber.sliderSize.precision = 1;
	varsNumber.sliderSize.isRange = true;
	varsNumber.sliderSize.name = 'Slider Size';
	varsNumber.sliderSize.hidden = false;

	varsNumber.fbDuration.value = 0.5;
	varsNumber.fbDuration.min = 0.1;
	varsNumber.fbDuration.max = 10.0;
	varsNumber.fbDuration.precision = 1;
	varsNumber.fbDuration.isRange = true;
	varsNumber.fbDuration.name = 'FB Duration';
	varsNumber.fbDuration.hidden = false;

	varsNumber.finalFbDuration.value = 0.5;
	varsNumber.finalFbDuration.min = 0.1;
	varsNumber.finalFbDuration.max = 20.0;
	varsNumber.finalFbDuration.precision = 1;
	varsNumber.finalFbDuration.isRange = true;
	varsNumber.finalFbDuration.name = 'Final FB Duration';
	varsNumber.finalFbDuration.hidden = false;

	varsNumber.chooseStimOnsetDelay.value = 0.01;
	varsNumber.chooseStimOnsetDelay.min = 0.01;
	varsNumber.chooseStimOnsetDelay.max = 20.0;
	varsNumber.chooseStimOnsetDelay.precision = 1;
	varsNumber.chooseStimOnsetDelay.isRange = true;
	varsNumber.chooseStimOnsetDelay.name = 'Choose Stim Onset Delay';
	varsNumber.chooseStimOnsetDelay.hidden = false;

	varsNumber.timeoutDuration.value = 5;
	varsNumber.timeoutDuration.min = 0.1;
	varsNumber.timeoutDuration.max = 20.0;
	varsNumber.timeoutDuration.precision = 1;
	varsNumber.timeoutDuration.isRange = true;
	varsNumber.timeoutDuration.name = 'Timeout Duration';
	varsNumber.timeoutDuration.hidden = false;

	varsNumber.startButtonDelay.value = 0.01;
	varsNumber.startButtonDelay.min = 0.01;
	varsNumber.startButtonDelay.max = 20.0;
	varsNumber.startButtonDelay.precision = 1;
	varsNumber.startButtonDelay.isRange = true;
	varsNumber.startButtonDelay.name = 'Start Button Delay';
	varsNumber.startButtonDelay.hidden = false;

	varsNumber.gratingSquareDuration.value = 1;
	varsNumber.gratingSquareDuration.min = 0.1;
	varsNumber.gratingSquareDuration.max = 20.0;
	varsNumber.gratingSquareDuration.precision = 1;
	varsNumber.gratingSquareDuration.isRange = true;
	varsNumber.gratingSquareDuration.name = 'Grating Square Duration';
	varsNumber.gratingSquareDuration.hidden = false;

	% Add the variables structure to the JSON data
	jsonData.varsNumber = varsNumber;
	jsonData.varsBoolean = varsBoolean;
	jsonData.varsString = varsString;

	% Write the JSON data to file
	configUIstring=jsonencode(jsonData,'PrettyPrint',true);
else
	configUIstring=jsonencode(jsonData,'PrettyPrint',true);
end
try
	fPtr = fopen([iPath iFilename '.json'],'w');
	fprintf(fPtr, '%s', configUIstring);
	fclose(fPtr);
	fprintf('\n wrote %s \n',  iFilename );
catch ME
	if fileID > 0
		fclose(fileID);
	end
	error(['Failed to write to file: ' ME.message]);
end

end

function [contexts, pathes] = getContextBackground(using_gray, num_blocks, context_reversing, main_path)
if(context_reversing == true && mod(num_blocks, 2) ~= 0)
	error("Number of blocks cannot be odd")
end

if using_gray
	error("Don't use gray color if it is not stored in path");
	path_1 = [main_path '/Gray'];
	if context_reversing
		temp = ["Gray_1", "Gray_2"];
		contexts = repelem(temp, num_blocks/2);
		pathes = repelem(path_1, num_blocks);
	else
		temp = "Gray_1";
		contexts = repelem(temp, num_blocks);
		pathes = repelem(path_1, num_blocks);
	end
else
	[contexts, pathes] = randomPickElement(num_blocks, context_reversing, main_path);
end
end

function [elements, path] = randomPickElement(num_element, context_reversing, main_path)
path_1 = [main_path '/Rock_filtered'];
list_1 = dir(path_1);
path_2 = [main_path '/Sand_filtered'];
list_2 = dir(path_2);

if context_reversing
	index_1 = randsample(1:length(list_1), num_element/2);
	index_2 = randsample(1:length(list_2), num_element/2);
	elements = cell(1, num_element);
	path = cell(1, num_element);
	for i = 1:num_element
		if mod(i, 2) == 1
			filename = list_1(index_1((i+1)/2)).name;  % Get the filename
			[~, name, ~] = fileparts(filename);  % Split the filename into parts, Store the name without the extension
			elements{i} = string(name);
			path{i} = string(list_1(index_1((i+1)/2)).folder);
		else
			filename = list_2(index_2(i/2)).name;
			[~, name, ~] = fileparts(filename);
			elements{i} = string(name);
			path{i} = string(list_2(index_2(i/2)).folder);
		end
	end
else
	index_1 = randsample(1:length(list_1), num_element);
	elements = cell(1, num_element);
	path = cell(1, num_element);
	for i = 1:num_element
		filename = list_1(index_1(i)).name;  % Get the filename
		[~, name, ~] = fileparts(filename);  % Split the filename into parts, Store the name without the extension
		elements{i} = string(name);
		path{i} = string(list_1(index_1(i)).folder);
	end
end

end

function [new_context, if_changed] = changeContext(context, context_reversing, main_path)
% Initialize new_context and if_changed
new_context = context;
if_changed = false(1, length(context));

if context_reversing
	% Calculate the number of elements to change
	num_change = floor(length(context) / 2);

	% Randomly select indices of elements to change
	change_indices = randsample(1:length(context), num_change);

	% Replace the selected elements with new ones from the same category
	for i = 1:num_change
		index = change_indices(i);
		if mod(index, 2) == 1  % If index is odd, select from Rock category
			path = [main_path '/Rock_filtered'];
		else  % If index is even, select from Sand category
			path = [main_path '/Sand_filtered'];
		end
		new_context{index} = randomPickFromCategory(1, path);  % Pick a new context from the same category
		if_changed(index) = true;
	end
end
end

function [element, path] = randomPickFromCategory(num_element, path)
% This is a simplified version of your original randomPickElement function
% that always picks elements from a single path and does not support
% context_reversing.
list = dir([path '/*.png']);
index = randsample(1:length(list), num_element);
filename = list(index).name;  % Get the filename
[~, name, ~] = fileparts(filename);  % Split the filename into parts, Store the name without the extension
element = string(name);
path = string(list(index).folder);
end

function final_context = combineContexts(context, new_context, if_changed)
% Initialize final_context to the original context
final_context = context;

% Replace the elements in final_context with the corresponding elements
% in new_context if they were changed
for i = 1:length(if_changed)
	if if_changed(i)
		final_context{i} = new_context{i};
	end
end
end


function locXYZ = getlocationxyz(r, number_objects)
orientation_step = 0:2*pi/number_objects:2*pi-0.001;
% give random factor which rotate the objects
random_factor = rand() * (2*pi/number_objects);

if abs(random_factor - 2*pi/number_objects) < 1e-3
	random_factor = random_factor - 1e-3; % adjust the random factor to avoid 1 (rotate to original position cause issue)
end

orientation_step = orientation_step + random_factor;
radius = zeros(1,length(orientation_step)) + r;
z = zeros(1,length(orientation_step));
[x,y] = pol2cart(orientation_step,radius);
locXYZ = [x; y; z]';
end

function block = getsingleblock(block_id, num_object, context, object_touch_order, object_search_stims_indices, n_repetitions_minmax, randomize_location, locXYZ, slider_gain, ...
	slider_loss, slider_initial, num_pulses, pulse_size, block_end_type,block_end_window, block_end_threshold, DistractorStimsIndices,DistractorStimsLocations, leave_feedback_on, error_threshold)

% set default values
if ~exist('num_object','var'), num_object = 3; end
if ~exist('randomize_location','var'), randomize_location = 'true'; end


block = [];

block.TrialID = block_id;
block.nObj = num_object;
block.CorrectObjectTouchOrder = object_touch_order;
block.SearchStimsIndices = object_search_stims_indices;
block.ContextName  = context;
block.nRepetitionsMinMax = n_repetitions_minmax;
block.SearchStimsLocations = locXYZ;
block.randomizeLocations = randomize_location;
block.SliderGain = slider_gain;
block.SliderLoss = slider_loss;
block.SliderInitial = slider_initial;
block.NumPulses = num_pulses;
block.PulseSize = pulse_size;
block.BlockEndType = block_end_type;
block.BlockEndWindow = block_end_window;
block.BlockEndThreshold = block_end_threshold;
block.DistractorStimsIndices = DistractorStimsIndices;
block.DistractorStimsLocations = DistractorStimsLocations;
block.LeaveFeedbackOn = leave_feedback_on;
block.ErrorThreshold = error_threshold;
end


function slider_gains = getSliderGainLoss(num_object_per_block, num_different_type_block, is_reverse, is_equal_reward)
num_blocks = sum(num_different_type_block);
slider_gains = cell(num_blocks,1);

block_num_index = 1;
for i = 1:length(num_different_type_block)

	if is_equal_reward == true
		% make pseudo-slider gain and loss
		slider_gain_1 = ones(1, num_object_per_block(i)) * 2;
		slider_gain_2 = slider_gain_1;
	else
		% make real slider gain and loss
		% probably don't need
		switch num_object_per_block(i)
			case 2
				slider_gain_1 = [1,2];
				slider_gain_2 = [2,1];
			case 3
				slider_gain_1 = [2,5,1];
				slider_gain_2 = [2,1,1];
			case 4
				slider_gain_1 = [2,1,5,2];
				slider_gain_2 = [2,5,1,2];
			case 5
				slider_gain_1 = [2,5,2,1,2];
				slider_gain_2 = [2,1,2,5,2];
			case 6
				slider_gain_1 = [2,5,2,2,1,2];
				slider_gain_2 = [2,1,2,3,5,2];
			otherwise
				error("Error: not supported number of stimuli");
		end
	end

	temp_index = block_num_index;
	while temp_index < num_different_type_block(i) + block_num_index
		if is_reverse
			slider_gains{temp_index} = slider_gain_1;
			slider_gains{temp_index+1} = slider_gain_2;
			temp_index = temp_index + 2;
		else
			slider_gains{temp_index} = slider_gain_1;
			temp_index = temp_index + 1;
		end
	end
	block_num_index = temp_index;

end
end

function [object_orders, samples, distractors_order, distractors_sample] = getStimuliConfig(num_object_per_block, num_different_type_block, is_reversing, iBlockDefPath, isDistractor)
% This function is used to calculate the order of stimuli to be shown to the user
% The inputs are:
% - num_object_per_block: a vector with the number of objects in each block
% - num_different_type_block: a vector with the number of different types of blocks
% - is_reversing: a boolean variable indicating if the order should be reversed
%
% The output is:
% - object_orders: a cell array with the order of stimuli

total_number_object_allblock = sum(num_object_per_block .* num_different_type_block);

if is_reversing == true
	total_number_object_allblock = round(total_number_object_allblock/2);
end

object_list = 1:total_number_object_allblock;
object_orders = cell(sum(num_different_type_block),1);
distractors_order = cell(sum(num_different_type_block),1);

if is_reversing == true
	k = 1;
	distractor_index = 1;
	last_on_list = 0;
	for i = 1:length(num_different_type_block)
		for j = 1:num_different_type_block(i)/2
			object_orders{k} = object_list( (j-1)*num_object_per_block(i)+1 + last_on_list:(j)*num_object_per_block(i) + last_on_list);
			object_orders{k+1} = reverseObjectOrder(object_list( (j-1)*num_object_per_block(i)+1 + last_on_list:(j)*num_object_per_block(i) + last_on_list));

			distractors_order{k} = distractor_index + total_number_object_allblock;
			distractors_order{k+1} = distractor_index + total_number_object_allblock;
			distractor_index = distractor_index+1;
			k = k+2;
		end
		last_on_list = (j) * num_object_per_block(i) + last_on_list;
	end

else
	k = 1;
	distractor_index = 1;
	last_on_list = 0;
	for i = 1:length(num_different_type_block)
		for j = 1:num_different_type_block(i)
			object_orders{k} = object_list( ((j-1) * num_object_per_block(i) +1) + last_on_list: ((j) * num_object_per_block(i)) + last_on_list);
			distractors_order{k} = distractor_index + total_number_object_allblock;
			distractor_index = distractor_index+1;
			k = k+1;
		end
		last_on_list = (j) * num_object_per_block(i) + last_on_list;
	end

end
[samples, distractors_sample]  = generateObjectTables(num_object_per_block,num_different_type_block, is_reversing, iBlockDefPath, isDistractor);

end
function new_order = reverseObjectOrder(old_order)
new_order = old_order;
switch length(old_order)
	case 2
		new_order([1, 2]) = new_order([2, 1]);
	case 3
		new_order([2, 3]) = new_order([3, 2]);
	case 4
		new_order([2, 4]) = new_order([4, 2]);
	case 5
		new_order([2, 4]) = new_order([4, 2]);
	case 6
		new_order([2, 5]) = new_order([5, 2]);
	case 7
		new_order([3, 6]) = new_order([6, 3]);
	otherwise
		error("Impossible Number of Objects")
end
end

function writeBlocksDef(blocks, shuffled_indices, fid)
% Loop through each of the cells in the "blocks" array
for i = shuffled_indices
	fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', ...
		blocks{i}.TrialID,...
		blocks{i}.ContextName{1},...
		formatString_addcomma(mat2str(blocks{i}.CorrectObjectTouchOrder)),...
		formatString_addcomma(mat2str(blocks{i}.nRepetitionsMinMax)),...
		formatString_addcomma(mat2str(blocks{i}.SearchStimsIndices)),...
		formatString(formatString_addcomma(mat2str(round(blocks{i}.SearchStimsLocations, 3), 3))), ...
		formatString_addcomma(mat2str(blocks{i}.SliderGain)), ...
		formatString_addcomma(mat2str(blocks{i}.SliderLoss)), ...
		mat2str(blocks{i}.SliderInitial), ...
		blocks{i}.randomizeLocations, ...
		formatString_addSquarePara(mat2str(blocks{i}.DistractorStimsIndices)),...
		formatString_addcomma(blocks{i}.DistractorStimsLocations),...
		mat2str(blocks{i}.NumPulses),...
		mat2str(blocks{i}.PulseSize),...
		blocks{i}.BlockEndType,...
		mat2str(blocks{i}.BlockEndWindow),...
		mat2str(blocks{i}.BlockEndThreshold), ...
		blocks{i}.LeaveFeedbackOn, ...
		mat2str(blocks{i}.ErrorThreshold) ...
		);
end
end
function [combined_samples, distractors] = generateObjectTables(num_object_per_block,num_different_type_block, is_reversing, iBlockDefPath, isDistractor)

total_number_object_allblock = sum(num_object_per_block .* num_different_type_block);
regular_quaddle_num_needed = total_number_object_allblock;
distractors_num = sum(num_different_type_block);

if is_reversing == true
	regular_quaddle_num_needed = round(regular_quaddle_num_needed/2);
	distractors_num = round(distractors_num/2);
end

combined_samples = [];
distractors = [];
for i = 1:(length(num_different_type_block))
	if is_reversing == true
		num_different_type_block(i) = round(num_different_type_block(i)/2);
	end

	for j = 1:num_different_type_block(i)

		% generate regular quaddles
		samples = generateSample(num_object_per_block(i));
		similarity_threshold = 8;
		filtered_samples = filter_similar_samples(samples, similarity_threshold);
		combined_samples = [combined_samples; filtered_samples];
		similarity_matrix = calculate_similarity_matrix(filtered_samples);
		avg_similarity_score = mean(similarity_matrix(logical(eye(size(similarity_matrix)) == 0)));
		disp("The average similarity score is: " + num2str(avg_similarity_score));

		if isDistractor
			% generate distractors
			distractor = generateDistractor(filtered_samples(2, :));
			distractors = [distractors; distractor];
		end
	end
end


%% write congif file
%Define number of config files
stim_iPath = [pwd '/' iBlockDefPath '/StimuliConfig/' ];

for i = 1:regular_quaddle_num_needed
	% Define your list of numbers
	my_list = combined_samples(i,:);

	iFilename_TaskDef  = ['Object Table_' num2str(i, '%03d')];
	if ~exist(stim_iPath), mkdir(stim_iPath), end
	% Open a text file for writing
	fid = fopen([stim_iPath iFilename_TaskDef '.txt'],'w');

	% Write the text to the file
	fprintf(fid, 'Body:\t[%d]\n', my_list(1));
	fprintf(fid, 'BMain_Colour:\t[%d]\n', my_list(2));
	fprintf(fid, 'BComp_Colour:\t[%d]\n', my_list(3));
	fprintf(fid, 'BPattern:\t[%d]\n', my_list(4));
	fprintf(fid, 'Fractal:\t[%d]\n', my_list(5));
	fprintf(fid, 'Head:\t[%d]\n', my_list(6));
	fprintf(fid, 'HMain_Colour:\t[%d]\n', my_list(7));
	fprintf(fid, 'HComp_Colour:\t[%d]\n', my_list(8));
	fprintf(fid, 'HPattern:\t[%d]\n', my_list(9));
	fprintf(fid, 'Ear_Left_Type:\t[%d]\n', my_list(10));
	fprintf(fid, 'Ear_Right_Type:\t[%d]\n', my_list(11));
	fprintf(fid, 'Ear_Left_Length:\t[%d]\n', my_list(12));
	fprintf(fid, 'Ear_Right_Length:\t[%d]\n', my_list(13));
	fprintf(fid, 'Arm_Position:\t[%d]\n', my_list(14));
	fprintf(fid, 'Arm_Angle_Left:\t[%d]\n', my_list(15));
	fprintf(fid, 'Arm_Angle_Right:\t[%d]\n', my_list(16));
	fprintf(fid, 'Beak:\t[%d]\n', my_list(17));
	fclose(fid);
end

if ~isempty(distractors)
	for i = 1:distractors_num
		% Define your list of numbers
		my_list = distractors(i,:);

		iFilename_TaskDef  = ['Object Table_' num2str(i + regular_quaddle_num_needed, '%03d')];
		if ~exist(stim_iPath), mkdir(stim_iPath), end
		% Open a text file for writing
		fid = fopen([stim_iPath iFilename_TaskDef '.txt'],'w');

		% Write the text to the file
		fprintf(fid, 'Body:\t[%d]\n', my_list(1));
		fprintf(fid, 'BMain_Colour:\t[%d]\n', my_list(2));
		fprintf(fid, 'BComp_Colour:\t[%d]\n', my_list(3));
		fprintf(fid, 'BPattern:\t[%d]\n', my_list(4));
		fprintf(fid, 'Fractal:\t[%d]\n', my_list(5));
		fprintf(fid, 'Head:\t[%d]\n', my_list(6));
		fprintf(fid, 'HMain_Colour:\t[%d]\n', my_list(7));
		fprintf(fid, 'HComp_Colour:\t[%d]\n', my_list(8));
		fprintf(fid, 'HPattern:\t[%d]\n', my_list(9));
		fprintf(fid, 'Ear_Left_Type:\t[%d]\n', my_list(10));
		fprintf(fid, 'Ear_Right_Type:\t[%d]\n', my_list(11));
		fprintf(fid, 'Ear_Left_Length:\t[%d]\n', my_list(12));
		fprintf(fid, 'Ear_Right_Length:\t[%d]\n', my_list(13));
		fprintf(fid, 'Arm_Position:\t[%d]\n', my_list(14));
		fprintf(fid, 'Arm_Angle_Left:\t[%d]\n', my_list(15));
		fprintf(fid, 'Arm_Angle_Right:\t[%d]\n', my_list(16));
		fprintf(fid, 'Beak:\t[%d]\n', my_list(17));
		fclose(fid);
	end
end

end

function samples = generateSample(num_needed)

dimension_name = {
	'Body';
	'BMain_Colour';
	'BComp_Colour';
	'BPattern';
	'Fractal';
	'Head';
	'HMain_Colour';
	'HComp_Colour';
	'HPattern';
	'Ear_Left_Type';
	'Ear_Right_Type';
	'Ear_Left_Length';
	'Ear_Right_Length';
	'Arm_Position';
	'Arm_Angle_Left';
	'Arm_Angle_Right';
	'Beak'
	};
dimension_value = dictionary( ...
	'Body', 7, ...
	'BMain_Colour', 11, ...
	'BComp_Colour', 11, ...
	'BPattern', 4, ...
	'Fractal', 94, ...
	'Head', 3, ...
	'HMain_Colour', 11, ...
	'HComp_Colour', 11, ...
	'HPattern', 4, ...
	'Ear_Left_Type', 3,...
	'Ear_Right_Type', 3,...
	'Ear_Left_Length', 2,...
	'Ear_Right_Length', 2,...
	'Arm_Position', 3, ...
	'Arm_Angle_Left', 2, ...
	'Arm_Angle_Right', 2, ...
	'Beak', 1);
available_dimensions = {
	'Body';
	'BMain_Colour';
	'BComp_Colour';
	'BPattern';
	'Fractal';
	'Head';
	'HMain_Colour';
	'HComp_Colour';
	'HPattern';
	'Ear_Left_Type';
	'Ear_Right_Type';
	'Ear_Left_Length';
	'Ear_Right_Length';
	'Arm_Position';
	'Arm_Angle_Left';
	'Arm_Angle_Right';
	'Beak'
	};

samples = cell(numel(dimension_name),1);
% Loop over each dimension
for i = 1:numel(dimension_name)
	% Set the number of samples to take from each dimension
	num_samples = dimension_value(dimension_name(i));

	% Randomly sample numbers: if it is in an avaliable dimension, then
	% randomly sample one of it
	if ismember(dimension_name(i), available_dimensions)
		samples{i} = randsample(0:num_samples, num_needed, true);
	else
		samples{i} = zeros(num_needed,1);
	end
end
samples = cell2mat(samples);
samples = samples';
for i = 1:length(samples(:,1))
	samples(i,:) = modify_list(samples(i,:));
end
end

function mimic_sample = generateDistractor(original_sample)
dimension_value = dictionary( ...
	'Body', 7, ...
	'BMain_Colour', 11, ...
	'BComp_Colour', 11, ...
	'BPattern', 4, ...
	'Fractal', 94, ...
	'Head', 3, ...
	'HMain_Colour', 11, ...
	'HComp_Colour', 11, ...
	'HPattern', 4, ...
	'Ear_Left_Type', 3,...
	'Ear_Right_Type', 3,...
	'Ear_Left_Length', 2,...
	'Ear_Right_Length', 2,...
	'Arm_Position', 3, ...
	'Arm_Angle_Left', 2, ...
	'Arm_Angle_Right', 2, ...
	'Beak', 1);
available_dimensions = {
	'BComp_Colour';
	'BPattern';
	'Fractal';
	'Head';
	'HComp_Colour';
	'HPattern';
	};

mimic_sample = original_sample;

% Randomly pick the first dimension
random_dimension1 = available_dimensions{randi(numel(available_dimensions))};

% Get the corresponding value for the first chosen dimension
corresponding_value1 = dimension_value(random_dimension1);

% Find the index of the first random_dimension1 in dimension_value
keys_cell = keys(dimension_value);
index1 = strcmp(random_dimension1, keys_cell);

% Generate a random value within the range of 1 to corresponding_value1
random_value1 = original_sample(1, index1);
while random_value1 == original_sample(1, index1)
	random_value1 = randi(corresponding_value1);
end

mimic_sample(1, index1) = random_value1;

% Randomly pick the second dimension
random_dimension2 = available_dimensions{randi(numel(available_dimensions))};

% Make sure the second dimension is different from the first one
while strcmp(random_dimension2, random_dimension1)
	random_dimension2 = available_dimensions{randi(numel(available_dimensions))};
end

% Get the corresponding value for the second chosen dimension
corresponding_value2 = dimension_value(random_dimension2);

% Find the index of the second random_dimension2 in dimension_value
index2 = strcmp(random_dimension2, keys_cell);

% Generate a random value within the range of 1 to corresponding_value2
random_value2 = original_sample(1, index2);
while random_value2 == original_sample(1, index2)
	random_value2 = randi(corresponding_value2);
end

mimic_sample(1, index2) = random_value2;


% Randomly pick the Third dimension
random_dimension3 = available_dimensions{randi(numel(available_dimensions))};

% Make sure the second dimension is different from the first one
while strcmp(random_dimension3, random_dimension1) || strcmp(random_dimension3, random_dimension2)
	random_dimension3 = available_dimensions{randi(numel(available_dimensions))};
end

% Get the corresponding value for the second chosen dimension
corresponding_value3 = dimension_value(random_dimension3);

% Find the index of the second random_dimension2 in dimension_value
index3 = strcmp(random_dimension3, keys_cell);

% Generate a random value within the range of 1 to corresponding_value2
random_value3 = original_sample(1, index3);
while random_value3 == original_sample(1, index3)
	random_value3 = randi(corresponding_value3);
end

mimic_sample(1, index3) = random_value3;

% 	mimic_sample = modify_list(mimic_sample);
end


function new_block = reverseObjectRewardStructure(old_block)
new_block = old_block;

new_slider_gain = old_block.SliderGain;
new_slider_loss = old_block.SliderLoss;

switch new_block.nObj
	case 2
		new_slider_gain([1, 2]) = new_slider_gain([2, 1]);
		new_slider_loss([1, 2]) = new_slider_loss([2, 1]);
	case 3
		new_slider_gain([2, 3]) = new_slider_gain([3, 2]);
		new_slider_loss([2, 3]) = new_slider_loss([3, 2]);
	case 4
		new_slider_gain([2, 4]) = new_slider_gain([4, 2]);
		new_slider_loss([2, 4]) = new_slider_loss([4, 2]);
	case 5
		new_slider_gain([2, 4]) = new_slider_gain([4, 2]);
		new_slider_loss([2, 4]) = new_slider_loss([4, 2]);
	case 6
		new_slider_gain([2, 5]) = new_slider_gain([5, 2]);
		new_slider_loss([2, 5]) = new_slider_loss([5, 2]);
	case 7
		new_slider_gain([3, 6]) = new_slider_gain([6, 3]);
		new_slider_loss([3, 6]) = new_slider_loss([6, 3]);
	otherwise
		error("Impossible Number of Objects")
end

new_block.SliderGain = new_slider_gain;
new_block.SliderLoss = new_slider_loss;
end

function modified_list = modify_list(input_list)
modified_list = input_list;
% NOTE: This version is based on assign a default gray color to patterns,
% remove first IF statement if you want multiple color combinations.

% Check Body Color and Pattern
if modified_list(4) ~= 0 % if pattern is not solid
	modified_list(3) = 0; % assign white to comp color
end
if modified_list(2) > modified_list(3) % main color > comp color for body
	temp = modified_list(2);
	modified_list(2) = modified_list(3);
	modified_list(3) = temp;
elseif modified_list(2) == modified_list(3) % main color = comp color for body
	modified_list(4) = 0; % change pattern to solid
end

% Check Head Color and Pattern
if modified_list(9) ~= 0 % if pattern is not solid
	modified_list(8) = 0; % assign white to comp color
end
if modified_list(7) > modified_list(8) % main color > comp color for head
	temp = modified_list(7);
	modified_list(7) = modified_list(8);
	modified_list(8) = temp;
elseif modified_list(7) == modified_list(8) % if main color = comp color for head
	modified_list(9) = 0; % change pattern to 0
end

% Check if BPattern is 0, if true, set BComp_Color to 0, two ifs must
% follow previous check
if modified_list(4) == 0
	modified_list(3) = 0;
end
% Check if HPattern is 0, if true, set HComp_Color to 0
if modified_list(9) == 0
	modified_list(8) = 0;
end

% Modify Ear and Arm
% Check if Ear_Left_Type is not 0, if true, set Ear_Left_Length to 0
if modified_list(10) == 0
	modified_list(12) = 0;
end

% Check if Ear_Right_Type is not 0, if true, set Ear_Right_Length to 0
if modified_list(11) == 0
	modified_list(13) = 0;
end

% Check arm position
if modified_list(14) == 0 % no arm
	modified_list(15) = 0; % set left arm angle to 0
	modified_list(16) = 0; % set right arm angle to 0
end

if modified_list(14) == 1 % left arm only
	modified_list(16) = 0; % set right arm angle to 0
end

if modified_list(14) == 2 % right arm only
	modified_list(15) = 0; % set left arm angle to 0
end
end
function score = calculate_similarity_two_list(list1, list2)
score = 0;
for i = 1:length(list1)
	if i == 10 || i == 11 || i == 12 || i == 13
		% Ear related dimensions, weight = 0.25
		weight = 0.25;
	elseif i == 14 || i == 15 || i == 16
		% Arm related dimensions, weight = 0.5
		weight = 0.5;
	elseif i == 17
		% Beak related dimension, weight = 0.25
		weight = 0.25;
	else
		% Other dimensions, weight = 1
		weight = 1;
	end
	if list1(i) == list2(i)
		score = score + weight;
	end
end
end

function similarity_matrix = calculate_similarity_matrix(input_matrix)
num_rows = size(input_matrix, 1);
similarity_matrix = zeros(num_rows, num_rows);

for i = 1:num_rows
	modified_list1 = modify_list(input_matrix(i,:));
	for j = i:num_rows
		modified_list2 = modify_list(input_matrix(j,:));
		similarity_score = calculate_similarity_two_list(modified_list1, modified_list2);
		similarity_matrix(i,j) = similarity_score;
		similarity_matrix(j,i) = similarity_score;
	end
end
end

function filtered_matrix = filter_similar_samples(input_matrix, threshold)

% Loop until max similarity score is below threshold or 100 iterations
for i = 1:500
	% Calculate similarity matrix
	similarity_matrix = calculate_similarity_matrix(input_matrix);

	% Find pairs of samples with similarity above threshold
	[row_idx, col_idx] = find(triu(similarity_matrix, 1) > threshold);

	if isempty(row_idx)
		% No similar samples found, return input matrix
		filtered_matrix = input_matrix;
		return
	else
		% Identify samples to remove
		remove_idx = unique([row_idx; col_idx]);

		% Remove samples from input matrix
		input_matrix = input_matrix(setdiff(1:size(input_matrix,1), remove_idx), :);

		% Generate new samples to maintain original number of rows
		new_samples = generateSample(size(remove_idx,1));
		input_matrix = [input_matrix; new_samples];
	end
end

% Loop did not converge, return error
error('Max similarity score still above threshold after 500 iterations');
end

function visualizeSimilarity(filtered_matrix)
similarity_matrix = calculate_similarity_matrix(filtered_matrix);
avg_similarity_score = mean(similarity_matrix(logical(eye(size(similarity_matrix)) == 0)));
highest_similarity_score = max(max(similarity_matrix(logical(eye(size(similarity_matrix)) == 0))));
figure();
h2 = imagesc(similarity_matrix);
colorbar;
title(['Similarity Score: ' 'Avg: ' num2str(avg_similarity_score) ', Max: ' num2str(highest_similarity_score)], 'FontSize', 14);
xlabel('Quaddle Number', 'FontSize', 14);
ylabel('Quaddle Number', 'FontSize', 14);
set(gca, 'FontSize', 14);
set(gca, 'XTick', 1:size(similarity_matrix,1), 'XTickLabel', 1:size(similarity_matrix,1));
set(gca, 'YTick', 1:size(similarity_matrix,1), 'YTickLabel', 1:size(similarity_matrix,1));
end