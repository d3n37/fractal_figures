function sechn(n)
    l=1;
    figure(1);
    hold on;
    paint(1,1,1,pi,n,0);
    hold off;

function paint(x,y,l,u,n,depth)
        if n>=depth
            depth=depth+1;
            x1=x+l*cos(u);
            y1=y-l*sin(u);
            x2=x+l*sqrt(2)*cos(u+pi/4);
            y2=y-l*sqrt(2)*sin(u+pi/4);
            x3=x+l*cos(u+pi/2);
            y3=y-l*sin(u+pi/2);
            plot([x x1],[y y1],'color','b');
            plot([x1 x2],[y1 y2],'color','r');
            plot([x2 x3],[y2 y3],'color','b');
            plot([x3 x],[y3 y],'color','r');
            paint(x-l*sin(u),y-l*cos(u),l/2,u+pi/3,n,depth);
            paint(x-l*sin(u)+l/2*cos(u+pi/3),y-l*cos(u)-l/2*sin(u+pi/3),l*sqrt(3)/2,u-pi/6,n,depth);
        end
    end
end
