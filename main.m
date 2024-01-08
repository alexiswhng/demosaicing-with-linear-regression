clc;
clear;

%%%%%%%%%%%% TRAINING %%%%%%%%%%%%

% origIm = imread('Images/kodim23.png'); 
% 
% %extract each true colour
% image = im2double(origIm);
% red = image(:,:,1);
% green = image(:,:,2);
% blue = image(:,:,3);
% 
% [row, col, ch] = size(origIm);
% bayerFilter = zeros(row, col, ch,'uint8');
% 
% %RGGB Bayer Pattern
% for i = 1:row
%   for j = 1:col
%     if mod(i, 2) == 0 && mod(j, 2) == 0
%       bayerFilter(i, j, 3) = origIm(i, j, 3); %Blue
%     elseif mod(i, 2) == 0 && mod(j, 2) == 1
%       bayerFilter(i, j, 2) = origIm(i, j, 2); %Green
%     elseif mod(i, 2) == 1 && mod(j, 2) == 0
%       bayerFilter(i, j, 2) = origIm(i, j, 2); %Green
%     elseif mod(i, 2) == 1 && mod(j, 2) == 1 
%       bayerFilter(i, j, 1) = origIm(i, j, 1); %Red 
%     end
%   end
% end
% 
% %double image
% temp = zeros(row, col,'uint8');
% for i = 1:row
%   for j = 1:col
%     if mod(i, 2) == 0 && mod(j, 2) == 0
%       temp(i, j) = origIm(i, j, 3);
%     elseif mod(i, 2) == 0 && mod(j, 2) == 1
%       temp(i, j) = origIm(i, j, 2);
%     elseif mod(i, 2) == 1 && mod(j, 2) == 0
%       temp(i, j) = origIm(i, j, 2);
%     elseif mod(i, 2) == 1 && mod(j, 2) == 1
%       temp(i, j) = origIm(i, j, 1);
%     end
%   end
% end
% 
% figure, imshow(bayerFilter);

% temp = im2double(temp);
% X = im2col(temp, [5 5]); %columns
% 
% % 4 mosaic patches
% rggb=[];
% gbrg=[];
% for x = 0:2:250
%     rggb = [rggb X(:,[1+(x*(row-4)):2:row-4+(x*(row-4))])];
%     gbrg = [gbrg X(:,[2+(x*(row-4)):2:row-4+(x*(row-4))])];
% end
% 
% for x = 0:2:250
%     rggb = [rggb (X(:,[1+(x*(row-4)):2:row-4+(x*(row-4))])).^2];
%     gbrg = [gbrg (X(:,[2+(x*(row-4)):2:row-4+(x*(row-4))])).^2];
% end
% grbg=[];
% bggr=[];
% for x = 1:2:251
%     grbg = [grbg X(:,[1+(x*(row-4)):2:row-4+(x*(row-4))])];
%     bggr = [bggr X(:,[2+(x*(row-4)):2:row-4+(x*(row-4))])];
% end
% for x = 1:2:251
%     grbg = [grbg (X(:,[1+(x*(row-4)):2:row-4+(x*(row-4))])).^2];
%     bggr = [bggr (X(:,[2+(x*(row-4)):2:row-4+(x*(row-4))])).^2];
% end
% 
% %RGGB mosaic patch (green and blue missing)
% x = 1;
% for j = 3:2:253
%     for i = 3:2:row-2
%         G_center(x,1) = green(i,j);
%         B_center(x,1) = blue(i,j);
%         x = x+1;
%     end
% end
% for j = 3:2:253
%     for i = 3:2:row-2
%         G_center(x,1) = (green(i,j))^2;
%         B_center(x,1) = (blue(i,j))^2;
%         x = x+1;
%     end
% end
% 
% A1_g = ((pinv(rggb'*rggb)*rggb')'*G_center);
% A2_b = ((pinv(rggb'*rggb)*rggb')'*B_center);
% 
% %GBRG mosaic patch (red and blue missing)
% x = 1;
% for j = 3:2:253
%     for i = 4:2:row-2
%         R_center(x,1) = red(i,j);
%         B_center(x,1) = blue(i,j);
%         x = x+1;
%     end
% end
% for j = 3:2:253
%     for i = 4:2:row-2
%         R_center(x,1) = (red(i,j))^2;
%         B_center(x,1) = (blue(i,j))^2;
%         x = x+1;
%     end
% end
% 
% A3_r = ((pinv(gbrg'*gbrg)*gbrg')'*R_center);
% A4_b = ((pinv(gbrg'*gbrg)*gbrg')'*B_center);
% 
% 
% %GRBG mosaic patch (red and blue missing)
% x = 1;
% for j = 4:2:254
%     for i = 3:2:row-2
%         R_center(x,1) = red(i,j);
%         B_center(x,1) = blue(i,j);
%         x = x+1;
%     end
% end
% for j = 4:2:254
%     for i = 3:2:row-2
%         R_center(x,1) = (red(i,j))^2;
%         B_center(x,1) = (blue(i,j))^2;
%         x = x+1;
%     end
% end
% 
% A5_r = ((pinv(grbg'*grbg)*grbg')'*R_center);
% A6_b = ((pinv(grbg'*grbg)*grbg')'*B_center);
% 
% %GBRG mosaic patch (red and green missing)
% x = 1;
% for j = 4:2:254
%     for i = 4:2:row-2
%         G_center(x,1) = green(i,j);
%         R_center(x,1) = red(i,j);
%         x = x+1;
%     end
% end
% 
% for j = 4:2:254
%     for i = 4:2:row-2
%         G_center(x,1) = green(i,j)^2;
%         R_center(x,1) = red(i,j)^2;
%         x = x+1;
%     end
% end
% 
% A7_r = ((pinv(bggr'*bggr)*bggr')'*R_center);
% A8_g = ((pinv(bggr'*bggr)*bggr')'*G_center);

%%%%%%%%%%%% TESTING  %%%%%%%%%%%%%

%%% DEMOSAICING USING COEFFICIENTS %%%%

A1_g = [-0.0188341619468899;0.0241355984617506;-0.114207561968708;0.0167269052925421;0.00303333132949424;0.0416834590091080;0.00827936042343848;0.165761695841181;-0.00491908339530584;0.0612538963107545;-0.135157041303301;0.199704441909308;0.527708754026226;0.197252090290885;-0.134795087931805;0.0458797798186151;-0.0150454754061599;0.158539724767506;0.0107338597370412;0.0375654047846299;0.00229655969627244;0.0190161810004442;-0.113633421562167;0.0397953424647689;-0.0235235880197238];
A2_b = [-0.0126562607273405;-0.0507973251531000;-0.103540141717915;-0.0504187138903981;0.0205410737227821;-0.0248984357421593;0.279753157460859;0.0465396116631378;0.226794108460880;0.0296217710075232;-0.146732780656884;0.0704434872067884;0.497742862013257;0.0613089621452722;-0.162458454853736;0.0125517867311244;0.214756234624012;-0.0110533549644574;0.282444995521139;-0.0231799450140343;0.0206572968006827;-0.0431858022263870;-0.103345798287500;-0.0162128148628691;-0.0142662835041391];
A3_r = [-0.0138515775165620;0.0824792697260493;-0.0388550119129265;0.0671280727523379;0.00903822935129383;-0.0258874911721565;-0.105954173565440;0.0429134497043053;-0.164086521808147;-0.0145946108411913;-0.0862499356352119;0.345236753905425;0.739630503302644;0.361160662997585;-0.0579373857655526;-0.0121523246525284;-0.0949752409520625;0.0433841606966247;-0.135496633988523;-0.0336644025339416;0.00665744340547986;0.0565119676680276;-0.0620204134807121;0.0940733758024608;-0.00251751536058328];
A4_b = [-0.0213930293957298;0.00763457759644076;-0.0949900481807862;0.0109014816295852;-0.0175263033586784;0.110190798404698;-0.131745766507269;0.332673433412394;-0.0782933492112184;0.0619034611995905;-0.0399977246031847;-0.0154769906046801;0.802706614260469;-0.0265781661333644;-0.0549510435513107;0.0792069462452793;-0.109772618521468;0.310980349523153;-0.140198271416464;0.112935980724951;-0.0263097978974385;0.0147097120868051;-0.0847665177015371;0.00952112869032489;-0.00871738732749776];
A5_r = [-0.0126305753319323;0.0112342937855755;-0.104399081559520;0.0181482351232347;-0.0311959773580434;0.0857421395438859;-0.111371561039207;0.342335914021893;-0.0789114069435452;0.0728434550815488;-0.0499677656402229;-0.0269662670865391;0.793341154354268;-0.0321890755218050;-0.0693774590404334;0.0789199165281927;-0.0866023731017034;0.335093379900620;-0.121812565214353;0.0916169021272702;-0.0345464161623373;0.0244633620652252;-0.100331159501373;0.00690597271573297;-1.10150399934793e-05];
A6_b = [-0.0216572063775951;0.0953316072477250;-0.0266281491168392;0.0409320194547236;0.0200837652056817;-0.000126100584720279;-0.138084976289923;0.0171055011889922;-0.119141151946432;-0.0151681363389479;-0.0849799431439733;0.367793281857303;0.730244981855568;0.367684869583538;-0.0824933434844438;-0.00525884743533709;-0.120941329389489;0.00909202985531111;-0.120759530085534;-0.00441230290006035;0.0201662148627677;0.0411082931601469;-0.0367546175325835;0.0931148589698860;-0.0240753877859622];
A7_r = [-0.0245859864144577;-0.0414893762560777;-0.0641344754130586;-0.0931796413371265;0.0246548183834535;-0.00613792454806515;0.256423238418430;0.0253566633225021;0.256592190226992;0.0408599093070490;-0.215097219751842;0.0959240881969996;0.540564211260813;0.0149606987615965;-0.203138178075581;0.0410690467991454;0.220462597312994;0.0289013895271213;0.271535198010817;0.00400035662834692;0.0239113873884927;-0.0761348781198692;-0.0608546006811236;-0.0365849602700745;-0.0267742540223402];
A8_g = [-0.0337602583638954;0.0237938822858105;-0.0944002232762369;0.00422943644415605;0.00978282163108971;0.0502502652633573;0.00522307092019779;0.155940606097914;0.00258509751613645;0.0527519488562241;-0.164437942182543;0.212177872623404;0.544204351255713;0.197074609648175;-0.153214621687832;0.0585415735779339;-0.00946278936891408;0.174806508755861;0.00168578972038547;0.0377879120114617;0.00671218604810090;0.00226744996534496;-0.0942036790558259;0.0351947268853109;-0.0285410065579107];

%original RGB Image
testIm = imread('Images/kodim05.png');
% [row, col, ch] = size(testIm);
% 
% % %convert to mosaic image
% bayerFilter = zeros(row, col,'uint8');
% for i = 1:row
%   for j = 1:col
%     if mod(i, 2) == 0 && mod(j, 2) == 0
%       bayerFilter(i, j) = testIm(i, j, 3);
%     elseif mod(i, 2) == 0 && mod(j, 2) == 1
%       bayerFilter(i, j) = testIm(i, j, 2);
%     elseif mod(i, 2) == 1 && mod(j, 2) == 0
%       bayerFilter(i, j) = testIm(i, j, 2);
%     elseif mod(i, 2) == 1 && mod(j, 2) == 1
%       bayerFilter(i, j) = testIm(i, j, 1);
%     end
%   end
% end


bayerFilter = imread('input/kodim05.png'); %mosaic image (b/w)
bayerFilter = im2double(bayerFilter);

[row, col] = size(bayerFilter);

R = zeros(row,col);
G = zeros(row,col);
B = zeros(row,col);

R(1:2:end,1:2:end) = bayerFilter(1:2:end,1:2:end);
G(1:2:end,2:2:end) = bayerFilter(1:2:end,2:2:end);
G(2:2:end,1:2:end) = bayerFilter(2:2:end,1:2:end);
B(2:2:end,2:2:end) = bayerFilter(2:2:end,2:2:end);

X = im2col(bayerFilter, [5 5]); %columns

for x = 0:2:col-5
    i = 1;
    for j = 3:2:row-2
        greens =(A1_g' * X(:,[1+(x*(row-4)):2:row-4+(x*(row-4))]));
        G(j,x+3) = greens(i);
        blues = (A2_b' * X(:,[1+(x*(row-4)):2:row-4+(x*(row-4))]));
        B(j,x+3) = blues(i);
        i = i + 1;
    end
end

for x = 0:2:col-5
    i = 1;
    for j = 4:2:row-2
        reds = (A3_r' * X(:,[2+(x*(row-4)):2:row-4+(x*(row-4))]));
        R(j,x+3) = reds(i);
        blues = (A4_b' * X(:,[2+(x*(row-4)):2:row-4+(x*(row-4))]));
        B(j,x+3) = blues(i);
        i = i + 1;
    end
end


for x = 1:2:col-5
    i = 1;
    for j = 3:2:row-2
        reds = (A5_r' * X(:,[1+(x*(row-4)):2:row-4+(x*(row-4))]));
        R(j,x+3) = reds(i);
        blues = (A6_b' * X(:,[1+(x*(row-4)):2:row-4+(x*(row-4))]));
        B(j,x+3) = blues(i);
        i = i + 1;
    end
end

for x = 1:2:col-5
    i = 1;
    for j = 4:2:row-2
        reds = (A7_r' * X(:,[2+(x*(row-4)):2:row-4+(x*(row-4))]));
        R(j,x+3) = reds(i);
        greens = (A8_g' * X(:,[2+(x*(row-4)):2:row-4+(x*(row-4))]));
        G(j,x+3) = greens(i);
        i = i + 1;
    end
end

%EDGE CASES (using linear interpolation)

%Red Channel
for i = 2:2:col-2
    R(1,i) = (R(1,i-1)+R(1,i+1))/2;
    R(row-1,i) = (R(row-1,i-1)+R(row-1,i+1))/2;
end
for i = 2:2:row-2
    R(i,1) = (R(i-1,1) + R(i+1,1))/2;
    R(i,col-1) = (R(i-1,col-1) + R(i+1,col-1))/2;
end
for i = 2:col-2
    R(2,i) = (R(1,i) + R(3,i))/2;
    R(row-2,i) = (R(row-1,i) + R(row-3,i))/2;
end
for i = 2:row-2
    R(i,2) = (R(i,1)+R(i,3))/2;
    R(i,col-2) = (R(i,col-3) + R(i,col-1))/2;
end
if mod(col,2) == 1
    for i = 2:2:row-2
        R(i,col) = (R(i-1,col) + R(i+1,col))/2;
    end
    for i = 1:row
        R(i,col-1) = (R(i, col-2) + R(i, col))/2;
    end
end  
for i = 1:col
    R(row,i) = R(row-1,i);
end
for i = 1:row
    R(i,col) = R(i,col-1);
end

%BLUE CHANNEL
for i = 3:2:col-2
    B(row,i) = (B(row,i-1) + B(row,i+1))/2;
    B(2,i) = (B(2,i-1) + B(2,i+1))/2;
end
for i = 3:2:row-2
    B(i,2) = (B(i-1,2) + B(i+1,2))/2;
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
if mod(col,2) == 1
    for i = 1:row
        B(i,col) = B(i,col-1);
    end
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
end
if mod(col,2) == 0
    for i = 3:2:row-1
        G(i,col-1) = (G(i-1,col-1) + G(i+1,col-1))/2;
    end
else
    for i = 3:2:row-1
        G(i,col) = (G(i-1,col) + G(i+1,col))/2;
    end
end
for i = 2:2:row-2
    G(i,2) = (G(i-1,2) + G(i+1,2))/2;
end
if mod(col,2) == 0
    for i = 2:2:row-2
        G(i,col) = (G(i-1,col) + G(i+1,col))/2;
    end
else
    for i = 2:2:row-2
        G(i,col-1) = (G(i-1,col-1) + G(i+1,col-1))/2;
    end
end
for i = 2:2:col-1
    G(2,i) = (G(2,i-1) + G(2,i+1))/2;
    G(row,i) = (G(row,i-1) + G(row,i+1))/2;
end
for i = 3:2:col-1
    G(1,i) = (G(1,i-1) + G(1,i+1))/2;
    G(row-1,i) = (G(row-1,i-1) + G(row-1,i+1))/2;
end
G(1,1) = G(1,2);
G(row,col) = G(row,col-1);
if mod(col,2) == 1
    G(1,col) = G(1,col-1);
end
if mod(row,2) == 1
    G(row,1) = G(row,2);
end

R = im2uint8(R);
G = im2uint8(G);
B = im2uint8(B);

newIm = cat(3, R, G, B);
figure, imshow(newIm); title('Regression Image');

matlab = demosaic(im2uint8(bayerFilter), 'rggb');
figure, imshow(matlab); title('Matlab Demosaic');

%%% ERRORS

%No edge cases
error_regression_noedges = immse(testIm(3:254, 3:382), newIm(3:254, 3:382))
error_matlab_noedges = immse(testIm(3:254, 3:382), matlab(3:254, 3:382))

psnr_regression_noedges = psnr(testIm(3:254, 3:382), newIm(3:254, 3:382))
psnr_matlab_noedges = psnr(testIm(3:254, 3:382), matlab(3:254, 3:382))

%With edge cases
error_regression = immse(testIm, newIm)
error_matlab = immse(testIm, matlab)

psnr_regression = psnr(testIm, newIm)
psnr_matlab = psnr(testIm, matlab)
