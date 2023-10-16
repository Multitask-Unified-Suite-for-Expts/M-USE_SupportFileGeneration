
%function find_all_maze_paths_logical_v6(dim, max_mazes, max_length, max_turns, maze_output_file, mazedef_output_file)
function [all_paths, all_paths_info] = find_all_maze_paths_logical_v6(dim, max_length, max_turns)
global display_interval file_count;


grid_dims = {[dim dim]};
border_coords = find_borders(grid_dims);
all_possible_mazes = {};

% Generate start and end coordinate arrays
start_end_table = find_start_end(border_coords);
for start_end_index = 1:height(start_end_table(:,1))
    data = [grid_dims,start_end_table{start_end_index, 1},start_end_table{start_end_index, 2}];
    all_possible_mazes = [all_possible_mazes;data];
end
% 
% all_possible_mazes(:, 4) = cell(size(all_possible_mazes, 1), 1); % column for the previously visited positions
% all_possible_mazes(:, 5) = cell(size(all_possible_mazes, 1), 1); % column for the last path
% all_possible_mazes(:, 6) = cell(size(all_possible_mazes, 1), 1); % column for done searching
% 
% 
% for all_possible_mazes_index = 1:size(all_possible_mazes, 1)
%     all_possible_mazes{all_possible_mazes_index, 4} = false(dim,dim);
%     all_possible_mazes{all_possible_mazes_index, 5} = [all_possible_mazes{all_possible_mazes_index, 2}];
%     all_possible_mazes{all_possible_mazes_index, 6} = false;
% end


%Initialize a cell array to store the paths
all_paths = {};
all_paths_info = [];
% Start the timer
tic;
display_interval = 10000;
file_count = 1;

%max_total_mazes_generated = max_mazes * height(all_possible_mazes);
for all_possible_mazes_index = 1:size(all_possible_mazes)
    % Initialize a logical matrix to store visited coordinates
    visited = false(all_possible_mazes{all_possible_mazes_index}(1), all_possible_mazes{all_possible_mazes_index}(2));
    % Call the recursive function to find all paths
    num_mazes = 0;
    
    [all_paths, all_paths_info, num_mazes] = find_paths(all_possible_mazes(all_possible_mazes_index,1), all_possible_mazes(all_possible_mazes_index,3), visited, all_possible_mazes(all_possible_mazes_index,2), num_mazes, all_paths, all_paths_info, max_length, max_turns);
end

% Save left over mazes that weren't handled in the batch interval
if(height(all_paths) ~= 0)
     saved_mazes_file_name = sprintf('saved_mazes_%d.mat', file_count);
    saved_mazes_info_file_name = sprintf('saved_mazes_info_%d.mat', file_count);

    if (exist(saved_mazes_file_name, 'file') == 2)
        % Load the existing data from the .mat file into a different variable
        loaded_saved_mazes = load(saved_mazes_file_name, 'all_paths');
        loaded_saved_mazes_info = load(saved_mazes_info_file_name, 'all_paths_info');
        % Extract the existing all_paths variable from the loaded_data structure
        existing_all_paths = loaded_saved_mazes.all_paths;
        existing_all_paths_info = loaded_saved_mazes_info.all_paths_info;
        if (mod(numel(existing_all_paths),400000) == 0)
            file_count = file_count + 1;
            saved_mazes_file_name = sprintf('saved_mazes_%d.mat', file_count);
            saved_mazes_info_file_name = sprintf('saved_mazes_info_%d.mat', file_count);
        else
            % Append new data (in this case, also named all_paths) to the existing variable
            existing_all_paths = [existing_all_paths; all_paths];
            existing_all_paths_info = [existing_all_paths_info; all_paths_info];
            all_paths = existing_all_paths;
            all_paths_info = existing_all_paths_info;
        end
    end   
        % Save the modified variable back to the .mat file, overwriting the original variable
        save(saved_mazes_file_name, 'all_paths');
        save(saved_mazes_info_file_name, 'all_paths_info');
    all_paths = {};
    all_paths_info =[];
end
fprintf("100%% Done Loading All Mazes!\n\n");
fprintf("Running Classification Script!\n");
merge_and_classify_maze_library;
fprintf("100%% Done Processing All Mazes!!!!!!!\n\n");


end

function [all_paths,all_paths_info, num_mazes] = find_paths(grid_dims, end_coords, visited, path, num_mazes, all_paths, all_paths_info, max_length, max_turns)
global display_interval file_count;
% Mark the current position as visited
visited(path{end}(1), path{end}(2)) = true;
num_turns = get_num_turns(path);

if (size(path, 1) > max_length || num_turns >  max_turns)
    next_coords = [];
    return; % Skip paths that are longer than 25 squares or has more than 8 turns
end

%Check if the current position is the end position
if isequal(path(end), end_coords)
    next_coords = [];
    % Add the path, path length, and number of turns to the all_paths cell array
    maze_id = 0;
    num_mazes = num_mazes + 1;
    chessStartCoord = Coord(path{1}(1),path{1}(2)).getChessNotation();  % Gets chess notation for start coord
    chessEndCoord = Coord(path{end}(1), path{end}(2)).getChessNotation(); % Gets chess notation for end coord
    chessCoords = find_path_chess_coords(path);  % Gets chess notation for the entire path

    maze_name = sprintf("M%iX%i_T%i_L%i_%s_%s", grid_dims{1}(1), grid_dims{1}(2), num_turns, size(path,1), chessStartCoord, chessEndCoord);
    % if ~isempty(all_paths) % Trying to create unique id at the end for all mazes with same specs
    %     while (any(strcmp(maze_name, all_paths(:,7))))
    %         maze_id = maze_id +1;
    %         maze_name = sprintf("M%iX%i_T%i_L%i_%s_%s_%07i", grid_dims{1}(1), grid_dims{1}(2), num_turns, size(path,1), chessStartCoord, chessEndCoord, maze_id);
    %     end
    % end
    
    % Creates and appends the maze json file
    maze = MazeWriter("TRUE", maze_name, grid_dims, chessCoords, chessStartCoord, chessEndCoord, num_turns, height(chessCoords));
    mazeJson = write_json_maze(maze);
    all_paths_info = [all_paths_info; grid_dims{1}(1) grid_dims{1}(2) path{1}(1) path{1}(2) path{end}(1) path{end}(2) num_turns height(path)];
    all_paths = [all_paths;mazeJson];
    
   if (mod(numel(all_paths),display_interval) == 0) % appends the mazes in batches of size display_interval (10,000)
        elapsed_time = toc;
        tic;

        fprintf('Current number of paths: %d, Elapsed time: %.2f seconds\t Rate: %.2f\n', numel(all_paths), elapsed_time, numel(all_paths)/elapsed_time);
        saved_mazes_file_name = sprintf('saved_mazes_%d.mat', file_count);
        saved_mazes_info_file_name = sprintf('saved_mazes_info_%d.mat', file_count);

        if (exist(saved_mazes_file_name, 'file') == 2)
            % Load the existing data from the .mat file into a different variable
            loaded_saved_mazes = load(saved_mazes_file_name, 'all_paths');
            loaded_saved_mazes_info = load(saved_mazes_info_file_name, 'all_paths_info');
            % Extract the existing all_paths variable from the loaded_data structure
            existing_all_paths = loaded_saved_mazes.all_paths;
            existing_all_paths_info = loaded_saved_mazes_info.all_paths_info;
            if (mod(numel(existing_all_paths),400000) == 0)
                file_count = file_count + 1;
                saved_mazes_file_name = sprintf('saved_mazes_%d.mat', file_count);
                saved_mazes_info_file_name = sprintf('saved_mazes_info_%d.mat', file_count);
            else
                % Append new data (in this case, also named all_paths) to the existing variable
                existing_all_paths = [existing_all_paths; all_paths];
                existing_all_paths_info = [existing_all_paths_info; all_paths_info];
                all_paths = existing_all_paths;
                all_paths_info = existing_all_paths_info;
            end
        end   
            % Save the modified variable back to the .mat file, overwriting the original variable
            save(saved_mazes_file_name, 'all_paths');
            save(saved_mazes_info_file_name, 'all_paths_info');
        all_paths = {};
        all_paths_info =[];
    end
else % Continue searching if the end coord has not been reached 
    % Get the possible next coordinates
    next_coords = get_next_coords(grid_dims, path{end}, visited);
    % Iterate through the possible next coordinates
    for i = 1:size(next_coords, 1)
        %if num_mazes >= max_mazes 
            %return; % cuts off maze iteration after a certain number of mazes of that combo of start and end is found
        %end
        [all_paths, all_paths_info, num_mazes] = find_paths(grid_dims, end_coords, visited, [path; next_coords(i,:)], num_mazes, all_paths, all_paths_info, max_length, max_turns);
    end
end
end

function next_coords = get_next_coords(grid_dims, current_coords, visited)
% Initialize the next coordinates array
next_coords = [];
% Check the north coordinate
if current_coords(1) > 1 && ~visited(current_coords(1)-1, current_coords(2))
    next_coords = [next_coords; current_coords(1)-1, current_coords(2)];
end
% Check the south coordinate
if current_coords(1) < grid_dims{1}(1) && ~visited(current_coords(1)+1, current_coords(2))
    next_coords = [next_coords; current_coords(1)+1, current_coords(2)];
end
% Check the east coordinate
if current_coords(2) < grid_dims{1}(2) && ~visited(current_coords(1), current_coords(2)+1)
    next_coords = [next_coords; current_coords(1), current_coords(2)+1];
end
% Check the west coordinate
if current_coords(2) > 1 && ~visited(current_coords(1), current_coords(2)-1)
    next_coords = [next_coords; current_coords(1), current_coords(2)-1];
end
end

function num_turns = get_num_turns (path)
% Check if the next coordinate is a turn
turns = 0;
for j = 1:(size(path, 1)-2)
    if ~isequal(path{j+1} - path{j}, path{j+2} - path{j+1})
        turns = turns + 1;
    end
end
num_turns = turns;
end


function json = write_json_maze(maze)
% Write the json file that contains the individual maze details

s = struct('sideRestricted', maze.sideRestricted, 'mName', maze.mName, 'mDims', maze.mDims , 'mPath', maze.mPath,'mStart', maze.mStart, 'mFinish', maze.mFinish, ...
    "mNumTurns", maze.mNumTurns, "mNumSquares", maze.mNumSquares);
json = jsonencode(s);
end

function chessCoords = find_path_chess_coords(currPath)
% converts the points along the path to chess coordinates
    chessCoords = [];
    for j = 1:length(currPath)
        coords = Coord(currPath{j}(1), currPath{j}(2));
        chessCoord = coords.getChessNotation();
        chessCoords=[chessCoords; chessCoord];
    end
end

function dimensions = create_dimensions(x, y)
dimensions = {};
for j = x
    for i = y
        dimensions = [dimensions;{[j,i]}];
    end
end
end

function start_coord = find_start(dimensions)
start_coord = {};
for i = 1:(dimensions{1}(1)-1)
    start_coord = [start_coord;{[i,1]}];
end
end

function end_coord = find_end(dimensions)
end_coord = {};
for i = 1:(dimensions{1}(1)-1)
    end_coord = [end_coord;{[i,dimensions{1}(2)]}];
end
end

%% Finds start position and end position as any place along the border
function border_coords = find_borders(dimensions)
% Define the dimensions of the table
rows = dimensions{1}(2);
cols = dimensions{1}(1);

% Initialize an empty array to hold the border coordinates
border_coords = [];

% Traverse the top row from left to right
for col = 1:cols
    border_coords = [border_coords; 1 col];
end

% Traverse the right column from top to bottom (excluding the top-right corner)
for row = 2:rows
    border_coords = [border_coords; row cols];
end

% Traverse the bottom row from right to left (excluding the bottom-right corner)
for col = (cols-1):-1:1
    border_coords = [border_coords; rows col];
end

% Traverse the left column from bottom to top (excluding the top-left and bottom-left corners)
for row = (rows-1):-1:2
    border_coords = [border_coords; row 1];
end

end

function start_end_table = find_start_end(border_coords)
start_coords = border_coords; % Initialize start_coords as all border coordinates
end_coords = cell(size(border_coords, 1), 1); % Initialize end_coords as cell array
for i = 1:size(border_coords, 1)
    % Determine the indices of all other border coordinates except the current start position
    other_coords = 1:size(border_coords, 1);
    other_coords(i) = [];
    % Add the other border coordinates to the end_coords cell array
    end_coords{i} = border_coords(other_coords,:);
end

% Convert end_coords to a matrix with the same number of rows as start_coords
end_coords_mat = vertcat(end_coords{:});
end_coords_mat_rep = repmat(end_coords_mat, size(start_coords, 1), 1);

% Replicate start_coords for every row in end_coords_mat
start_coords_rep = repmat(start_coords, size(end_coords_mat, 1), 1);

% Combine start_coords and end_coords_mat into a table
start_end_table = table(start_coords_rep, end_coords_mat_rep);

% Remove duplicate rows from the table
start_end_table = unique(start_end_table);

% Sort the table by start_coords_rep
start_end_table = sortrows(start_end_table, 'start_coords_rep');
end
function flattened = flatten_cell_array(arr)
% Check if arr is a cell array
if iscell(arr)
    % If so, initialize flattened to an empty cell array
    flattened = {};
    % Loop through each element of arr
    for i = 1:numel(arr)
        % If the element is a cell array, recursively call flatten_cell_array
        if iscell(arr{i})
            flattened = [flattened; flatten_cell_array(arr{i})];
        % Otherwise, add the element to flattened
        else
            flattened = [flattened; arr(i)];
        end
    end
% If arr is not a cell array, return it as is
else
    flattened = arr;
end
end