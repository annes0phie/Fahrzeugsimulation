x0 = [0;30];
dt = 1*10^(-3);
A = [1;0];
Ad = eye(2) + A * dt;
Bd = [dt^2/2;dt];
C = eye(2);
D = [0;0];

m = 1550;
theta = 2800;
Cv = 75000;
Ch = 150000;
h = 0.5;
l = 2.8;
lv = 1.344;
lh = 1.456;
g = 9.81;
%psi = 0.48;

psi = lv/l;
chi = h/l;

 
z_top =(psi/chi);
z_bottom = (-((1-psi)/chi));


z = z_bottom:0.1:z_top;
FBv = (z.*(1-psi+z.*chi));
FBh = (z.*(psi-z.*chi));
plot(FBv,FBh);

acc_brakes = [ 0 0 0 1 8 8];
acc_breakpoints = 0:1:5;
% sim('startFahrdym');
% 
% figure;
% plot(t,a);
% figure;
% plot(t,v);
% figure;
% plot(t,s);

rSoll = 35;
deltaH = 0:0.02:6;
deltaControl = 1;
v=27;
mDivTheta = m / theta;
SG = 0.1;
EG =0;
ChStern = 1./(g*SG); %20.5518;
% ChStern = 1 ./ (g * SG);
CvStern = convGradToCStern(EG, 0, g, ChStern);
I_s =16;


