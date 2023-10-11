function [trialDef] = get_WMBlock_01(cnd_delaySec,cnd_distractorSetSize, nTrials)
% cnd_delaySec = [];
% --- fcn get search block: 10 target failiarization trials, 100 3/6/9/12 distractor trials
% sampleTarget, testTarget, testDistractors

cnd_objDimensionality = [3];
cnd_TestTarget_Distr_Similarities = [0];
if isempty(cnd_delaySec), cnd_delaySec = [0.2 0.4 0.6]; end
if isempty(cnd_distractorSetSize),    cnd_distractorSetSize = [0 1 3]; end
if nargin <3 | isempty(nTrials), nTrials = 1000; end

WM = [];
WM.vector_sample = [];
WM.vector_test   = [];
WM.vector_distractors0FeatSimilar = [];
WM.vector_distractors1FeatSimilar = [];
WM.vector_distractors2FeatSimilar = [];

for iT=1:nTrials
    % --- which 3 feature dimenisons are used ?
    iDims = zeros(4,1); tmp = randperm(4); iDims(tmp(1:3)) = 1;
    % --- choose randomly features values for each dimenion
    featD1 = randperm(8);
    featD2 = randperm(8);
    featD3 = randperm(8);

    dimIdx = find(iDims);

    % --- determine target object
    sampleTarget = zeros(1,4);
    sampleTarget(dimIdx) = [featD1(1) featD2(1) featD3(1)];

    WM.vector_sample(iT,:) = sampleTarget;
    WM.vector_test(iT,:) = sampleTarget;

    % --- determine pool of distractor objects
    % --- sharing zero, one or two features with the target:
    testDistractors_ShareZero = zeros(3*3*3,4); iCnt0=0;
    testDistractors_ShareOne = zeros((3*3)+3,4); iCnt1=0;
    testDistractors_ShareTwo = zeros((3+3),4); iCnt2=0;
    for h=2:4
        for i=2:4
            for j=2:4

                iCnt0=iCnt0+1;
                % --- share zero features with target
                testDistractors_ShareZero(iCnt0,dimIdx) = [featD1(h) featD2(i) featD3(j)];

                % --- share one feature with target
                if h==2
                    iCnt1=iCnt1+1;
                    testDistractors_ShareOne(iCnt1,dimIdx) = [featD1(1) featD2(i) featD3(j)];
                end
                if i==2
                    iCnt1=iCnt1+1;
                    testDistractors_ShareOne(iCnt1,dimIdx) = [featD1(h) featD2(1) featD3(j)];
                end
                if j==2
                    iCnt1=iCnt1+1;
                    testDistractors_ShareOne(iCnt1,dimIdx) = [featD1(h) featD2(i) featD3(1)];
                end

                % --- share two feature with target
                if h==2 & i==2
                    iCnt2=iCnt2+1;
                    testDistractors_ShareTwo(iCnt2,dimIdx) = [featD1(1) featD2(1) featD3(j)];
                end
                if h==2 & j==2
                    iCnt2=iCnt2+1;
                    testDistractors_ShareTwo(iCnt2,dimIdx) = [featD1(1) featD2(i) featD3(1)];
                end
                if i==2 & j==2
                    iCnt2=iCnt2+1;
                    testDistractors_ShareTwo(iCnt2,dimIdx) = [featD1(h) featD2(1) featD3(1)];
                end

            end
        end
    end
    WM.vector_distractors0FeatSimilar{iT} = testDistractors_ShareZero;
    WM.vector_distractors1FeatSimilar{iT} = testDistractors_ShareOne;
    WM.vector_distractors2FeatSimilar{iT} = testDistractors_ShareTwo;
end

% --- --- --- --- --- --- --- --- 
% --- specify sets of eight positions at a given   
% --- eccentricity and at two types of possible rotations
% --- to have some spatial jitter across trials
% --- --- --- --- --- --- --- --- 
iEcc       = 6.0; %5.5;
cZ = [0.4];
allLocationPossibilities = {};
allLocationPossibilities{1}  = [iEcc cZ  iEcc;    -iEcc   cZ   iEcc;    -iEcc   cZ  -iEcc;   iEcc  cZ   -iEcc]; % rotate by(30:30:90)
[TH R]=cart2pol(allLocationPossibilities{1}(:,1),allLocationPossibilities{1}(:,3)); TH= TH - (45*180/pi); 
[cX,cY]=pol2cart(TH,R);
allLocationPossibilities{1} = cat(1,allLocationPossibilities{1} , [cX repmat(cZ,4,1) cY]);

% rotate the 8 positions slightly
[TH R]=cart2pol(allLocationPossibilities{1}(:,1),allLocationPossibilities{1}(:,3)); 	TH= TH - (22.5*180/pi);
[cX,cY]=pol2cart(TH,R);
allLocationPossibilities{2} = [cX repmat(cZ,length(cX),1) cY];

% --- randomly select one of these two sets of positions
idx_randRotation = randi(2,1);
xzlocs = allLocationPossibilities{idx_randRotation};

initialTokenConditions = [0 2 4] ;

trialDef = [];
trialDef.probe_objectVector = [];
trialDef.probe_objectXYZ = [];
trialDef.test_objectVector = [];
trialDef.test_objectXYZ = [];
trialDef.distrSetSize = [];
trialDef.delaySec = [];
trialDef.cndlabel = {};
trialDef.stimCode = {};

trialDef.objectVectorAll = [];
trialDef.probeobjectVectorAll  = [];
trialDef.testobjectVectorAll  = [];

% --- determine conditions for all WM trials
nTrials = length(WM.vector_sample );

trlPerSetSize = ceil(nTrials / length(cnd_distractorSetSize));
tmp = repmat(cnd_distractorSetSize,1,trlPerSetSize);
trialDef.distrSetSize = tmp(randperm(length(tmp)));

% low and high t-d similarity
trlTestTargSimilarity = ceil(nTrials / length(cnd_TestTarget_Distr_Similarities));
tmp = repmat([1 2],1,trlTestTargSimilarity);
trialDef.targDistrSimilarity = tmp(randperm(length(tmp)));

% delays... the first 25 trials with shortest delay
trlBlankDelay = ceil(nTrials / length(cnd_delaySec) );
tmp = repmat([cnd_delaySec],1,trlBlankDelay);
trialDef.trialsBlankDelay = tmp(randperm(length(tmp)));
%keyboard
% --- get probe, test and distractor objects selected
for iT=1:nTrials

    % how many distractors
    nDistractors = trialDef.distrSetSize(iT);
    iTDSIM = trialDef.targDistrSimilarity(iT);

    % determine which distractorobjects are used
    if iTDSIM == 1 %if dissimilar
        tmp0 = randperm(size(WM.vector_distractors0FeatSimilar{iT},1));
        iDistractorObjects = WM.vector_distractors0FeatSimilar{iT}(tmp0(1:nDistractors),:);
    elseif iTDSIM == 2
        tmp0 = randperm(size(WM.vector_distractors2FeatSimilar{iT},1));
        iDistractorObjects = WM.vector_distractors2FeatSimilar{iT}(tmp0(1:nDistractors),:);
    end
%keyboard
    % --- get rand locations for all
    tmp = randperm(size(xzlocs,1));
    iLocations =  xzlocs( tmp(1:nDistractors + 2) , :); % +2 for probe and test Target locations

    trialDef.probe_objectVector{iT} = WM.vector_sample(iT,:);
    trialDef.probe_objectXYZ(iT,:)  = xzlocs(tmp(1),:);
    trialDef.test_objectVector{iT}  = [ WM.vector_test(iT,:); iDistractorObjects];
    trialDef.test_objectXYZ{iT}    = xzlocs(tmp(2:size(iDistractorObjects,1)+2), :);
    trialDef.cndlabel{iT}          =  sprintf('WMn%d.TDSIM%d_delay%.1f',nDistractors,iTDSIM,trialDef.trialsBlankDelay(iT) );
    %trialDef.objectVector{iT}
    % for later tracking of oibject ID's
    trialDef.probeobjectVectorAll = cat(1,trialDef.probeobjectVectorAll, trialDef.probe_objectVector{iT} );
    trialDef.testobjectVectorAll = cat(1,trialDef.testobjectVectorAll,  trialDef.test_objectVector{iT} );
end


