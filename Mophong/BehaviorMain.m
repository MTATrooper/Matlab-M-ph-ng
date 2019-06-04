function BehaviorMain()
global TimeSteps;
global ArmyRed;
global ArmyBlue;
global TargetH;
global blueImg redImg;
global ArtHouse;
global BlueMau RedMau;
global Cuuduoc dan;
                        
                        %%%%%%%%%%%%%%%%%%%%%%%
                        %% Khoi tao cac doi tuong va vi tri
[r_Image,r_Alpha,RedPlot]=InitializeArmyRed();
[b_Image,b_Alpha,BluePlot]=InitializeArmyBlue();
% Tao vi tri trien khai bao ve
TargetC = zeros(10,14);
TargetC(1,1) = 0;TargetC(1,2)=-300;
TargetC(2,1) = -100; TargetC(2,2) = -250;
TargetC(3,1) = -100; TargetC(3,2) = -150;
TargetC(4,1) = 0; TargetC(4,2) = -100;
TargetC(5,1) = 100; TargetC(5,2) = -150;
TargetC(6,1) = 100; TargetC(6,2) = -250;
TargetC(7,1) = 0; TargetC(7,2)= -200;
                            %%% GD 1: Giet 2 quan xanh gac cua
timeTick = 1;
danIndex = 0;
while(timeTick < TimeSteps)
    %Cho 2 quan xanh gac tien den quan do
    for BoidIndex = 1:2
        ArmyBlue = updateAtBoundary(ArmyBlue,BoidIndex);
        % steering
        CurrentBoid = ArmyBlue(BoidIndex, :);
        force=steer_arrival(CurrentBoid, TargetH);
        ArmyBlue(BoidIndex,:) = applyForce(CurrentBoid, force);               
    end
    
    % Xac dinh so quan xanh can tan cong
    BlueZ=0;
    BlueMark=zeros(1,2);
    for i=1:2
        if (dist(ArmyBlue(i,:),TargetH)<=300 && blueImg(1,i) == 0)
            BlueMark(1,i)=1;
            BlueZ=BlueZ+1;
        end
    end
    %Dieu quan do ra danh
    RedMark=zeros(1,7);
    for i=1:2
        if (BlueMark(1,i)==1)
            tmpDist1=1000000;tmp1=0;
            tmpDist2=1000000;tmp2=0;
            for j=1:7
                if (RedMark(1,j)==0)
                    tmpZ=dist(ArmyBlue(i,:),ArmyRed(j,:));
                    if (tmpZ<tmpDist1)
                        tmp2=tmp1;tmpDist2=tmpDist1;
                        tmp1=j;tmpDist1=tmpZ;
                    else
                       if (tmpZ<tmpDist2)
                           tmp2=j;tmpDist2=tmpZ;
                       end
                    end
                end                
            end  
            RedMark(1,tmp1)=i;
            RedMark(1,tmp2)=i;        
        end        
    end
    %Cho quan do tien den con tin tren duong di gap quan xanh thi danh
    if(danIndex > 0)
        for j = 1:danIndex
            delete(dan(j));
        end
        danIndex=0;
    end
    dem=0;
    for i = 1: 5
        if(blueImg(1,i)==1)
            dem = dem +1;
        end
    end
    if(dem == 2)
        break;
    end
    for BoidIndex = 1:7
        ArmyRed = updateAtBoundary(ArmyRed,BoidIndex);
        % steering
        
        CurrentBoid = ArmyRed(BoidIndex, :);
        if(RedMark(1,BoidIndex)>0)
            if(dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid)< 300 && dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid)> 290 || dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid)< 150 && dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid)> 140 || dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid) < 80)
                x1 = CurrentBoid(1);
                x2 = ArmyBlue(RedMark(1,BoidIndex),1);
                y1 = CurrentBoid(2);
                y2 = ArmyBlue(RedMark(1,BoidIndex),2);
                danIndex= danIndex+1;
                dan(danIndex) = plot([x1 x2], [y1 y2], 'r-');
                BlueMau(1,RedMark(1,BoidIndex))=BlueMau(1,RedMark(1,BoidIndex))-10;
                if(BlueMau(1,RedMark(1,BoidIndex))<=0)
                    RedMark(1,BoidIndex)=0;
                end
            elseif(dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid)< 170 && dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid)> 160)
                x1 = CurrentBoid(1);
                x2 = ArmyBlue(RedMark(1,BoidIndex),1);
                y1 = CurrentBoid(2);
                y2 = ArmyBlue(RedMark(1,BoidIndex),2);
                danIndex= danIndex+1;
                dan(danIndex) = plot([x1 x2], [y1 y2], 'b-');
                RedMau(1,RedMark(1,BoidIndex))=RedMau(1,RedMark(1,BoidIndex))-20;
            else
                sepr_force=steer_separation(CurrentBoid);
                seek_force = steer_seek(CurrentBoid, ArmyBlue(RedMark(1,BoidIndex),:));
                force=seek_force*0.2+sepr_force*10;
            end
        else
            align_force=steer_alignment(CurrentBoid);
            sepr_force=steer_separation(CurrentBoid); 
            arr_force = steer_arrival(CurrentBoid, TargetC(BoidIndex,:));
            force=arr_force*0.2+align_force*0.05+sepr_force*50;
        end
        ArmyRed(BoidIndex,:) = applyForce(CurrentBoid, force);               
    end
    %Neu het mau thi chet
    for BlueIndex = 1: 2
        if(BlueMau(1,BlueIndex)<=0)
            blueImg(1,BlueIndex) = 1;
        end
    end
    for RedIndex = 1: 2
        if(RedMau(1,RedIndex)<=0)
            redImg(1,RedIndex) = 1;
        end
    end
    RedrawArmy(ArmyRed,7,r_Image,r_Alpha,RedPlot,ArmyBlue,2,b_Image,b_Alpha,BluePlot);
    timeTick = timeTick+1;
    
end
                        %%%GD 2: GIET QUAN XANH TRONG NHA

danIndex = 0;
timeTick = 1;
while(timeTick < TimeSteps)
    %Cho 3 quan xanh tien den quan do
    for BoidIndex = 3:5
        ArmyBlue = updateAtBoundary(ArmyBlue,BoidIndex);
        % steering
        CurrentBoid = ArmyBlue(BoidIndex, :);
        force=steer_arrival(CurrentBoid, TargetH);
        ArmyBlue(BoidIndex,:) = applyForce(CurrentBoid, force);               
    end
    
    % Xac dinh so quan xanh can tan cong
    BlueZ=0;
    BlueMark=zeros(1,5);
    for i=3:5
        if (dist(ArmyBlue(i,:),TargetH)<=400 && blueImg(1,i) == 0)
            BlueMark(1,i)=1;
            BlueZ=BlueZ+1;
        end
    end
    %Dieu quan do ra danh
    RedMark=zeros(1,7);
    for i=3:5
        if (BlueMark(1,i)==1)
            tmpDist1=1000000;tmp1=0;
            tmpDist2=1000000;tmp2=0;
            for j=1:7
                if (RedMark(1,j)==0)
                    tmpZ=dist(ArmyBlue(i,:),ArmyRed(j,:));
                    if (tmpZ<tmpDist1)
                        tmp2=tmp1;tmpDist2=tmpDist1;
                        tmp1=j;tmpDist1=tmpZ;
                    else
                       if (tmpZ<tmpDist2)
                           tmp2=j;tmpDist2=tmpZ;
                       end
                    end
                end                
            end  
            RedMark(1,tmp1)=i;
            RedMark(1,tmp2)=i;        
        end        
    end
    %Cho quan do tien den con tin tren duong di gap quan xanh thi danh
    if(danIndex > 0)
        for j = 1:danIndex
            delete(dan(j));
        end
        danIndex=0;
    end
    dem =0;
    for i=1:7
        if(dist(ArmyRed(i,:),TargetC(i,:))<20)
            dem = dem+1;
        end
    end
    if(dem == 7)
        break;
    end
    for BoidIndex = 1:7
        ArmyRed = updateAtBoundary(ArmyRed,BoidIndex);
        % steering
        CurrentBoid = ArmyRed(BoidIndex, :);
        if(RedMark(1,BoidIndex)>0)
            if(dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid)< 170 && dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid)> 160 || dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid)< 140 && dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid)> 130 || dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid) < 80)
                x1 = CurrentBoid(1);
                x2 = ArmyBlue(RedMark(1,BoidIndex),1);
                y1 = CurrentBoid(2);
                y2 = ArmyBlue(RedMark(1,BoidIndex),2);
                danIndex= danIndex+1;
                dan(danIndex) = plot([x1 x2], [y1 y2], 'r-');
                BlueMau(1,RedMark(1,BoidIndex))=BlueMau(1,RedMark(1,BoidIndex))-10;
                if(BlueMau(1,RedMark(1,BoidIndex))<=0)
                    RedMark(1,BoidIndex)=0;
                end
            elseif(dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid)< 120 && dist(ArmyBlue(RedMark(1,BoidIndex),:),CurrentBoid)> 110)
                x1 = CurrentBoid(1);
                x2 = ArmyBlue(RedMark(1,BoidIndex),1);
                y1 = CurrentBoid(2);
                y2 = ArmyBlue(RedMark(1,BoidIndex),2);
                danIndex= danIndex+1;
                dan(danIndex) = plot([x1 x2], [y1 y2], 'b-');
                RedMau(1,RedMark(1,BoidIndex))=RedMau(1,RedMark(1,BoidIndex))-20;
            else
                force = steer_seek(CurrentBoid, ArmyBlue(RedMark(1,BoidIndex),:));
            end
        else
            align_force=steer_alignment(CurrentBoid);
            sepr_force=steer_separation(CurrentBoid); 
            arr_force = steer_arrival(CurrentBoid, TargetC(BoidIndex,:));
            force=arr_force*0.2+align_force*0.05+sepr_force*50;
        end
        ArmyRed(BoidIndex,:) = applyForce(CurrentBoid, force);               
    end
    %Neu het mau thi  chet
    for BlueIndex = 3: 5
        if(BlueMau(1,BlueIndex)<=0)
            blueImg(1,BlueIndex) = 1;
        end
    end
    for RedIndex = 1: 2
        if(RedMau(1,RedIndex)<=0)
            redImg(1,RedIndex) = 1;
        end
    end
    RedrawArmy(ArmyRed,7,r_Image,r_Alpha,RedPlot,ArmyBlue,5,b_Image,b_Alpha,BluePlot);
    timeTick = timeTick+1;
    
end
Cuuduoc = 1;
                    %%%GD 3: Quay tro ve truc thang
timeTick = 1;
while(timeTick < TimeSteps)
    for BoidIndex = 1:8
        ArmyRed = updateAtBoundary(ArmyRed,BoidIndex);
        % steering
        CurrentBoid = ArmyRed(BoidIndex, :);
        align_force=steer_alignment(CurrentBoid);
        sepr_force=steer_separation(CurrentBoid); 
        arr_force = steer_arrival(CurrentBoid, TargetH);
        force=arr_force*0.2+align_force*0.05+sepr_force*10;
        ArmyRed(BoidIndex,:) = applyForce(CurrentBoid, force);               
    end
    %Den truc thang thi bien mat
    for i = 1:8
        if(dist(ArmyRed(i,:),TargetH) < 40)
            redImg(1,i) = 1;
        end
    end
    RedrawArmy(ArmyRed,7,r_Image,r_Alpha,RedPlot,ArmyBlue,1,b_Image,b_Alpha,BluePlot);
    timeTick = timeTick +1;
    dem =0;
    for i=1:8
        if(redImg(1,i) == 1)
            dem = dem+1;
        end
    end
    if(dem == 8)
        break;
    end
end
                                %%%GD4: Tro ve
Behaviour__Seek_ComeBack ()
end

