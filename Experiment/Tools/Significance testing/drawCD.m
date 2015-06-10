function drawCD(distanceID)
load CD_outcome.mat;
x=averageRank(distanceID,:);
y=zeros(1,size(x,2))+3;
figure('Position',[300,300,900,600]);
hold on;
plot(x,y,'r+');
x=1:0.5:size(averageRank,2);
y=zeros(1,size(x,2))+3;
plot(x,y,'k+');
plot([1 size(averageRank,2)],[3 3],'k-');
x=1:0.5:size(averageRank,2);
y=zeros(1,size(x,2))+3.1;
string={};
for i=1:size(x,2)
    string=[string,num2str(x(1,i))];
end
text(x-0.05,y,string);
plot([1 1+CD(1,distanceID)],[3.3 3.3],'k-','LineWidth',2);
plot([1 1+CD(1,distanceID)],[3.3 3.3],'k+');
text(1,3.4,'CD');
[x y]=sort(averageRank(distanceID,:));
for i=1:size(x,2)/2
    plot([x(1,i) x(1,i)],[2-(i-1)*0.2 3],'r-');
    plot([0.2 x(1,i)],[2-(i-1)*0.2 2-(i-1)*0.2],'r-');
    text(0.2,2-(i-1)*0.2+0.05,algorithm(1,y(1,i)));
end
for i=size(x,2)/2+1:size(x,2)
    plot([x(1,i) x(1,i)],[2-(size(x,2)-i)*0.2 3],'r-');
    plot([x(1,i) 6.2],[2-(size(x,2)-i)*0.2 2-(size(x,2)-i)*0.2],'r-');
    text(5.8,2-(size(x,2)-i)*0.2+0.05,algorithm(1,y(1,i)));
end
state=zeros(1,size(averageRank,2));
index=0;
for i=1:size(averageRank,2)
    temp=i;
    while(temp<=size(averageRank,2)&&x(1,temp)-x(1,i)<=CD(1,distanceID))
        temp=temp+1;
    end
    isdraw=false;
    temp=temp-1;
    for j=i:temp
        if(state(1,j)==0)
            isdraw=true;
            state(1,j)=1;
        end
    end
    if(isdraw)
        plot([x(1,i)-0.1 x(1,temp)+0.1],[2.8-0.1*index 2.8-0.1*index],'k-','LineWidth',2);
        index=index+1;
    end
end
text(3,1.4,distance_name(1,distanceID));
axis([0 7 0 4]);
end

