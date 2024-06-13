function initials_K(K)


%K=zeros(50,50,3); %to sign ona an image,comment and call this as  object 
K(5:45,25,1)=255;
for i=25:45
    K(i,i,1)=255;
end
for i=25:45
    K(50-i+1,i,1)=255;
end
figure, imshow(K)
