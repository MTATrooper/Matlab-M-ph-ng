function RedrawGraphics(ArmyRed,RedNum,r_Image,r_Alpha,RedPlot,ArmyBlue,BlueNum,b_Image,b_Alpha,BluePlot)
global EnvironmentWidth;
global ImageWidth;
global TimeSteps;
global blueImg redImg;

for BoidIndex = 1 : BlueNum
    if(blueImg(1,BoidIndex)>0)
        [b_Image, ~, b_Alpha]	= imread('Empty.png');
        b_Image = imresize(b_Image, [ImageWidth ImageWidth], 'lanczos3' );
        b_Alpha = imresize(b_Alpha, [ImageWidth ImageWidth], 'lanczos3' );
    else
        [b_Image, ~, b_Alpha]	= imread('bird_b.png');
        b_Image = imresize(b_Image, [ImageWidth ImageWidth], 'lanczos3' );
        b_Alpha = imresize(b_Alpha, [ImageWidth ImageWidth], 'lanczos3' );
    end
    b_angle = ArmyBlue(BoidIndex,12);
    try
        img_i = imrotate(b_Image, b_angle );
        alpha_i = imrotate(b_Alpha, b_angle );
    catch Me
        disp(' hi')
        b_angle
    end
    
    BluePlot(BoidIndex).CData = img_i;
    BluePlot(BoidIndex).AlphaData = alpha_i;
    
    try
        BluePlot(BoidIndex).XData = ArmyBlue(BoidIndex,1)-ImageWidth/2;
        BluePlot(BoidIndex).YData = ArmyBlue(BoidIndex,2)-ImageWidth/2;
    catch Me
        disp('hi')
        [ArmyBlue(BoidIndex,1),ArmyBlue(BoidIndex,2)]
    end
end
for BoidIndex = 1 : RedNum
    if(redImg(1,BoidIndex)>0)
        [r_Image, ~, r_Alpha]	= imread('Empty.png');
        r_Image = imresize(r_Image, [ImageWidth ImageWidth], 'lanczos3' );
        r_Alpha = imresize(r_Alpha, [ImageWidth ImageWidth], 'lanczos3' );
    else
        [r_Image, ~, r_Alpha]	= imread('bird_r.png');
        r_Image = imresize(r_Image, [ImageWidth ImageWidth], 'lanczos3' );
        r_Alpha = imresize(r_Alpha, [ImageWidth ImageWidth], 'lanczos3' );
    end
    r_angle = ArmyRed(BoidIndex,12);
    try
        img_i = imrotate(r_Image, r_angle );
        alpha_i = imrotate(r_Alpha, r_angle );
    catch Me
        disp(' hi')
        r_angle
    end
    
    RedPlot(BoidIndex).CData = img_i;
    RedPlot(BoidIndex).AlphaData = alpha_i;
    
    try
        RedPlot(BoidIndex).XData = ArmyRed(BoidIndex,1)-ImageWidth/2;
        RedPlot(BoidIndex).YData = ArmyRed(BoidIndex,2)-ImageWidth/2;
    catch Me
        disp('hi')
        [ArmyRed(BoidIndex,1),ArmyRed(BoidIndex,2)]
    end
end
%Ve con tin
    if(redImg(1,8)>0)
        [r_Image, ~, r_Alpha]	= imread('Empty.png');
        r_Image = imresize(r_Image, [ImageWidth ImageWidth], 'lanczos3' );
        r_Alpha = imresize(r_Alpha, [ImageWidth ImageWidth], 'lanczos3' );
    else
        [r_Image, ~, r_Alpha]	= imread('Contin.png');
        r_Image = imresize(r_Image, [ImageWidth ImageWidth], 'lanczos3' );
        r_Alpha = imresize(r_Alpha, [ImageWidth ImageWidth], 'lanczos3' );
    end
    r_angle = ArmyRed(8,12);
    try
        img_i = imrotate(r_Image, r_angle );
        alpha_i = imrotate(r_Alpha, r_angle );
    catch Me
        disp(' hi')
        r_angle
    end
    
    RedPlot(8).CData = img_i;
    RedPlot(8).AlphaData = alpha_i;
    
    try
        RedPlot(8).XData = ArmyRed(8,1)-ImageWidth/2;
        RedPlot(8).YData = ArmyRed(8,2)-ImageWidth/2;
    catch Me
        disp('hi')
        [ArmyRed(8,1),ArmyRed(8,2)]
    end

drawnow;
