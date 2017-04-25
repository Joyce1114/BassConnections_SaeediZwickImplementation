# BassConnections_SaeediZwickImplementation
To apply the Bass Connections Energy Data Analytics Lab's rendition of the Saeedi algorithm, please follow the following instructions.  

1. Open demoFelzensawalbSegmentation.m, change the values of paramters you want. Make sure you've installed segmentFelzenszwalb.cpp and segmentFelzenszwalb.mexw64. This step will help you segment the images.

2. Open lsd_example.m file, change the picture you want to run on. Make sure you've installed lsd_image.mexw64 and lsd.mexw64. This step is used for extracting straight lines.

3. Open cellarrayoutput. Then change the input in line 1 to the desired file of 
lines that is output from the segmentation step (2). Then run cellarrayoutput.


4. Open Saeedi_EricJoyceCombined. Then, change the "input" variable as marked in line 14 to 
the desired file of lines that is the output from the segmentation step (1).
Tune the other paramters at the top of the page to taste. Then run 
Saeedi_EricJoyceCombined. The output is called finaloutput, and its structure
is described in detail in the comment at the end of Saeedi_EricJoyceCombined.


5. Run globalHypothesisRefinement.m. Modify the arguments for generateSegmentNew to match your imageNames. GlobalHypothesisRefinement.m outputs a file outputs a mat object that contains the matrix in which an entry represent the number of hypothesis containing that specific entry. 


6. Evaluation: open evaluation.m and change the input to your confidence map. This script will help you evalualte the result and plot the ROC curve and PR curve. Make sure you download the Result2.m. This class is used to help plot the curves.



