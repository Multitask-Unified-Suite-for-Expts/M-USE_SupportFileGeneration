classdef Coord
    % Organizes the path of the maze with x and y components
    properties
        x
        y
    end
    
    methods
        function thisCoord = Coord(x,y)
            thisCoord.x = x;
            thisCoord.y = y;
        end
        function chessNotation = getChessNotation(thisCoord)
            alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
            letter = alphabet(thisCoord.x);
            number = num2str(thisCoord.y);
            chessNotation = [letter,number];
        end
    end
end

