function CW_Athulya()

%Load the image
im0 = imread('Athulya_pic.jpeg');

%Segmentation of face using SVM method
im1 = imresize(im0,0.25); % reducing the image resolution to fasten SVM process
[M, N, dim] = size(im1)   % M=482,N=368,dim=3
im =  rgb2hsv(im1);   %converting rgb to HSV colour space

figure(1),
subplot(3,4,1), imshow(im1), title('RGB');
subplot(3,4,2), imshow(im), title('HSV');

% Converting the image into a 2D table with each row element with RGB values
t =[reshape(im(:,:,1),1,[]);...
        reshape(im(:,:,2),1,[]); %...   
        reshape(im(:,:,3),1,[])];

[dim, no] = size(t)
X = t';
X(1:10,:)

Y = zeros(no,1); %Ground truth

for i=1:no
       if X(i, 1)<0.2  %red=0 ,so face would be say<0.2
           Y(i)=1;        % Ground truth =1,else 0
       else
           Y(i)=-1;
       end
end
%}
Y(1:10)
sz=[ size(Y)]
%Y=Y';

svm = fitcsvm(X,Y,'Standardize',true,'KernelFunction','rbf',...
                'KernelScale','auto');
sz = size(svm)
cv = crossval(svm)
loss = kfoldLoss(cv)
[~, score] = kfoldPredict(cv);
sz_score = size(score);
mean(score<0)
%predX = zeros(no,3);
predX = X;
predX = (score(:,2)>=0);
predX = predX .* X;

% reshape back to Original image resolution
im_pred(:,:,1) = reshape(predX(:,1),M,N);
im_pred(:,:,2) = reshape(predX(:,2),M,N);
im_pred(:,:,3) = reshape(predX(:,3),M,N);
rgb_im_pred = hsv2rgb(im_pred);
subplot(3,4,3), imshow(mat2gray(im_pred)), title('Predicted-HSV');
subplot(3,4,4), imshow(mat2gray(rgb_im_pred)), title('Predicted-RGB');


%Finding edges

%Converting rgb to gray for edge detection 
im_gray = rgb2gray(rgb_im_pred);

im9 = edge_neigh(im_gray)  %using function "edge_neigh" 


%Plotting edges using different operators 
subplot(3,4,5), imshow(edge(im_gray,'sobel')); title('Edge:Sobel');
subplot(3,4,6), imshow(edge(im_gray,'canny')); title('Edge:Canny');
subplot(3,4,7), imshow(edge(im_gray,'roberts')); title('Edge:Roberts');
subplot(3,4,8), imshow(edge(im_gray,'log')); title('Edge:Log');
subplot(3,4,9), subimage(im9); title ('Neighborhood method'); axis off;

%Removing noises in the chosen sobel edge

in=edge(im_gray);
in=imresize(in,4); %resizing back to original image resolution
%figure,imshow(in)
%improfile     %to understand the intensity values inorder to remove noise
in(50:305,60:210)=0; %to remove noises in face by assigning the values to 0
in(1:35,192:300)=0; %to remove hair part captured by assigning to 0

%Giving red colour to the edge 
int(:,:,1)=in(:,:); % 1 for Red and assigning 0 for Blue and Green
int(:,:,2)=0;
int(:,:,3)=0;
figure, imshow(mat2gray(int));

%Calling the function "initials_K" to sign on the image 
initials_K(mat2gray(int)); title('My coloured edge with initial K')


