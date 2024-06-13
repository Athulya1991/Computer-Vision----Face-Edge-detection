The aim of this visualisation is to detect the edge of face from a photo (jpeg image) using matlab. 


##Details of files used: 
Photo : An iamge of my face in jpeg format, Matlab files ; Main work file: Face Detection_Code.m , files for other functions to use within main file: initials_K.m, edge_neigh.m.
Initial method: Initially a direct approach to find edge using operators was done, which gave below output.

##Initial Method
Then k_means was attempted for segmentation but face didn’t single out well.The right shoulder part was too segmented along


##Detailed Method:
1. Segmentation using SVM: Since the edges were not detected well in the initial method and had a lot of noise, further moved on to segment the face using ML technique: SVM (CW_Athulya.m) The predicted face segments obtained by SVM method did single out the face well.
   
2. Edge detection of segmented image: Further, edges of the predicted segment were found using various operators. Also neighbourhood method was used) as one of the method, which was given as a function (edge_neigh.m) within the current one. All plots are combined and plotted together as subplots .The neighbourhood edge gave fine details of face too, other than the edge. However, out of all, Sobel and Roberts gave comparatively fair results. Sobel edge was found to be better with respect to the edge being fully detected though with a few noises .
   
3. Improving the chosen edge by eliminating noise : The sobel edge was chosen from above step; understanding the image profile, the noises especially on face and bit of hair included were removed by assigning the range of corresponding row, column values to 0

4. Adding colour to edge and sign using my initial “K” : As a final step, red colour is added to edge and the function initials_K is created to plot initial “K” and called to add “K” to the edge

##Output image 
![Detected Face edge] (https://github.com/Athulya1991/Computer-Vision----Face-Edge-detection/blob/main/Face%20Edge.png)

