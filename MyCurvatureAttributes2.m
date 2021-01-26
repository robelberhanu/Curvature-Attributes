function MyCurvatureAttributes2(grid)

%********************************************************
%*** Curvature Attributes
%***R.Berhanu January '2021
%***1348744@students.wits.ac.za
%********************************************************

InputGrid = dlmread(grid); % This line of code reads the input data passed in a string format.
x = 1; % distance between grid values.
AttributeType = input('Enter MeanCurvature, GaussianCurvature, MinCurvature, MaxCurvature, Curvedness, ShapeIndex, MostPositiveCurvature, MostNegativeCurvature, DipProfile, Strike or Contour:\n ', 's'); % Prompts user to choose type of Attribute.

%******************* Computation of the Mean Curvature Beigns Here*********

[rows,cols] = size(InputGrid);
a1 = zeros(rows,cols);
b1 = zeros(rows,cols);
c1 = zeros(rows,cols);
d1 = zeros(rows,cols);
e1 = zeros(rows,cols);

for I = 2:rows-2
    for J = 2:cols-2
        c21 = InputGrid(I-1:I+1,J-1:J+1);
        % coefficients of the local quadratic surface are calculated with this
        % piece  of code.
        a = (c21(1,1) + c21(1,3) + c21(2,1) + c21(2,3) + c21(3,1) + c21(3,3))/(12*x^2) - (c21(1,2) + c21(2,2) + c21(3,2))/6*x^2;
        b = (c21(1,1) + c21(1,2) + c21(1,3) + c21(3,1) + c21(3,2) + c21(3,3))/(12*x^2) - (c21(2,1) + c21(2,2) + c21(2,3))/6*x^2;
        c = (c21(1,3) + c21(3,1) - c21(1,1) - c21(3,3))/(4*x^2);
        d = (c21(1,3) + c21(2,3) + c21(3,3) - c21(1,1) - c21(2,1) - c21(3,1))/(6*x^2);
        e = (c21(1,1) + c21(1,2) + c21(1,3) - c21(3,1) - c21(3,2) - c21(3,3))/(6*x^2);
        
        a1(I,J)=a;
        b1(I,J)=b;
        c1(I,J)=c;
        d1(I,J)=d;
        e1(I,J)=e;
        
    end
end

if strcmpi('MeanCurvature', AttributeType)
    
    MeanCurvature = (a1.*(1 + e1.^2) + b.*(1 + d1.^2) - c1.*d1.*e)./(1 + d1.^2 + e1.^2).^3/2; % This variable stores the mean curvature values at each point.
    
    figure
    imagesc(InputGrid)
    axis tight
    axis equal
    title('Original Image')
    colormap(jet)
    h = colorbar;
    set(get(h,'title'),'string','/m');
  
    figure;
    J = histeq(MeanCurvature);
    imagesc(J)
    title('Mean Curvature')
    colormap(jet)
    h = colorbar;
    set(get(h,'title'),'string','/m');

    
 
    %***************************************************************************
    
elseif strcmpi('GaussianCurvature',AttributeType)
    
    %******************* Computation of the Gaussian Curvature Beigns Here*********
    
    GaussianCurvature = (4.*a1.*b1 - c1.^2)./(1 + d1.^2 + e1.^2).^2; % This variable stores the Gaussian curvature values at each point.
    
    figure
    imagesc(InputGrid)
    axis tight
    axis equal
    title('Original Image')
    colormap(jet)
    h = colorbar;
    set(get(h,'title'),'string','/m');
  
    figure;
    histogram(GaussianCurvature);
    J = histeq(GaussianCurvature);
    imagesc(J)
    title('Gaussian Curvature')
    colormap(jet)
    h = colorbar;
    set(get(h,'title'),'string','/m');
    

    %***************************************************************************
    
elseif strcmpi('MinCurvature',AttributeType)
    
    %******************* Computation of the Minimum Curvature Beigns Here*********
    
    Gauss = (4.*a1.*b1 - c1.^2)./(1 + d1.^2 + e1.^2).^2;
    Mean = (a1.*(1 + e1.^2) + b1.*(1 + d1.^2) - c1.*d1.*e1)./(1 + d1.^2 + e1.^2).^3/2;
    MinCurvature = abs(Mean - sqrt(Mean.^2 - Gauss));  % This variable stores the Minimum curvature values at each point.
       
    figure
    imagesc(InputGrid)
    axis tight
    axis equal
    title('Original Image')
    colormap(jet), colorbar('vert')
  
    figure;
    J = histeq(MinCurvature);
    imagesc(J)
    title('Minimum Curvature')
    colormap(jet)
    h = colorbar;
    set(get(h,'title'),'string','/m');
    %***************************************************************************
    
elseif strcmpi('MaxCurvature',AttributeType)
    
    %******************* Computation of the Maximum Curvature Beigns Here*********
    
    MeanC = (a1.*(1 + e1.^2) + b1.*(1 + d1.^2) - c1.*d1.*e1)./(1 + d1.^2 + e1.^2).^3/2;
    GaussC = (4.*a1.*b1 - c1.^2)./(1 + d1.^2 + e1.^2).^2;
    MaxCurvature =  abs(MeanC + sqrt(MeanC.^2 - GaussC)); % This variable stores the Maximum curvature values at each point.
    
    
    figure
    imagesc(InputGrid)
    axis tight
    axis equal
    title('Original Image')
    colormap(jet), colorbar('vert')
  
    figure;
    histogram(MaxCurvature);
    J = histeq(MaxCurvature);
    imagesc(J)
    title('Maximim Curvature')
    colormap(jet), colorbar('vert')
    %***************************************************************************
    
elseif strcmpi('Curvedness',AttributeType)
    
    %******************* Computation of the Curvedness Curvature Beigns Here*********
    
    Gauss = (4.*a1.*b1 - c1.^2)./(1 + d1.^2 + e1.^2).^2;
    Mean = (a1.*(1 + e1.^2) + b1.*(1 + d1.^2) - c1.*d1.*e1)./(1 + d1.^2 + e1.^2).^3/2;
    MinC = abs(Mean - sqrt(Mean.^2 - Gauss));
    MeanC = (a1.*(1 + e1.^2) + b1.*(1 + d1.^2) - c1.*d1.*e1)./(1 + d1.^2 + e1.^2).^3/2;
    GaussC = (4.*a1.*b1 - c1.^2)./(1 + d1.^2 + e1.^2).^2;
    MaxC =  abs(MeanC - sqrt(MeanC.^2 - GaussC));
    Curvedness = sqrt((MinC.^2 + MaxC.^2)./2); % This variable stores the Curvedness curvature values at each point.
    
    
    figure
    imagesc(InputGrid)
    axis tight
    axis equal
    title('Original Image')
    colormap(jet), colorbar('vert')
  
    figure
    histogram(Curvedness);
    J = histeq(Curvedness);
    imagesc(J)
    title('The Curvedness')
    colormap(jet)
    h = colorbar;
    set(get(h,'title'),'string','/m');
    %***************************************************************************
    
elseif strcmpi('ShapeIndex',AttributeType)
    %******************* Computation of the Shape Index Curvature Beigns Here*********
    
    Gauss = (4.*a1.*b1 - c1.^2)./(1 + d1.^2 + e1.^2).^2;
    Mean = (a1.*(1 + e1.^2) + b1.*(1 + d1.^2) - c1.*d1.*e1)./(1 + d1.^2 + e1.^2).^3/2;
    MinC = abs(Mean - sqrt(Mean.^2 - Gauss));
    MeanC = (a1.*(1 + e1.^2) + b1.*(1 + d1.^2) - c1.*d1.*e1)./(1 + d1.^2 + e1.^2).^3/2;
    GaussC = (4.*a1.*b1 - c1.^2)./(1 + d1.^2 + e1.^2).^2;
    MaxC =  abs(MeanC - sqrt(MeanC.^2 - GaussC));
    ShapeIndex = (2/pi).*atan((MaxC + MinC)./(MaxC - MinC));  % This variable stores the Shape Index curvature values at each point.
    
    
    figure
    imagesc(InputGrid)
    axis tight
    axis equal
    title('Original Image')
    colormap(jet), colorbar('vert')
  
    figure;
    histogram(ShapeIndex);
    J = histeq(ShapeIndex);
    imagesc(J)
    title('The Shape Index')
    colormap(jet)
    h = colorbar;
    set(get(h,'title'),'string','/m');
    %***************************************************************************
    
elseif strcmpi('MostPositiveCurvature',AttributeType)
    %******************* Computation of the Most Positive Curvature Beigns Here*********
    
    MostPositiveCurvature = (a1 + b1) + sqrt((a1 - b1).^2 + c1.^2); % This variable stores the Most Positive curvature values at each point.
    
    
    figure
    imagesc(InputGrid)
    axis tight
    axis equal
    title('Original Image')
    colormap(jet), colorbar('vert')
  
    figure;
    histogram(MostPositiveCurvature);
    J = histeq(MostPositiveCurvature);
    imagesc(J)
    title('The Most Positive Curvature')
    colormap(jet)
    h = colorbar;
    set(get(h,'title'),'string','/m');
    %***************************************************************************
    
elseif strcmpi('MostNegativeCurvature',AttributeType)
    %******************* Computation of the Most Negative Curvature Beigns Here*********
    
    MostNegativeCurvature = (a1 + b1) - sqrt((a1 - b1).^2 + c1.^2);% This variable stores the Most Negative curvature values at each point.
    
    
    figure
    imagesc(InputGrid)
    axis tight
    axis equal
    title('Original Image')
    colormap(jet), colorbar('vert')
  
    figure;
    histogram(MostNegativeCurvature);
    J = histeq(MostNegativeCurvature);
    imagesc(J)
    title('The Most Negative Curvature')
    colormap(jet)
    h = colorbar;
    set(get(h,'title'),'string','/m');
    %***************************************************************************
    
elseif strcmpi('DipProfile',AttributeType)
    %******************* Computation of the Dip Profile Curvature Beigns Here*********
    DipProfile = (2.*(a1.*d1.^2 + b1.*e1.^2 + c1.*d1.*e))./(d1.^2 + e1.^2).*(1 + d1.^2 + e1.^2).^3/2; % This variable stores the Dip Profile curvature values at each point.
    
    
    figure
    imagesc(InputGrid)
    axis tight
    axis equal
    title('Original Image')
    colormap(jet), colorbar('vert')
  
    figure;
    histogram(DipProfile);
    J = histeq(DipProfile);
    imagesc(J)
    title('The Dip Profile')
    colormap(jet)
    h = colorbar;
    set(get(h,'title'),'string','/m');
    
    %***************************************************************************
    
elseif strcmpi('Strike',AttributeType)
    %******************* Computation of the Strike Curvature Beigns Here*********
    
    Strike = (2.*(a1.*e1.^2 + b1.*d1.^2 - c1.*d1.*e1))./(d1.^2 + e1.^2).*(1 + d1.^2 + e1.^2).^1/2;  % This variable stores the Strike curvature values at each point.
    
   figure
    imagesc(InputGrid)
    axis tight
    axis equal
    title('Original Image')
    colormap(jet), colorbar('vert')
  
    figure;
    histogram(Strike);
    J = histeq(Strike);
    imagesc(J)
    title('The Strike Curvature')
    colormap(jet)
    h = colorbar;
    set(get(h,'title'),'string','/m');
    %***************************************************************************
    
elseif strcmpi('Contour',AttributeType)
    %******************* Computation of the Contour Curvature Beigns Here*********
    
    Contour = 2.*(a1.*e1.^2 + b1.*d1.^2 -c1.*d1.*e1)./(d1.^2 + e1.^2).^3/2; % This variable stores the Contour curvature values at each point.
    
    
    figure
    imagesc(InputGrid)
    axis tight
    axis equal
    title('Original Image')
    colormap(jet), colorbar('vert')
  
    figure;
    histogram(Contour);
    J = histeq(Contour);
    imagesc(J)
    title('Contour')
    colormap(jet)
     h = colorbar;
    set(get(h,'title'),'string','/m');
end
%***************************************************************************

end