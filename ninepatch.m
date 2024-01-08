clc;
clear;


origIm = imread('Images/kodim23.png'); 

%extract each true colour
image = im2double(origIm);
red = image(:,:,1);
green = image(:,:,2);
blue = image(:,:,3);

[row, col, ch] = size(origIm);
bayerFilter = zeros(row, col, ch,'uint8');

%RGGB Bayer Pattern
for i = 1:row
  for j = 1:col
    if mod(i, 2) == 0 && mod(j, 2) == 0
      bayerFilter(i, j, 3) = origIm(i, j, 3); %Blue
    elseif mod(i, 2) == 0 && mod(j, 2) == 1
      bayerFilter(i, j, 2) = origIm(i, j, 2); %Green
    elseif mod(i, 2) == 1 && mod(j, 2) == 0
      bayerFilter(i, j, 2) = origIm(i, j, 2); %Green
    elseif mod(i, 2) == 1 && mod(j, 2) == 1 
      bayerFilter(i, j, 1) = origIm(i, j, 1); %Red 
    end
  end
end

%double image
temp = zeros(row, col,'uint8');
for i = 1:row
  for j = 1:col
    if mod(i, 2) == 0 && mod(j, 2) == 0
      temp(i, j) = origIm(i, j, 3);
    elseif mod(i, 2) == 0 && mod(j, 2) == 1
      temp(i, j) = origIm(i, j, 2);
    elseif mod(i, 2) == 1 && mod(j, 2) == 0
      temp(i, j) = origIm(i, j, 2);
    elseif mod(i, 2) == 1 && mod(j, 2) == 1
      temp(i, j) = origIm(i, j, 1);
    end
  end
end

% figure, imshow(bayerFilter);
% %%%TRAINING
% temp = im2double(temp);
% X = im2col(temp, [5 5]); %columns
% 
% % 4 mosaic patches
% rggb = X(:,[1+(0*(row-4)):2:row-4+(0*(row-4))]);
% rggb = [rggb X(:,[1+(2*(row-4)):2:row-4+(2*(row-4))])];
% rggb = [rggb X(:,[1+(4*(row-4)):2:row-4+(4*(row-4))])];
% rggb = [rggb (X(:,[1+(0*(row-4)):2:row-4+(0*(row-4))])).^2];
% rggb = [rggb (X(:,[1+(2*(row-4)):2:row-4+(2*(row-4))])).^2];
% rggb = [rggb (X(:,[1+(4*(row-4)):2:row-4+(4*(row-4))])).^2];
% 
% gbrg = X(:,[2+(0*(row-4)):2:row-4+(0*(row-4))]);
% gbrg = [gbrg X(:,[2+(2*(row-4)):2:row-4+(2*(row-4))])];
% gbrg = [gbrg X(:,[2+(4*(row-4)):2:row-4+(4*(row-4))])];
% gbrg = [gbrg (X(:,[2+(0*(row-4)):2:row-4+(0*(row-4))])).^2];
% gbrg = [gbrg (X(:,[2+(2*(row-4)):2:row-4+(2*(row-4))])).^2];
% gbrg = [gbrg (X(:,[2+(4*(row-4)):2:row-4+(4*(row-4))])).^2];
% 
% grbg = X(:,[1+(1*(row-4)):2:row-4+(1*(row-4))]);
% grbg = [grbg X(:,[1+(3*(row-4)):2:row-4+(3*(row-4))])];
% grbg = [grbg X(:,[1+(5*(row-4)):2:row-4+(5*(row-4))])];
% grbg = [grbg (X(:,[1+(1*(row-4)):2:row-4+(1*(row-4))])).^2];
% grbg = [grbg (X(:,[1+(3*(row-4)):2:row-4+(3*(row-4))])).^2];
% grbg = [grbg (X(:,[1+(5*(row-4)):2:row-4+(5*(row-4))])).^2];
% 
% bggr = X(:,[2+(1*(row-4)):2:row-4+(1*(row-4))]);
% bggr = [bggr X(:,[2+(3*(row-4)):2:row-4+(3*(row-4))])];
% bggr = [bggr X(:,[2+(5*(row-4)):2:row-4+(5*(row-4))])];
% bggr = [bggr (X(:,[2+(1*(row-4)):2:row-4+(1*(row-4))])).^2];
% bggr = [bggr (X(:,[2+(3*(row-4)):2:row-4+(3*(row-4))])).^2];
% bggr = [bggr (X(:,[2+(5*(row-4)):2:row-4+(5*(row-4))])).^2];
% 
% %RGGB mosaic patch (green and blue missing)
% x = 1;
% for i = 3:2:row-2
%     G_center1(x,1) = green(i,3);
%     B_center1(x,1) = blue(i,3);
%     x = x+1;
% end
% x = 1;
% for i = 3:2:row-2
%     G_center2(x,1) = (green(i,5));
%     B_center2(x,1) = (blue(i,5));
%     x = x+1;
% end
% x = 1;
% for i = 3:2:row-2
%     G_center3(x,1) = (green(i,7));
%     B_center3(x,1) = (blue(i,7));
%     x = x+1;
% end
% x = 1;
% for i = 3:2:row-2
%     G_center4(x,1) = (green(i,3))^2;
%     B_center4(x,1) = (blue(i,3))^2;
%     x = x+1;
% end
% x = 1;
% for i = 3:2:row-2
%     G_center5(x,1) = (green(i,5))^2;
%     B_center5(x,1) = (blue(i,5))^2;
%     x = x+1;
% end
% x = 1;
% for i = 3:2:row-2
%     G_center6(x,1) = (green(i,7))^2;
%     B_center6(x,1) = (blue(i,7))^2;
%     x = x+1;
% end
% 
% G_center = [G_center1; G_center2; G_center3; G_center4; G_center5; G_center6];
% B_center = [B_center1; B_center2; B_center3; B_center4; G_center5; G_center6];
% 
% % A1_g = pinv(rggb'*rggb)*rggb'.*G_center;
% % A2_b = pinv(rggb'*rggb)*rggb'.*B_center;
% A1_g = regress(G_center,rggb');
% A1_g = A1_g';
% A2_b = regress(B_center,rggb');
% A2_b = A2_b';
% 
% %GBRG mosaic patch (red and blue missing)
% x = 1;
% for i = 4:2:row-2
%     R_center7(x,1) = red(i,3);
%     B_center7(x,1) = blue(i,3);
%     x = x+1;
% end
% x = 1;
% for i = 4:2:row-2
%     R_center8(x,1) = red(i,5);
%     B_center8(x,1) = blue(i,5);
%     x = x+1;
% end
% x = 1;
% for i = 4:2:row-2
%     R_center9(x,1) = red(i,7);
%     B_center9(x,1) = blue(i,7);
%     x = x+1;
% end
% x = 1;
% for i = 4:2:row-2
%     R_center10(x,1) = (red(i,3))^2;
%     B_center10(x,1) = (blue(i,3))^2;
%     x = x+1;
% end
% x = 1;
% for i = 4:2:row-2
%     R_center11(x,1) = (red(i,5))^2;
%     B_center11(x,1) = (blue(i,5))^2;
%     x = x+1;
% end
% x = 1;
% for i = 4:2:row-2
%     R_center12(x,1) = (red(i,7))^2;
%     B_center12(x,1) = (blue(i,7))^2;
%     x = x+1;
% end
% R_center = [R_center7; R_center8; R_center9; R_center10; R_center11; R_center12];
% B_center = [B_center7; B_center8; B_center9; B_center10; B_center11; B_center12];
% 
% % A3_r = pinv(gbrg'*gbrg)*gbrg'.*R_center;
% % A4_b = pinv(gbrg'*gbrg)*gbrg'.*B_center;
% 
% A3_r = regress(R_center, gbrg');
% A4_b = regress(B_center, gbrg');
% A3_r = A3_r';
% A4_b = A4_b';
% 
% %GBRG mosaic patch (red and blue missing)
% x = 1;
% for i = 3:2:row-2
%     R_center13(x,1) = red(i,4);
%     B_center13(x,1) = blue(i,4);
%     x = x+1;
% end
% x = 1;
% for i = 3:2:row-2
%     R_center14(x,1) = red(i,6);
%     B_center14(x,1) = blue(i,6);
%     x = x+1;
% end
% x = 1;
% for i = 3:2:row-2
%     R_center15(x,1) = red(i,8);
%     B_center15(x,1) = blue(i,8);
%     x = x+1;
% end
% x = 1;
% for i = 3:2:row-2
%     R_center16(x,1) = (red(i,4))^2;
%     B_center16(x,1) = (blue(i,4))^2;
%     x = x+1;
% end
% x = 1;
% for i = 3:2:row-2
%     R_center17(x,1) = (red(i,6))^2;
%     B_center17(x,1) = (blue(i,6))^2;
%     x = x+1;
% end
% x = 1;
% for i = 3:2:row-2
%     R_center18(x,1) = (red(i,8))^2;
%     B_center18(x,1) = (blue(i,8))^2;
%     x = x+1;
% end
% 
% R_center = [R_center13; R_center14; R_center15; R_center16; R_center17; R_center18];
% B_center = [B_center13; B_center14; B_center15; B_center16; B_center17; B_center18];
%  
% % A5_r = pinv(grbg'*grbg)*grbg'.*R_center;
% % A6_b = pinv(grbg'*grbg)*grbg'.*B_center;
% 
% A5_r = regress(R_center, grbg');
% A6_b = regress(B_center, grbg');
% A5_r = A5_r';
% A6_b = A6_b';
% 
% 
% %GBRG mosaic patch (red and green missing)
% x = 1;
% for i = 4:2:row-2
%     R_center19(x,1) = red(i,4);
%     G_center19(x,1) = green(i,4);
%     x = x+1;
% end
% x = 1;
% for i = 4:2:row-2
%     R_center20(x,1) = red(i,6);
%     G_center20(x,1) = green(i,6);
%     x = x+1;
% end
% x = 1;
% for i = 4:2:row-2
%     R_center21(x,1) = red(i,8);
%     G_center21(x,1) = green(i,8);
%     x = x+1;
% end
% x = 1;
% for i = 4:2:row-2
%     R_center22(x,1) = (red(i,4))^2;
%     G_center22(x,1) = (green(i,4))^2;
%     x = x+1;
% end
% x = 1;
% for i = 4:2:row-2
%     R_center23(x,1) = (red(i,6))^2;
%     G_center23(x,1) = (green(i,6))^2;
%     x = x+1;
% end
% x =1;
% for i = 4:2:row-2
%     R_center24(x,1) = (red(i,8))^2;
%     G_center24(x,1) = (green(i,8))^2;
%     x = x+1;
% end
% 
% R_center = [R_center19; R_center20; R_center21; R_center22; R_center23; R_center24];
% G_center = [G_center19; G_center20; G_center21; G_center22; G_center23; G_center24];
% 
% % A7_r = pinv(bggr'*bggr)*bggr'.*R_center;
% % A8_g = pinv(bggr'*bggr)*bggr'.*G_center;
% A7_r = regress(R_center, bggr');
% A8_g = regress(G_center, bggr');
% A7_r = A7_r';
% A8_g = A8_g';

%%%%TRAINING
temp = im2double(temp);
X = im2col(temp, [9 9]); %columns

% 4 mosaic patches
rggb = [];
gbrg = [];
for x = 0:2:200
    rggb = [rggb X(:,[1+(x*(row-8)):2:row-8+(x*(row-8))])];
    gbrg = [gbrg X(:,[2+(x*(row-8)):2:row-8+(x*(row-8))])];
end

grbg = [];
bggr = [];
for x = 1:2:201
    grbg = [grbg X(:,[1+(x*(row-8)):2:row-8+(x*(row-8))])];
    bggr = [bggr X(:,[2+(x*(row-8)):2:row-8+(x*(row-8))])];
end


%RGGB mosaic patch (green and blue missing)
x = 1;
for j = 5:2:205
    for i = 5:2:row-4
        G_center(x,1) = green(i,j);
        B_center(x,1) = blue(i,j);
        x = x+1;
    end
end

A1_g = linearRegression(G_center,rggb');
A1_g = A1_g';

A2_b = linearRegression(B_center,rggb');
A2_b = A2_b';

%GBRG mosaic patch (red and blue missing)
x = 1;
for j = 5:2:205
    for i = 6:2:row-4
        R_center(x,1) = red(i,j);
        B_center(x,1) = blue(i,j);
        x = x+1;
    end
end

A3_r = linearRegression(R_center, gbrg');
A4_b = linearRegression(B_center, gbrg');
A3_r = A3_r';
A4_b = A4_b';

%GBRG mosaic patch (red and blue missing)
x = 1;
for j = 6:2:206
    for i = 5:2:row-4
        R_center(x,1) = red(i,j);
        B_center(x,1) = blue(i,j);
        x = x+1;
    end
end

A5_r = linearRegression(R_center, grbg');
A6_b = linearRegression(B_center, grbg');
A5_r = A5_r';
A6_b = A6_b';

%GBRG mosaic patch (red and green missing)
x = 1;
for j = 6:2:206
    for i = 6:2:row-4
        R_center(x,1) = red(i,j);
        G_center(x,1) = green(i,j);
        x = x+1;
    end
end

A7_r = linearRegression(R_center, bggr');
A8_g = linearRegression(G_center, bggr');
A7_r = A7_r';
A8_g = A8_g';

% %%%%TRAINING
% temp = im2double(temp);
% X = im2col(temp, [9 9]); %columns
% 
% % 4 mosaic patches
% rggb = X(:,[1+(0*(row-8)):2:row-8+(0*(row-8))]);
% gbrg = X(:,[2+(0*(row-8)):2:row-8+(0*(row-8))]);
% grbg = X(:,[1+(1*(row-8)):2:row-8+(1*(row-8))]);
% bggr = X(:,[2+(1*(row-8)):2:row-8+(1*(row-8))]);
% 
% %RGGB mosaic patch (green and blue missing)
% x = 1;
% for i = 5:2:row-4
%     G_center(x,1) = green(i,5);
%     B_center(x,1) = blue(i,5);
%     x = x+1;
% end
% 
% % A1_g = pinv(rggb'*rggb)*rggb'.*G_center;
% % A2_b = pinv(rggb'*rggb)*rggb'.*B_center;
% A1_g = regress(G_center,rggb');
% A1_g = A1_g';
% A2_b = regress(B_center,rggb');
% A2_b = A2_b';
% 
% %GBRG mosaic patch (red and blue missing)
% x = 1;
% for i = 6:2:row-4
%     R_center(x,1) = red(i,5);
%     B_center(x,1) = blue(i,5);
%     x = x+1;
% end
% 
% % A3_r = pinv(gbrg'*gbrg)*gbrg'.*R_center;
% % A4_b = pinv(gbrg'*gbrg)*gbrg'.*B_center;
% A3_r = regress(R_center, gbrg');
% A4_b = regress(B_center, gbrg');
% A3_r = A3_r';
% A4_b = A4_b';
% 
% %GBRG mosaic patch (red and blue missing)
% x = 1;
% for i = 5:2:row-4
%     R_center(x,1) = red(i,6);
%     B_center(x,1) = blue(i,6);
%     x = x+1;
% end
% 
% % A5_r = pinv(grbg'*grbg)*grbg'.*R_center;
% % A6_b = pinv(grbg'*grbg)*grbg'.*B_center;
% A5_r = regress(R_center, grbg');
% A6_b = regress(B_center, grbg');
% A5_r = A5_r';
% A6_b = A6_b';
% 
% %GBRG mosaic patch (red and green missing)
% x = 1;
% for i = 6:2:row-4
%     R_center(x,1) = red(i,6);
%     G_center(x,1) = green(i,6);
%     x = x+1;
% end
% 
% % A7_r = pinv(bggr'*bggr)*bggr'.*R_center;
% % A8_g = pinv(bggr'*bggr)*bggr'.*G_center;
% A7_r = regress(R_center, bggr');
% A8_g = regress(G_center, bggr');
% A7_r = A7_r';
% A8_g = A8_g';

% %%%%TRAINING
% temp = im2double(temp);
% X = im2col(temp, [9 9]); %columns
% 
% % 4 mosaic patches
% rggb = X(:,[1+(0*(row-8)):2:row-8+(0*(row-8))]);
% rggb = [rggb X(:,[1+(2*(row-8)):2:row-8+(2*(row-8))])];
% rggb = [rggb (X(:,[1+(0*(row-8)):2:row-8+(0*(row-8))])).^2];
% rggb = [rggb (X(:,[1+(2*(row-8)):2:row-8+(2*(row-8))])).^2];
% 
% gbrg = X(:,[2+(0*(row-8)):2:row-8+(0*(row-8))]);
% gbrg = [gbrg X(:,[2+(2*(row-8)):2:row-8+(2*(row-8))])];
% gbrg = [gbrg (X(:,[2+(0*(row-8)):2:row-8+(0*(row-8))])).^2];
% gbrg = [gbrg (X(:,[2+(2*(row-8)):2:row-8+(2*(row-8))])).^2];
% 
% grbg = X(:,[1+(1*(row-8)):2:row-8+(1*(row-8))]);
% grbg = [grbg X(:,[1+(3*(row-8)):2:row-8+(3*(row-8))])];
% grbg = [grbg (X(:,[1+(1*(row-8)):2:row-8+(1*(row-8))])).^2];
% grbg = [grbg (X(:,[1+(3*(row-8)):2:row-8+(3*(row-8))])).^2];
% 
% bggr = X(:,[2+(1*(row-8)):2:row-8+(1*(row-8))]);
% bggr = [bggr X(:,[2+(3*(row-8)):2:row-8+(3*(row-8))])];
% bggr = [bggr (X(:,[2+(1*(row-8)):2:row-8+(1*(row-8))])).^2];
% bggr = [bggr (X(:,[2+(3*(row-8)):2:row-8+(3*(row-8))])).^2];
% 
% %RGGB mosaic patch (green and blue missing)
% x = 1;
% for i = 5:2:row-4
%     G_center1(x,1) = green(i,5);
%     B_center1(x,1) = blue(i,5);
%     x = x+1;
% end
% x = 1;
% for i = 5:2:row-4
%     G_center2(x,1) = (green(i,7));
%     B_center2(x,1) = (blue(i,7));
%     x = x+1;
% end
% x = 1;
% for i = 5:2:row-4
%     G_center3(x,1) = (green(i,5))^2;
%     B_center3(x,1) = (blue(i,5))^2;
%     x = x+1;
% end
% x = 1;
% for i = 5:2:row-4
%     G_center4(x,1) = (green(i,7))^2;
%     B_center4(x,1) = (blue(i,7))^2;
%     x = x+1;
% end
% 
% G_center = [G_center1; G_center2; G_center3; G_center4];
% B_center = [B_center1; B_center2; B_center3; B_center4];
% 
% % A1_g = pinv(rggb'*rggb)*rggb'.*G_center;
% % A2_b = pinv(rggb'*rggb)*rggb'.*B_center;
% A1_g = regress(G_center,rggb');
% A1_g = A1_g';
% A2_b = regress(B_center,rggb');
% A2_b = A2_b';
% 
% %GBRG mosaic patch (red and blue missing)
% x = 1;
% for i = 6:2:row-4
%     R_center5(x,1) = red(i,5);
%     B_center5(x,1) = blue(i,5);
%     x = x+1;
% end
% x = 1;
% for i = 6:2:row-4
%     R_center6(x,1) = red(i,7);
%     B_center6(x,1) = blue(i,7);
%     x = x+1;
% end
% x = 1;
% for i = 6:2:row-4
%     R_center7(x,1) = (red(i,5))^2;
%     B_center7(x,1) = (blue(i,5))^2;
%     x = x+1;
% end
% x = 1;
% for i = 6:2:row-4
%     R_center8(x,1) = (red(i,7))^2;
%     B_center8(x,1) = (blue(i,7))^2;
%     x = x+1;
% end
% 
% R_center = [R_center5; R_center6; R_center7; R_center8];
% B_center = [B_center5; B_center6; B_center7; B_center8];
% 
% % A3_r = pinv(gbrg'*gbrg)*gbrg'.*R_center;
% % A4_b = pinv(gbrg'*gbrg)*gbrg'.*B_center;
% 
% A3_r = regress(R_center, gbrg');
% A4_b = regress(B_center, gbrg');
% A3_r = A3_r';
% A4_b = A4_b';
% 
% %GBRG mosaic patch (red and blue missing)
% x = 1;
% for i = 5:2:row-4
%     R_center9(x,1) = red(i,6);
%     B_center9(x,1) = blue(i,6);
%     x = x+1;
% end
% x = 1;
% for i = 5:2:row-4
%     R_center10(x,1) = red(i,8);
%     B_center10(x,1) = blue(i,8);
%     x = x+1;
% end
% x = 1;
% for i = 5:2:row-4
%     R_center11(x,1) = (red(i,6))^2;
%     B_center11(x,1) = (blue(i,6))^2;
%     x = x+1;
% end
% 
% x = 1;
% for i = 5:2:row-4
%     R_center12(x,1) = (red(i,8))^2;
%     B_center12(x,1) = (blue(i,8))^2;
%     x = x+1;
% end
% 
% R_center = [R_center9; R_center10; R_center11; R_center12];
% B_center = [B_center9; B_center10; B_center11; B_center12];
%  
% % A5_r = pinv(grbg'*grbg)*grbg'.*R_center;
% % A6_b = pinv(grbg'*grbg)*grbg'.*B_center;
% 
% A5_r = regress(R_center, grbg');
% A6_b = regress(B_center, grbg');
% A5_r = A5_r';
% A6_b = A6_b';
% 
% 
% % GBRG mosaic patch (red and green missing)
% x = 1;
% for i = 6:2:row-4
%     R_center13(x,1) = red(i,6);
%     G_center13(x,1) = green(i,6);
%     x = x+1;
% end
% x = 1;
% for i = 6:2:row-4
%     R_center14(x,1) = red(i,8);
%     G_center14(x,1) = green(i,8);
%     x = x+1;
% end
% x = 1;
% for i = 6:2:row-4
%     R_center15(x,1) = (red(i,6))^2;
%     G_center15(x,1) = (green(i,6))^2;
%     x = x+1;
% end
% x = 1;
% for i = 6:2:row-4
%     R_center16(x,1) = (red(i,8))^2;
%     G_center16(x,1) = (green(i,8))^2;
%     x = x+1;
% end
% 
% R_center = [R_center13; R_center14; R_center15; R_center16];
% G_center = [G_center13; G_center14; G_center15; G_center16];
% 
% A7_r = pinv(bggr'*bggr)*bggr'.*R_center;
% A8_g = pinv(bggr'*bggr)*bggr'.*G_center;
% A7_r = regress(R_center, bggr');
% A8_g = regress(G_center, bggr');
% A7_r = A7_r';
% A8_g = A8_g';


bayerFilter = im2double(bayerFilter);

R = bayerFilter(:,:,1);
G = bayerFilter(:,:,2);
B = bayerFilter(:,:,3);

for x = 0:2:col-9
    i = 1;
    for j = 5:2:row-4
        greens = (A1_g * X(:,[1+(x*(row-8)):2:row-8+(x*(row-8))]));
        G(j,x+5) = greens(i);
        blues = (A2_b * X(:,[1+(x*(row-8)):2:row-8+(x*(row-8))]));
        B(j,x+5) = blues(i);
        i = i + 1;
    end
end

for x = 0:2:col-9
    i = 1;
    for j = 6:2:row-4
        reds = (A3_r * X(:,[2+(x*(row-8)):2:row-8+(x*(row-8))]));
        R(j,x+5) = reds(i);
        blues = (A4_b * X(:,[2+(x*(row-8)):2:row-8+(x*(row-8))]));
        B(j,x+5) = blues(i);
        i = i + 1;
    end
end


for x = 1:2:col-9
    i = 1;
    for j = 5:2:row-4
        reds = (A5_r * X(:,[1+(x*(row-8)):2:row-8+(x*(row-8))]));
        R(j,x+5) = reds(i);
        blues = (A6_b * X(:,[1+(x*(row-8)):2:row-8+(x*(row-8))]));
        B(j,x+5) = blues(i);
        i = i + 1;
    end
end

for x = 1:2:col-9
    i = 1;
    for j = 6:2:row-4
        reds = (A7_r * X(:,[2+(x*(row-8)):2:row-8+(x*(row-8))]));
        R(j,x+5) = reds(i);
        greens = (A8_g * X(:,[2+(x*(row-8)):2:row-8+(x*(row-8))]));
        G(j,x+5) = greens(i);
        i = i + 1;
    end
end

%EDGE INTERPOLATION (linear interpolation)

%RED CHANNEL
for i = 2:2:col-2
    R(1,i) = (R(1,i-1)+R(1,i+1))/2;
    R(3,i) = (R(3,i-1)+R(3,i+1))/2;
    R(row-3,i) = (R(row-3,i-1)+R(row-3,i+1))/2;
    R(row-1,i) = (R(row-1,i-1)+R(row-1,i+1))/2;
end
for i = 2:2:row-2
    R(i,1) = (R(i-1,1) + R(i+1,1))/2;
    R(i,3) = (R(i-1,3) + R(i+1,3))/2;
    R(i,col-1) = (R(i-1,col-1) + R(i+1,col-1))/2;
    R(i,col-3) = (R(i-1,col-3) + R(i+1,col-3))/2;
end
for i = 2:col-2
    R(2,i) = (R(1,i) + R(3,i))/2;
    R(4,i) = (R(3,i) + R(5,i))/2;
    R(row-2,i) = (R(row-1,i) + R(row-3,i))/2;
end
for i = 2:row-2
    R(i,2) = (R(i,1)+R(i,3))/2;
    R(i,4) = (R(i,3)+R(i,5))/2;
    R(i,col-2) = (R(i,col-3) + R(i,col-1))/2;
end
for i = 1:col
    R(row,i) = R(row-1,i);
end
for i = 1:row
    R(i,col) = R(i,col-1);
end

%BLUE CHANNEL
for i = 3:2:col-2
    B(row-2,i) = (B(row-2,i-1) + B(row-2,i+1))/2;
    B(row,i) = (B(row,i-1) + B(row,i+1))/2;
    B(2,i) = (B(2,i-1) + B(2,i+1))/2;
    B(4,i) = (B(4,i-1) + B(4,i+1))/2;
end
for i = 3:2:row-2
    B(i,2) = (B(i-1,2) + B(i+1,2))/2;
    B(i,4) = (B(i-1,4) + B(i+1,4))/2;
    B(i,col-2) = (B(i-1,col-2) + B(i+1,col-2))/2;
    B(i,col) = (B(i-1,col) + B(i+1,col))/2;
end
for i = 2:col
    B(3,i) = (B(2,i) + B(4,i))/2;
    B(row-3,i) = (B(row-4,i) + B(row-2,i))/2;
    B(row-1,i) = (B(row,i) + B(row-2,i))/2;
end
for i = 2:row
    B(i,3) = (B(i,2) + B(i,4))/2;
    B(i,col-3) = (B(i,col-2) + B(i,col-4))/2;
    B(i,col-1) = (B(i,col-2) + B(i,col))/2;
end
for i = 1:row
    B(i,1) = B(i,2);
end
for i = 1:col
    B(1,i) = B(2,i);
end

%GREEN CHANNEL
for i = 3:2:row-1
    G(i,1) = (G(i-1,1) + G(i+1,1))/2;
    G(i,3) = (G(i-1,3) + G(i+1,3))/2;
    G(i,col-3) = (G(i-1,col-3) + G(i+1,col-3))/2;
    G(i,col-1) = (G(i-1,col-1) + G(i+1,col-1))/2;
end

for i = 2:2:row-2
    G(i,2) = (G(i-1,2) + G(i+1,2))/2;
    G(i,4) = (G(i-1,4) + G(i+1,4))/2;
    G(i,col-2) = (G(i-1,col-2) + G(i+1,col-2))/2;
    G(i,col) = (G(i-1,col) + G(i+1,col))/2;
end
for i = 2:2:col-1
    G(2,i) = (G(2,i-1) + G(2,i+1))/2;
    G(4,i) = (G(4,i-1) + G(4,i+1))/2;
    G(row-2,i) = (G(row-2,i-1) + G(row-2,i+1))/2;
    G(row,i) = (G(row,i-1) + G(row,i+1))/2;
end
for i = 3:2:col-1
    G(1,i) = (G(1,i-1) + G(1,i+1))/2;
    G(3,i) = (G(3,i-1) + G(3,i+1))/2;
    G(row-1,i) = (G(row-1,i-1) + G(row-1,i+1))/2;
    G(row-3,i) = (G(row-3,i-1) + G(row-3,i+1))/2;
end
G(1,1) = G(1,2);
G(row,col) = G(row,col-1);


R = im2uint8(R);
G = im2uint8(G);
B = im2uint8(B);

newIm = cat(3, R, G, B);
figure, imshow(newIm);

temp = im2uint8(temp);
matlab = demosaic(temp, 'rggb');
figure, imshow(matlab)

error_matlab = immse(origIm, matlab)
error_regression = immse(origIm, newIm)

psnr = psnr(origIm,(newIm))
psnr_matlab = psnr(origIm,matlab)
