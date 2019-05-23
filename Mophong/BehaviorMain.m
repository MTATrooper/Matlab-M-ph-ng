function BehaviorMain()
global TimeSteps;
global ArmyRed;
global ArmyBlue;
global TargetH;
global blueImg redImg;
global ArtHouse;
global BoidsNum Boids;
                        
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
    for BoidIndex = 1:7
        ArmyRed = updateAtBoundary(ArmyRed,BoidIndex);
        % steering
        CurrentBoid = ArmyRed(BoidIndex, :);
        if(RedMark(1,BoidIndex)>0)
            sepr_force=steer_separation(CurrentBoid);
            seek_force = steer_seek(CurrentBoid, ArmyBlue(RedMark(1,BoidIndex),:));
            force=seek_force*0.2+sepr_force*10;
        else
            align_force=steer_alignment(CurrentBoid);
            sepr_force=steer_separation(CurrentBoid); 
            arr_force = steer_arrival(CurrentBoid, TargetC(BoidIndex,:));
            force=arr_force*0.2+align_force*0.05+sepr_force*50;
        end
        ArmyRed(BoidIndex,:) = applyForce(CurrentBoid, force);               
    end
    %Neu khoang cach la 20 thi quan xanh chet
    for BlueIndex = 1: 2
        for RedIndex = 1: 7
            if(dist(ArmyBlue(BlueIndex,:),ArmyRed(RedIndex,:))<20)
                blueImg(1,BlueIndex) = 1;
                RedMark(1,RedIndex)=0;
            end
        end
    end
    RedrawArmy(ArmyRed,7,r_Image,r_Alpha,RedPlot,ArmyBlue,2,b_Image,b_Alpha,BluePlot);
    timeTick = timeTick+1;
    dem=0;
    for i = 1: 5
        if(blueImg(1,i)==1)
            dem = dem +1;
        end
    end
    if(dem == 2)
        break;
    end
end
                        %%%GD 2: GIET QUAN XANH TRONG NHA

%Xoa nha
delete(ArtHouse);
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
        if (dist(ArmyBlue(i,:),TargetH)<=350 && blueImg(1,i) == 0)
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
    for BoidIndex = 1:7
        ArmyRed = updateAtBoundary(ArmyRed,BoidIndex);
        % steering
        CurrentBoid = ArmyRed(BoidIndex, :);
        if(RedMark(1,BoidIndex)>0)
            force = steer_seek(CurrentBoid, ArmyBlue(RedMark(1,BoidIndex),:));
        else
            align_force=steer_alignment(CurrentBoid);
            sepr_force=steer_separation(CurrentBoid); 
            arr_force = steer_arrival(CurrentBoid, TargetC(BoidIndex,:));
            force=arr_force*0.2+align_force*0.05+sepr_force*50;
        end
        ArmyRed(BoidIndex,:) = applyForce(CurrentBoid, force);               
    end
    %Neu khoang cach la 20 thi quan xanh chet
    for BlueIndex = 3: 5
        for RedIndex = 1: 7
            if(dist(ArmyBlue(BlueIndex,:),ArmyRed(RedIndex,:))<20)
                blueImg(1,BlueIndex) = 1;
                RedMark(1,RedIndex)=0;
            end
        end
    end
    RedrawArmy(ArmyRed,7,r_Image,r_Alpha,RedPlot,ArmyBlue,5,b_Image,b_Alpha,BluePlot);
    timeTick = timeTick+1;
    dem =0;
    for i=1:7
        if(dist(ArmyRed(i,:),TargetC(i,:))<20)
            dem = dem+1;
        end
    end
    if(dem == 7)
        break;
    end
end
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

