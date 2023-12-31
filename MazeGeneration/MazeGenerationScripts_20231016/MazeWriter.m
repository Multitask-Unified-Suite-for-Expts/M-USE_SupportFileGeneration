classdef MazeWriter
    % Organizing the methods and functions involved in writing MazeDef and
    % Maze files
    properties
        sideRestricted
        mName
        mDims
        mPath
        mStart
        mFinish
        mNumSquares
        mNumTurns
    end

    methods
        function thisMazeWriter = MazeWriter(sideRestricted, mName, mDims, mPath, mStart, mFinish, mNumTurns, mNumSquares)
            thisMazeWriter.sideRestricted = sideRestricted;
            thisMazeWriter.mName = mName;
            thisMazeWriter.mDims = mDims;
            thisMazeWriter.mPath = mPath;
            thisMazeWriter.mStart = mStart;
            thisMazeWriter.mFinish = mFinish;
            thisMazeWriter.mNumTurns = mNumTurns;
            thisMazeWriter.mNumSquares = mNumSquares;
        end
        
    end
end