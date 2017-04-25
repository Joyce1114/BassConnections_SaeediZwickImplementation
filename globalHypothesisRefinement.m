 % globalHypothesisRefinement.m
load('finalworkspaceforalltime.mat')
% Modify the arguments of generateSegmentNew for your image name 
test1Segments = generateSegmentNew('sampleseg1.png', finaloutput);
test2Segments = generateSegmentNew('sampleseg2.png', finaloutput);
test3Segments = generateSegmentNew('sampleseg3.png', finaloutput);
test4Segments = generateSegmentNew('sampleseg4.png', finaloutput); 
test1Array = [test1Segments{:}];
test2Array = [test2Segments{:}];
test3Array = [test3Segments{:}];
test4Array = [test4Segments{:}];


picResults = {test1Array, test2Array, test3Array, test4Array}; 
bestHypoList = cell(1, length(picResults)); 
for i = 1:length(picResults)   
    cArray = picResults{i}; 
    tempList = cell(1, length(cArray)); 
    for j = 1:length(cArray)
        cBestHypothesis = cArray(j).bestHypothesis; 
        if(isempty(cBestHypothesis))
            % Pad with zeros if cell is empty 
            tempList(j) = {zeros(2,8)};
        else
            tempList(j) = {cBestHypothesis{1,1}{1}}; 
        end
    end
    bestHypoList{i} = tempList; 
    
end 
clear('picResults'); 
% Load image 
testImage = imread('sampleseg1.png');
testImage = rgb2gray(testImage); 
[height, width] = size(testImage);  
%% Create a list of coordinates 
[x,y] = meshgrid(1:height, 1:width); 
points = [x(:), y(:)]; 
xAll = points(:,1);
yAll = points(:,2); 
picMat = zeros(length(xAll),1); 
for i = 1:length(bestHypoList) 
    % This matrix contains 
    cHypoList = bestHypoList{i}; 
    cMat = zeros(length(xAll),length(cHypoList)); 
    for j = 1:length(cHypoList)
        cXCoords = cHypoList{j}(:,[1, 3, 5, 7]); 
        cYCoords = cHypoList{j}(:,[2, 4, 6, 8]);
        if(sum(cHypoList{j}) ~= 0)
            k = convhull(cXCoords, cYCoords);
            cXCoords = cXCoords(k); 
            cYCoords = cYCoords(k); 
            [in, ~] = inpolygon(xAll, yAll, cXCoords(:), cYCoords(:)); 
            cMat(:,j) = in; 
        else 
            cMat(:,j) = 0; 
        end      
    end 
    cMatSum = sum(cMat, 2); 
    picMat = picMat + cMatSum; 
end 
picMat = reshape(picMat, [height, width]); 
save('finalGlobalResult.mat','picMat'); 
 nOverlapHypo2 + nOverlapHypo3 + nOverlapHypo4;
