function TaskIconLocations_N = get_taskIconLocations_01(nTasks, nTaskPositions)

TaskIconLocations_N = {};

if isempty(nTasks)
    nTasks = 8;
end

if isempty(nTaskPositions)
    nTaskPositions = max([8 nTasks]);
end

tmp = [-360 -130 130 360 ];
allLocationPossibilities = [];
ic=0;
for j=1:length(tmp)
    for k=1:length(tmp)
        ic=ic+1;
        allLocationPossibilities(ic,1:2) = [ tmp(j) tmp(k) ];
    end
end

tmpA = randperm(size(allLocationPossibilities,1));
for j=1:nTasks
    TaskIconLocations_N{j} = [ allLocationPossibilities(tmpA(j),:) 0];
end







return,

if 0
    tmp = [130 360];
    allLocationPossibilities = {};
    allLocationPossibilities{end+1}  = [tmp(1) tmp(1);    -tmp(1)    tmp(1) ;    -tmp(1)   -tmp(1) ;   tmp(1)   -tmp(1) ; ...
        tmp(2) tmp(2);    -tmp(2)    tmp(2) ;    -tmp(2)   -tmp(2) ;   tmp(2)   -tmp(2) ]; % rotate by(30:30:90)
    [TH R]=cart2pol(allLocationPossibilities{end}(:,1),allLocationPossibilities{end}(:,2)); TH= TH - (30*180/pi); [cX,cY]=pol2cart(TH,R);
    allLocationPossibilities{end+1} = [cX  cY ];
    [TH R]=cart2pol(allLocationPossibilities{end}(:,1),allLocationPossibilities{end}(:,2)); 	TH= TH - (60*180/pi);[cX,cY]=pol2cart(TH,R);
    allLocationPossibilities{end+1} = [cX  cY ];
    [TH R]=cart2pol(allLocationPossibilities{end}(:,1),allLocationPossibilities{end}(:,2)); 	TH= TH - (90*180/pi);[cX,cY]=pol2cart(TH,R);
    allLocationPossibilities{end+1} = [cX  cY ];

    tmpAP = randperm(length(allLocationPossibilities));

    %sessionData(iSession).TaskIconLocations_N = [];
    % --- random eccentricity:
    tmp = randperm(length(allLocationPossibilities{tmpAP(1)}));
    for j=1:nTasks
        % --- random rotation:
        TaskIconLocations_N{j}      = [allLocationPossibilities{tmpAP(1)}(tmp(j),1:2) 0];
    end
end
