
function find_all_maze_paths_logical_v5(dim, max_mazes, max_length, max_turns, maze_output_file, mazedef_output_file)

%function all_paths = find_all_maze_paths_logical_v2(x_dim, y_dim, max_mazes, max_length, max_turns)
% Create all combinations of grid dimensions from the given ranges
%dimensions = create_dimensions(x_range, y_range);
all_possible_mazes = {};

fid_maze_def = fopen(mazedef_output_file, 'w');
fclose(fid_maze_def);

%grid_dims = [];
% for dimensions_index = 1:size(dimensions)
%     grid_dims = dimensions(dimensions_index);
grid_dims = [dim dim];
border_coords = find_borders(grid_dims);
all_possible_mazes = {};

% Generate start and end coordinate arrays
start_end_table = find_start_end(border_coords);
for start_end_index = 1:height(start_end_table(:,1));
    all_possible_mazes = [all_possible_mazes;[grid_dims,start_end_table{start_end_index, 1},start_end_table{start_end_index, 2}]];
end

all_possible_mazes(:, 4) = cell(size(all_possible_mazes, 1), 1); % column for the previously visited positions
all_possible_mazes(:, 5) = cell(size(all_possible_mazes, 1), 1); % column for the last path
all_possible_mazes(:, 6) = cell(size(all_possible_mazes, 1), 1); % column for done searching


for all_possible_mazes_index = 1:size(all_possible_mazes, 1)
    all_possible_mazes{all_possible_mazes_index, 4} = false(dim,dim);
    all_possible_mazes{all_possible_mazes_index, 5} = [all_possible_mazes{all_possible_mazes_index, 2}];
    all_possible_mazes{all_possible_mazes_index, 6} = false;
end


% Initialize a cell array to store the paths
transfer_data = {};
iLoop = 0;
move_to_next_pair = false;
% Initialize a logical matrix to store visited coordinates
while (any(cellfun(@(x) (x) ~= true, all_possible_mazes(:,6))) || iLoop == 0) % continue looping while any row in column 6 has a next_coords greater than 0
    for all_possible_mazes_index = 1:size(all_possible_mazes) % this loop goes through all combos of start/end
        % Call the recursive function to find all paths
        [path, visited, transfer_data, move_to_next_pair] = find_paths(all_possible_mazes(all_possible_mazes_index,1), all_possible_mazes(all_possible_mazes_index,3), all_possible_mazes{all_possible_mazes_index , 4}, all_possible_mazes(all_possible_mazes_index,5), max_length, max_turns, transfer_data, maze_output_file, mazedef_output_file,  max_mazes, move_to_next_pair);

        if (size(transfer_data, 1) ~= 0)
            write_maze_configs(transfer_data, maze_output_file, mazedef_output_file)
            transfer_data = {};
            % Store visited, path and next_coords so it can pick up where it left off next time
            all_possible_mazes{all_possible_mazes_index, 4} = visited;
            all_possible_mazes{all_possible_mazes_index, 5} = path;
        end
        if (~move_to_next_pair)
            % The recursion was completed and escaped without being forced
            % with move_to_next_pair, all possible paths between start/end
            % are exhausted
            all_possible_mazes{all_possible_mazes_index, 6} = true;
        end
        % Saves the all_possible_mazes file only after the data has been written
        save(maze_output_file + "//all_possible_mazes.mat", 'all_possible_mazes');
        move_to_next_pair = false;
    end
    iLoop = iLoop + 1;
end

if (size(transfer_data, 1) ~= 0) % final pass if there is any residual then write
    write_maze_configs(transfer_data, maze_output_file, mazedef_output_file)
end
fprintf("100%% Done Loading All Mazes!\n\n");
end

%%
function [path, visited, transfer_data, move_to_next_pair] = find_paths(grid_dims, end_coords, temp_visited, temp_path, max_length, max_turns, transfer_data, maze_output_file, mazedef_output_file, max_mazes, move_to_next_pair)
path = temp_path;
visited = temp_visited;

if (move_to_next_pair)
    return;
end
num_turns = get_num_turns(temp_path);
% Check if the current position is the end position
if (size(temp_path, 1) > max_length | num_turns >  max_turns)
    temp_next_coords = [];
    return; % Skip paths that are longer than 25 squares or has more than 8 turns
end
    temp_path = flatten_cell_array(temp_path);
    temp_visited(temp_path{end}(1), temp_path{end}(2)) = true;
if isequal(temp_path(end), end_coords)
    temp_next_coords = [];
    % Add the path, path length, and number of turns to the all_paths cell array
    maze_id = 0;
    chessStartCoord = Coord(temp_path{1}(1),temp_path{1}(2)).getChessNotation();  % Gets chess notation for start coord
    chessEndCoord = Coord(temp_path{end}(1), temp_path{end}(2)).getChessNotation(); % Gets chess notation for end coord
    maze_name = sprintf("M%iX%i_T%i_L%i_%s_%s", grid_dims{1}(1), grid_dims{1}(2), num_turns, size(temp_path,1), chessStartCoord, chessEndCoord);
    transfer_data = [transfer_data;{grid_dims{1}, chessStartCoord, chessEndCoord, temp_path, num_turns, size(temp_path,1), char(maze_name)}];
    if mod(size(transfer_data, 1), max_mazes) == 0
        % if the size of transfer data is less than max, it ran out on its
        % own, all possible next_coords/paths from start -> end are exhausted
        path = temp_path(1:end-1, :);
        visited = temp_visited;
        move_to_next_pair = true;
    end
else
    % Get the possible next coordinates
    temp_next_coords = get_next_coords(grid_dims, temp_path{end}, temp_visited);
    % Iterate through the possible next coordinates
    for i = 1:size(temp_next_coords, 1)
        [path, visited, transfer_data, move_to_next_pair] = find_paths(grid_dims, end_coords, temp_visited, [temp_path; temp_next_coords(i,:)], max_length, max_turns, transfer_data, maze_output_file, mazedef_output_file, max_mazes, move_to_next_pair);
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
rows = dimensions(2);
cols = dimensions(1);

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