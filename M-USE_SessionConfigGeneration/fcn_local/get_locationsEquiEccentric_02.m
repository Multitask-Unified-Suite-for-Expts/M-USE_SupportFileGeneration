function allLocationPossibilities = get_locationsEquiEccentric_01(iEcc)

%locXY = [];
allLocationPossibilities = {};
allLocationPossibilities{1}  = [iEcc iEcc;    -iEcc    iEcc;    -iEcc   -iEcc;   iEcc   -iEcc]; % rotate by(30:30:90)
[TH R]=cart2pol(allLocationPossibilities{1}(:,1),allLocationPossibilities{1}(:,2)); TH= TH - (30*180/pi); [cX,cY]=pol2cart(TH,R);
allLocationPossibilities{2} = [cX  cY];
[TH R]=cart2pol(allLocationPossibilities{1}(:,1),allLocationPossibilities{1}(:,2)); 	TH= TH - (60*180/pi);[cX,cY]=pol2cart(TH,R);
allLocationPossibilities{3} = [cX  cY];
[TH R]=cart2pol(allLocationPossibilities{1}(:,1),allLocationPossibilities{1}(:,2)); 	TH= TH - (90*180/pi);[cX,cY]=pol2cart(TH,R);
allLocationPossibilities{4} = [cX  cY];
%locXY = cat(1,allLocationPossibilities{1},allLocationPossibilities{2},allLocationPossibilities{3},allLocationPossibilities{4});
%allLocationPossibilities;