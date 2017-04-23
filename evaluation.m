% This script is used to evaluate the result which will plot the ROC curve.
% Authot: Yue(Joyce) Xi

%Initilize the workspace
clear;
% load the result mat file
input = load('finalGlobalResult.mat');
matrix = input.picMat;
newmatrix = matrix(:);
size1 = size(matrix,1);
size2 = size(matrix,2);
npixels = size1*size2;
%another = zeros(size1,size2);
% load the testlabels
input2 = load('Norfolk_01_buildingCell_evaluation.mat');
datafile = input2.building_cell;
testdata = logical(zeros(size1,size2));
for i = 1:length(datafile)-1
    shapeX = datafile{i+1,10};
    shapeY = datafile{i+1,11};
    counter = 0;
    numNan=numel(find(isnan(shapeX)));
    numpoints=length(shapeX)-numNan;
    newX=zeros(numpoints,1);
    newY=zeros(numpoints,1);
    for j = 1:length(shapeX)
        currx = shapeX(j);
        curry = shapeY(j);
        if ~isnan(currx)
            counter = counter + 1;
            newX(counter) = currx;
            newY(counter) = curry;
        end
    end
    BW = poly2mask(newX,newY,size1,size2);
    testdata = testdata | BW;
end
newtruelabels = testdata(:);
% convert a matrix to array

%reshape(matrix',npixels,1);
%reshape(truelabels',npixels,1);
% create a new object
a = Result2(newmatrix,newtruelabels);
% call the methods to calculate ROC curve and PR curve
a.calculateRoc();
a.calculatePR();
figure(1)
a.plotRoc();
figure(2)
a.plotPr();

 