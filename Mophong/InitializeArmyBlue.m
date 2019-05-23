function [b_Image,b_Alpha, BluePlot]=InitializeArmyBlue()
global ArmyBlue;
global ImageWidth;

[b_Image, ~, b_Alpha]	= imread('bird_b.png');
b_Image = imresize(b_Image, [ImageWidth ImageWidth], 'lanczos3' );
b_Alpha = imresize(b_Alpha, [ImageWidth ImageWidth], 'lanczos3' );


for BoidIndex = 1 : 5
    angle = atan(ArmyBlue(BoidIndex,2) / ArmyBlue(BoidIndex,1)) * 180 / pi - 90;	% imrotate rotates ccw     
    img_i = imrotate(b_Image, angle);
    alpha_i = imrotate(b_Alpha, angle );
    BluePlot(BoidIndex) = image(ArmyBlue(BoidIndex,1)- ImageWidth/2, ArmyBlue(BoidIndex,2)-ImageWidth/2, img_i);
    BluePlot(BoidIndex).AlphaData = alpha_i;   
end
% %Ve quan do
% for BoidIndex = 1: BoidsNum
%     RedLocation(BoidIndex)=plot(ArmyRed(BoidIndex,1), ArmyRed(BoidIndex,2), 'o','MarkerSize',5, 'MarkerFaceColor','r','Color','r');
% end
% %Ve con tin
% 
%     CLocation = plot(ArmyRed(11,1), ArmyRed(11,2), 'o','MarkerSize',5, 'MarkerFaceColor','m','Color','m');
%     
% % Ve quan xanh
% for i = 3:5
%     BlueLocation(i) = plot(ArmyBlue(i,1), ArmyBlue(i,2), 'o','MarkerSize',5, 'MarkerFaceColor','b','Color','b');
% end
