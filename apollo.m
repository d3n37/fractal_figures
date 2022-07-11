function S = apollonian_2D(n)
n=ceil(abs(n));
level=ceil(n);
if level==0;
    level = 1; 
end;
h=figure;
hAxs=axes('Parent',h);
axis equal; axis([-1,1,-1,1]);
hold on; grid on; axis on;

% Creating the initial circles depending on user parameter
V=0:2*pi/n:2*pi;
V=V+pi/2;
cosV=cos(V);
sinV=sin(V);
d=sqrt(diff(cosV).^2+diff(sinV).^2);
r=d(1)/2;

coeff=max(max(max(abs(cosV+r)),max(abs(sinV+r))),max(max(abs(cosV-r)),max(abs(sinV-r))));
cosV=cosV/coeff;
sinV=sinV/coeff;
r=r/coeff;
r_inn=sqrt(cosV(1).^2+sinV(1).^2)-r;

S(1).x = [0,0,cosV(1:end-1)];
S(1).y = [0,0,sinV(1:end-1)];
S(1).r = [1,r_inn,r*ones(1,n)];

% Display initial circles
hAxs = plot_circles(hAxs,S,1);

% Creating inversion circles.
x_mid=zeros(1,n);
y_mid=zeros(1,n);
for t=1:n
	x_mid(t) = (cosV(t)+cosV(t+1))/2;
	y_mid(t) = (sinV(t)+sinV(t+1))/2;
    a1 = atan2(sinV(t),cosV(t));
    a2 = atan2(sinV(t+1),cosV(t+1));
    x1 = cosV(t)  +cos(a1)*r;
    y1 = sinV(t)  +sin(a1)*r;
    x2 = cosV(t+1)+cos(a2)*r;
    y2 = sinV(t+1)+sin(a2)*r;
	[xc,yc,rc]=circles_from_3pts(x1,y1,x2,y2,x_mid(t),y_mid(t));
	S_circle.x(t)=xc;
	S_circle.y(t)=yc;
	S_circle.r(t)=rc;
end
S_circle.x(n+1)=0;
S_circle.y(n+1)=0;
S_circle.r(n+1)=sqrt(x_mid(1).^2+y_mid(1).^2);


% Start the creation of the circles for each level.
for i = 1:level-1           % For all level
	% Initiate the structure
    S(i+1).x = [];
    S(i+1).y = [];
    S(i+1).r = [];
    for j=1:size(S(i).x,2) 	% For all circles contain on the i-th level
        for k = 1:n+1       % For all inversion circles
            d = sqrt((S_circle.x(k)-S(i).x(j)).^2+(S_circle.y(k)-S(i).y(j)).^2);
            if d > S_circle.r(k)
                [xi,yi,ri] = inversion_circle(S(i).x(j),S(i).y(j),S(i).r(j),S_circle.x(k),S_circle.y(k),S_circle.r(k));
                if sqrt((xi-S(i).x(j))^2+(yi-S(i).y(j))^2)>S(i).r(j)
                    S(i+1).x  = [S(i+1).x,xi];
                    S(i+1).y  = [S(i+1).y,yi];
                    S(i+1).r  = [S(i+1).r,ri];
                end          
            end
        end
    end
    hAxs = plot_circles(hAxs,S,i+1);    
end

function hAxs = plot_circles(hAxs,S,n,display_style)
if nargin==3
    display_style = 'k-';
end
hold on
for t=1:size(S(n).x,2)
	rectangle('Position',[S(n).x(t)-S(n).r(t),S(n).y(t)-S(n).r(t),2*S(n).r(t),2*S(n).r(t)],'Curvature',[1,1],'LineWidth',0.5,'tag',num2str(n),'Parent',hAxs);         
end

function [xc,yc,Rc] = inversion_circle(x,y,R,x0,y0,R0)
theta = atan2((y-y0),(x-x0));
[x1,y1] = inversion(x+R*cos(theta),y+R*sin(theta),x0,y0,R0);
[x2,y2] = inversion(x-R*cos(theta),y-R*sin(theta),x0,y0,R0);
xc = (x1+x2)/2;
yc = (y1+y2)/2; 
Rc = sqrt((x1-x2)^2+(y1-y2)^2)/2;


function [xn,yn] = inversion(x,y,x0,y0,R0)
d  = sqrt((x-x0).^2+(y-y0).^2);
dn = (R0.^2)./d;

theta = atan2((y-y0),(x-x0));
xn = x0 + dn.*cos(theta);
yn = y0 + dn.*sin(theta);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
function [x,y,r] = circles_from_3pts(x1,y1,x2,y2,x3,y3)



% Checking arguments
% One checks if 2 or 3 points are identical
if (((x1==x2) && (y1==y2)) || ((x1==x3) && (y1==y3)))
    error('2 or 3 points are identical')
end

% One checks if points are not colinear
if atan2((y2-y1),(x2-x1))==atan2((y3-y1),(x3-x1))
    hold on
    plot(x1,y1,'b+',x2,y2,'b+',x3,y3,'b+');
    error('The three points are aligned, infinite radius...')
end

% Center coordinates are obtained solving a linear system.
M = [(x1-x2) (y1-y2);(x1-x3) (y1-y3)];
V = 1/2*[x1^2+y1^2-x2^2-y2^2;x1^2+y1^2-x3^2-y3^2];

Res = M\V;
x   = Res(1);
y   = Res(2);
r = sqrt((x1-x).^2+(y1-y).^2);
if nargin==0
    figure, box on, axis equal, hold on
    plot(x1,y1,'b+',x2,y2,'b+',x3,y3,'b+');
    plot(x,y,'r+',x+r*cos(0:2*pi/300:2*pi),y+r*sin(0:2*pi/300:2*pi),'r');
end