function mask = edge_neigh(im0)

[row col, dim] = size(im0)

if dim>1
    im = im0(:,:,1); %rgb2gray(im0);
else
    im = im0;
end

%2 -neighbourhood
for i=1:row-1
	for j=1:col-1
		im2(i,j) = abs(im(i,j)-im(i+1,j+1))+ abs(im(i,j+1)-im(i+1,j));
	end
end
mask = im2;
%figure, imshow(im2);
%figure, imshow(im0)